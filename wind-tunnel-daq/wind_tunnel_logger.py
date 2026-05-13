# hx711_logger.py
import argparse
import datetime as dt
import re
import sys
import time
import threading
import queue
import math
from pathlib import Path
from collections import deque

import serial
from serial.tools import list_ports

try:
    import matplotlib.pyplot as plt
except Exception:
    plt = None  # habilita plot apenas se matplotlib estiver disponivel

START_TAG = "$PCLOG,START"
STOP_TAG  = "$PCLOG,STOP"

def send_cmd(ser, cmd: str):
    ser.write((cmd.strip() + "\n").encode("ascii", errors="ignore"))
    ser.flush()
    time.sleep(0.03)

def sanitize_name(name: str) -> str:
    return re.sub(r"[^A-Za-z0-9_\-]", "_", name) or "run"

def ensure_logs_dir(save_in_cwd: bool) -> Path:
    base = Path.cwd() if save_in_cwd else Path(__file__).resolve().parent
    out = base / "logs"
    out.mkdir(exist_ok=True)
    return out

def make_filepath(logs_dir: Path, run_name: str) -> Path:
    ts = dt.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    return logs_dir / f"{ts}_{sanitize_name(run_name)}.csv"

def looks_like_csv(line: str) -> bool:
    # CSV vindo do firmware: "t,F1,F2,F3,F4,D,L" + linhas numericas com virgula
    if not line:
        return False
    if line.startswith("t,"):
        return True
    if line.startswith('[') or line.startswith('$'):
        return False
    return ("," in line)

def parse_csv_line(line: str):
    # Espera "t,F1,F2,F3,F4,D,L"
    parts = [p.strip() for p in line.split(",")]
    if len(parts) != 7:
        return None
    def f(x):
        if x == "" or x.upper() == "NA":
            return math.nan
        try:
            return float(x)
        except:
            return math.nan
    try:
        vals = [f(p) for p in parts]
        if not math.isfinite(vals[0]) or vals[0] < 0:
            return None
        return vals  # [t, F1, F2, F3, F4, D, L]
    except:
        return None

def format_csv_row(tsec, f1, f2, f3, f4, d, lsum, delim, decsep, tprec, vprec):
    def fmt(x, prec):
        if x is None or not math.isfinite(x):
            return "NA"
        s = f"{x:.{prec}f}"
        if decsep == ",":
            s = s.replace(".", ",")  # troca decimal para virgula, se solicitado
        return s
    fields = [
        fmt(tsec, tprec),
        fmt(f1, vprec),
        fmt(f2, vprec),
        fmt(f3, vprec),
        fmt(f4, vprec),
        fmt(d,  vprec),
        fmt(lsum, vprec),
    ]
    return delim.join(fields)

def stdin_worker(cmd_q: "queue.Queue[str]"):
    try:
        while True:
            line = sys.stdin.readline()
            if not line:
                break
            cmd_q.put(line.strip())
    except Exception:
        pass

def setup_plot(series_str, window_s):
    if plt is None:
        print("[AVISO] matplotlib nao disponivel; rode: pip install matplotlib")
        return None
    plt.ion()

    # >>> cores invertidas <<<
    plt.style.use('dark_background')  

    fig, ax = plt.subplots()
    valid = ["F1","F2","F3","F4","D","L"]
    req = [s.strip().upper() for s in series_str.split(",") if s.strip()]
    series = [s for s in req if s in valid] or valid
    lines = {}
    buffers = {"t": deque()}
    for s in series:
        buffers[s] = deque()
        lines[s] = ax.plot([], [], label=s)[0]  # sem cor fixa
    ax.set_xlabel("t (s)")
    ax.set_ylabel("Forca (g)")
    ax.grid(True)
    ax.legend(loc="best")
    return {"fig": fig, "ax": ax, "lines": lines, "buffers": buffers, "series": series,
            "window_s": window_s}

def update_plot(plot, t_val, vals_dict, refresh_s):
    if plot is None:
        return True
    fig = plot["fig"]; ax = plot["ax"]; lines = plot["lines"]
    buffers = plot["buffers"]; series = plot["series"]; window_s = plot["window_s"]
    buffers["t"].append(t_val)
    for s in series:
        buffers[s].append(vals_dict.get(s, math.nan))
    while buffers["t"] and (t_val - buffers["t"][0] > window_s):
        buffers["t"].popleft()
        for s in series:
            if buffers[s]:
                buffers[s].popleft()
    for s in series:
        lines[s].set_data(buffers["t"], buffers[s])
    xmin = max(0.0, t_val - window_s)
    xmax = t_val if t_val > window_s else window_s
    ax.set_xlim(xmin, xmax)
    vals_all = []
    for s in series:
        vals_all += [v for v in buffers[s] if v == v]
    if vals_all:
        vmin = min(vals_all); vmax = max(vals_all)
        if vmin == vmax:
            vmin -= 1.0; vmax += 1.0
        pad = 0.05 * (vmax - vmin)
        ax.set_ylim(vmin - pad, vmax + pad)
    plt.pause(refresh_s)
    return plt.fignum_exists(fig.number)

def main():
    ap = argparse.ArgumentParser(description="HX711 CSV logger interativo com grafico ao vivo.")
    ap.add_argument("--port", required=True, help="Porta serial (ex.: COM5)")
    ap.add_argument("--baud", type=int, default=115200, help="Baudrate (default: 115200)")
    ap.add_argument("--name", default="run", help="Nome logico do ensaio (arquivo CSV)")
    ap.add_argument("--rate", type=int, default=None, help="RATE em ms (ex.: 50)")
    ap.add_argument("--auto", action="store_true", help="Liga RATE/PCLOG/STREAM automaticamente.")
    ap.add_argument("--no-interactive", action="store_true", help="Desativa leitura de comandos do teclado.")
    ap.add_argument("--silent", action="store_true", help="Nao ecoa dados da serial no console.")
    ap.add_argument("--save-in-cwd", action="store_true", help="Salva CSV no diretorio atual do CMD (CWD).")
    # CSV
    ap.add_argument("--csv-delim", default=";", help="Delimitador ao salvar CSV (default: ';'). Use ',' para virgula.")
    ap.add_argument("--dec-sep", default=".", choices=[".", ","],
                    help="Separador decimal ao salvar (default: '.').")
    ap.add_argument("--t-prec", type=int, default=3, help="Casas decimais para t (default: 3).")
    ap.add_argument("--val-prec", type=int, default=5, help="Casas decimais para F1..L (default: 5).")
    # Excel hint: escreve 'sep=<'delim'>' na linha 1
    ap.add_argument("--excel-sep-hint", dest="excel_sep_hint", action="store_true",
                    help="Escreve linha 'sep=<delim>' no topo (Excel abre em colunas).")
    ap.add_argument("--no-excel-sep-hint", dest="excel_sep_hint", action="store_false",
                    help="Nao escreve a linha 'sep=<delim>'.")
    ap.set_defaults(excel_sep_hint=True)  # ATIVADO por padrao
    # Plot
    ap.add_argument("--plot", action="store_true", help="Habilita grafico ao vivo.")
    ap.add_argument("--plot-window", type=float, default=30.0, help="Janela de tempo do grafico em s (default: 30).")
    ap.add_argument("--plot-series", default="F1,F2,F3,F4,D,L", help="Series no grafico (ex.: F1,L ou D,L).")
    ap.add_argument("--plot-refresh", type=float, default=0.05, help="Intervalo de atualizacao do grafico em s (default: 0.05).")
    args = ap.parse_args()

    interactive = not args.no_interactive
    logs_dir = ensure_logs_dir(args.save_in_cwd)

    try:
        ser = serial.Serial(args.port, args.baud, timeout=0.5)
    except serial.SerialException as e:
        print(f"[ERRO] Nao consegui abrir {args.port}: {e}")
        print("[DICA] Feche o Serial Monitor/Plotter do Arduino ou outros programas que usam a porta.")
        print("[DICA] Portas disponiveis agora:")
        for p in list_ports.comports():
            print("  -", p.device, "-", p.description)
        sys.exit(1)

    ser.reset_input_buffer()
    ser.reset_output_buffer()
    print(f"[INFO] Conectado em {args.port} @ {args.baud}.")
    if interactive:
        print("[INFO] Interativo: digite comandos (ex.: STATUS | RATE 50 | PCLOG ON teste | STREAM ON).")
        print("[INFO] Ctrl+C para sair. Use --silent para naqo ecoar a saida.")

    cmd_q: "queue.Queue[str]" = queue.Queue()
    if interactive:
        t = threading.Thread(target=stdin_worker, args=(cmd_q,), daemon=True)
        t.start()

    current_file = None
    logging_on = False
    run_name = args.name

    # Plot controlado por STREAM ON/OFF
    plot = None
    plotting_enabled = False  # so abre ao receber STREAM ON (ou --auto enviar)

    warned_plot_format = False

    def open_plot_if_needed():
        nonlocal plot, plotting_enabled
        if not args.plot:
            return
        if plot is None:
            plot = setup_plot(args.plot_series, args.plot_window)
        plotting_enabled = plot is not None

    def close_plot_if_open():
        nonlocal plot, plotting_enabled
        if plot is not None and plt is not None:
            try:
                plt.close(plot["fig"])
            except Exception:
                pass
        plot = None
        plotting_enabled = False

    try:
        if args.auto:
            if args.rate:
                send_cmd(ser, f"RATE {args.rate}")
                if not args.silent: print(f"[TX] RATE {args.rate}")
            send_cmd(ser, f"PCLOG ON {run_name}")
            if not args.silent: print(f"[TX] PCLOG ON {run_name}")
            # Abre a janela de plot ao iniciar o stream
            open_plot_if_needed()
            send_cmd(ser, "STREAM ON")
            if not args.silent: print(f"[TX] STREAM ON")

        while True:
            raw = ser.readline()
            if raw:
                try:
                    line = raw.decode("utf-8", errors="ignore").strip()
                except Exception:
                    line = raw.decode("latin-1", errors="ignore").strip()

                if not args.silent:
                    print(line)

                # START/STOP controlam o arquivo
                if line.startswith(START_TAG):
                    parts = line.split(",", 2)
                    if len(parts) >= 3:
                        run_name = parts[2].strip() or run_name
                    if current_file:
                        try: current_file.close()
                        except:
                            pass
                    filepath = make_filepath(logs_dir, run_name)
                    current_file = open(filepath, "w", newline="", encoding="utf-8-sig")
                    logging_on = True
                    if args.excel_sep_hint:
                        current_file.write(f"sep={args.csv_delim}\n")
                    print(f"[LOG] Iniciado: {filepath}")
                    continue

                if line.startswith(STOP_TAG):
                    if current_file:
                        try:
                            current_file.flush()
                            current_file.close()
                        except:
                            pass
                        print("[LOG] Finalizado e arquivo fechado.")
                    current_file = None
                    logging_on = False
                    continue

                # Aviso se for formato "PLOT ON"
                if (not looks_like_csv(line)) and ("F1:" in line and "F2:" in line) and (not warned_plot_format):
                    print("[AVISO] SaIda esta no formato do Serial Plotter (PLOT ON). Envie 'PLOT OFF' para gerar CSV.")
                    warned_plot_format = True

                # CSV do firmware
                if looks_like_csv(line):
                    if logging_on and current_file:
                        if line.startswith("t,"):
                            # Cabecalho: troca o delimitador
                            header = line if args.csv_delim == "," else line.replace(",", args.csv_delim)
                            current_file.write(header + "\n")
                        else:
                            vals = parse_csv_line(line)
                            if vals:
                                tsec, f1, f2, f3, f4, d, lsum = vals
                                out_line = format_csv_row(
                                    tsec, f1, f2, f3, f4, d, lsum,
                                    args.csv_delim, args.dec_sep, args.t_prec, args.val_prec
                                )
                                try:
                                    current_file.write(out_line + "\n")
                                    if time.time() % 1.0 < 0.02:
                                        current_file.flush()
                                except Exception as e:
                                    print(f"[ERRO] Falha ao escrever: {e}")

                    # plot: so quando habilitado
                    if plotting_enabled:
                        vals = parse_csv_line(line)
                        if vals:
                            tsec, f1, f2, f3, f4, d, lsum = vals
                            vals_dict = {"F1": f1, "F2": f2, "F3": f3, "F4": f4, "D": d, "L": lsum}
                            still_open = update_plot(plot, tsec, vals_dict, args.plot_refresh)
                            if not still_open:
                                plot = None
                                plotting_enabled = False
                                print("[INFO] Janela de grafico fechada; seguindo sem plot.")

            # comandos digitados (interativo)
            if interactive:
                try:
                    cmd = cmd_q.get_nowait()
                except queue.Empty:
                    cmd = None
                if cmd:
                    low = cmd.lower()
                    if low in ("exit", "quit"):
                        raise KeyboardInterrupt
                    if low.startswith(".silent "):
                        val = low.split(None, 1)[1].strip()
                        if val in ("on","1","true"):
                            args.silent = True; print("[LOCAL] silent=ON"); continue
                        if val in ("off","0","false"):
                            args.silent = False; print("[LOCAL] silent=OFF"); continue
                        print("[LOCAL] use: .silent on|off"); continue
                    if low == ".help":
                        print("[LOCAL] .silent on|off | quit/exit"); continue

                    # STREAM ON/OFF -> abre/fecha grafico
                    if cmd.strip().upper() == "STREAM ON":
                        open_plot_if_needed()
                    elif cmd.strip().upper() == "STREAM OFF":
                        close_plot_if_open()

                    send_cmd(ser, cmd)
                    if not args.silent: print(f"[TX] {cmd}")

    except KeyboardInterrupt:
        print("\n[INFO] Interrompido pelo usuario.")
        try:
            send_cmd(ser, "PCLOG OFF")
            send_cmd(ser, "STREAM OFF")
        except Exception:
            pass
    finally:
        if ser and ser.is_open:
            try: ser.close()
            except: pass
        if current_file:
            try:
                current_file.flush()
                current_file.close()
            except:
                pass
        if plt is not None:
            try: plt.close("all")
            except Exception:
                pass
        print("[INFO] Conexao encerrada.")

if __name__ == "__main__":
    main()
