function aero
    % Lê o arquivo de log, remove picos e plota os gráficos (dados brutos),
    % usando apenas UM eixo vertical (força em gramas) para todos os sinais.

    % ======= ARQUIVO DE ENTRADA =======
    filename = '2025-12-07_12-07-08_run.csv';

    % ======= LEITURA BRUTA COMO TEXTO =======
    raw = fileread(filename);

    % Troca vírgula decimal por ponto (para MATLAB entender como número)
    raw = strrep(raw, ',', '.');

    % Separa em linhas
    lines = regexp(raw, '\r\n|\n|\r', 'split');

    % Remove a primeira linha se for "sep=;"
    if ~isempty(lines) && startsWith(strtrim(lines{1}), 'sep=')
        lines(1) = [];
    end

    % Remove possíveis linhas vazias no começo
    while ~isempty(lines) && strlength(strtrim(lines{1})) == 0
        lines(1) = [];
    end

    % Remonta o conteúdo sem a linha "sep=;"
    raw2 = strjoin(lines, '\n');

    % Salva em um arquivo temporário para o readtable
    tempfile = [tempname '.csv'];
    fid = fopen(tempfile, 'w');
    fwrite(fid, raw2);
    fclose(fid);

    % ======= LEITURA COMO TABELA =======
    T = readtable(tempfile, 'Delimiter', ';');

    % Garante que temos pelo menos 7 colunas:
    if width(T) < 7
        error('A tabela possui menos de 7 colunas. Verifique o arquivo de entrada.');
    end

    % Extrai colunas por posição (independe do nome do cabeçalho)
    t_all  = T{:, 1};
    F1_all = T{:, 2};
    F2_all = T{:, 3};
    F3_all = T{:, 4};
    F4_all = T{:, 5};
    D_all  = T{:, 6};
    L_all  = T{:, 7};

    % ======= PARÂMETROS DO FILTRO =======
    limite = 500;   % limite de segurança em |g|
    w      = 11;    % janela da mediana móvel para detecção de picos

    % ======= DETECÇÃO DE PICOS (OUTLIERS) EM CADA CANAL =======
    idxF1 = isoutlier(F1_all, 'movmedian', w);
    idxF2 = isoutlier(F2_all, 'movmedian', w);
    idxF3 = isoutlier(F3_all, 'movmedian', w);
    idxF4 = isoutlier(F4_all, 'movmedian', w);
    idxD  = isoutlier(D_all,  'movmedian', w);
    idxL  = isoutlier(L_all,  'movmedian', w);

    % Amostras que violam limite de amplitude
    idxAmp = (abs(F1_all) > limite) | ...
             (abs(F2_all) > limite) | ...
             (abs(F3_all) > limite) | ...
             (abs(F4_all) > limite) | ...
             (abs(D_all)  > limite) | ...
             (abs(L_all)  > limite);

    % Marca como ruim qualquer amostra com pico em qualquer canal
    idx_out = idxF1 | idxF2 | idxF3 | idxF4 | idxD | idxL | idxAmp;

    % Máscara das amostras boas (sem pico e dentro do limite)
    mask = ~idx_out;

    % Aplica o filtro (dados brutos, só sem outliers)
    t  = t_all(mask);
    F1 = F1_all(mask);
    F2 = F2_all(mask);
    F3 = F3_all(mask);
    F4 = F4_all(mask);
    D  = D_all(mask);
    L  = L_all(mask);

    % ======= OPÇÃO DE INVERTER SINAIS (CONFIGURÁVEL) =======
    invert.F1 = true;
    invert.F2 = true;
    invert.F3 = true;
    invert.F4 = true;
    invert.D  = false;
    invert.L  = true;

    if invert.F1, F1 = -F1; end
    if invert.F2, F2 = -F2; end
    if invert.F3, F3 = -F3; end
    if invert.F4, F4 = -F4; end
    if invert.D,  D  = -D;  end
    if invert.L,  L  = -L;  end

    % ======= Garantir linhas contínuas (sem NaN) =======
    F1 = fillmissing(F1, 'previous');
    F2 = fillmissing(F2, 'previous');
    F3 = fillmissing(F3, 'previous');
    F4 = fillmissing(F4, 'previous');
    D  = fillmissing(D,  'previous');
    L  = fillmissing(L,  'previous');

    % ======= LIMITAR VISUALIZAÇÃO DO GRÁFICO A 120 s =======
    t_max = 65;                    % tempo máximo mostrado
    idx_lim = t <= t_max;           % mantém apenas pontos até t_max

    t  = t(idx_lim);
    F1 = F1(idx_lim);
    F2 = F2(idx_lim);
    F3 = F3(idx_lim);
    F4 = F4(idx_lim);
    D  = D(idx_lim);
    L  = L(idx_lim);

    % ======= OPÇÃO: adicionar offset (em gramas) a partir de um tempo =======
    t_offset = 5;   % tempo [s] a partir do qual o offset passa a valer

    % offsets (em g) que serão aplicados SOMENTE para t >= t_offset
    offset.F1 = -65.51552;
    offset.F2 = 0;
    offset.F3 = -41.45636;
    offset.F4 = 0;
    offset.D  = 0;
    offset.L  = -41.45636 -65.51552;
    % Exemplo:
    % offset.F1 = 10;   % +10 g em F1 depois de 60 s
    % offset.D  = -5;   % -5 g em D depois de 60 s

    idx_off = t >= t_offset;   % máscara lógica

    F1(idx_off) = F1(idx_off) + offset.F1;
    F2(idx_off) = F2(idx_off) + offset.F2;
    F3(idx_off) = F3(idx_off) + offset.F3;
    F4(idx_off) = F4(idx_off) + offset.F4;
    D(idx_off)  = D(idx_off)  + offset.D;
    L(idx_off)  = L(idx_off)  + offset.L;

    % ======= INFO NO CONSOLE =======
    n_total    = numel(t_all);
    n_picos    = nnz(idxF1 | idxF2 | idxF3 | idxF4 | idxD | idxL);
    n_amp      = nnz(idxAmp);
    n_removido = nnz(idx_out);
    n_restante = numel(t);

    fprintf('Amostras originais: %d\n', n_total);
    fprintf('Amostras marcadas como pico (movmedian, janela=%d): %d\n', w, n_picos);
    fprintf('Amostras fora do limite de |valor| > %g g: %d\n', limite, n_amp);
    fprintf('Amostras removidas no total: %d\n', n_removido);
    fprintf('Amostras restantes: %d\n', n_restante);

    if n_restante == 0
        warning('Nenhuma amostra sobrou após o filtro. Verifique parâmetros (w, limite).');
        return;
    end



        % ======= ESTATÍSTICAS: MÉDIA E DESVIO-PADRÃO =======
    % Aqui usamos os sinais já filtrados, invertidos, sem NaN e limitados em t_max

    % média
    mF1 = mean(F1);  mF2 = mean(F2);  mF3 = mean(F3);  mF4 = mean(F4);
    mD  = mean(D);   mL  = mean(L);

    % desvio-padrão (amostral, padrão do MATLAB)
    sF1 = std(F1);   sF2 = std(F2);   sF3 = std(F3);   sF4 = std(F4);
    sD  = std(D);    sL  = std(L);

    % Mostra no console
    fprintf('\n=== ESTATÍSTICAS GERAIS (t <= %.1f s) ===\n', t_max);
    fprintf('F1: média = %.3f g, desvio-padrão = %.3f g\n', mF1, sF1);
    fprintf('F2: média = %.3f g, desvio-padrão = %.3f g\n', mF2, sF2);
    fprintf('F3: média = %.3f g, desvio-padrão = %.3f g\n', mF3, sF3);
    fprintf('F4: média = %.3f g, desvio-padrão = %.3f g\n', mF4, sF4);
    fprintf('D : média = %.3f g, desvio-padrão = %.3f g\n', mD,  sD);
    fprintf('L : média = %.3f g, desvio-padrão = %.3f g\n', mL,  sL);



    % ======= ESTATÍSTICAS EM UMA JANELA ESPECÍFICA DE TEMPO =======
    t_ini = 15;   % início da janela [s]  (ajuste como quiser)
    t_fim = 65;   % fim da janela [s]

    idx_win = (t >= t_ini) & (t <= t_fim);

    sF1_win = std(F1(idx_win));
    sF2_win = std(F2(idx_win));
    sF3_win = std(F3(idx_win));
    sF4_win = std(F4(idx_win));
    sD_win  = std(D(idx_win));
    sL_win  = std(L(idx_win));

    fprintf('\n=== DESVIO-PADRÃO NA JANELA %.1f a %.1f s ===\n', t_ini, t_fim);
    fprintf('F1: %.3f g | F2: %.3f g | F3: %.3f g | F4: %.3f g | D: %.3f g | L: %.3f g\n', ...
            sF1_win, sF2_win, sF3_win, sF4_win, sD_win, sL_win);



    % =====================================================================
    % FIGURA 1 — F1, F2, F3, F4 e D no MESMO eixo (Força [g])
    % =====================================================================
    figure;
    ylim([-350 350]); 
    set(gcf, 'Color', 'w');               % fundo da figura branco
    set(gca, 'Color', 'w');               % fundo do eixo branco
    set(gca, 'GridColor', [0.7 0.7 0.7]); % grid cinza claro

    % Tons de azul (claro → escuro)
    corF1 = [0.95 0.60 0.70];   % roxo suave
    corF2 = [0.80 0.30 0.30];   % vermelho suave
    corF3 = [0.40 0.60 0.90];   % azul médio
    corF4 = [0.05 0.20 0.45];   % azul escuro
    % Cor do arrasto (laranja)
    corD  = [1.00 0.50 0.00];

    hold on;
    p1 = plot(t, F1, 'LineWidth', 1.2, 'Color', corF1, 'LineStyle','-');
    p2 = plot(t, F2, 'LineWidth', 1.2, 'Color', corF2, 'LineStyle','-');
    p3 = plot(t, F3, 'LineWidth', 1.2, 'Color', corF3, 'LineStyle','-');
    p4 = plot(t, F4, 'LineWidth', 1.2, 'Color', corF4, 'LineStyle','-');
    pD = plot(t, D,  'LineWidth', 1.2, 'Color', corD,  'LineStyle','-');
    pL = plot(t, L, 'LineWidth', 1.2, 'Color', [0.00 0.45 0.00], 'LineStyle','-');
    hold off;

    grid on;
    set(gca, 'XColor', 'k', 'YColor', 'k');
    xlabel('Tempo [s]', 'Color', 'k');
    ylabel('Força [g]', 'Color', 'k');
    title('', 'Color', 'k');   % deixe vazio ou coloque um título se quiser

    lg = legend([p1 p2 p3 p4 pD pL], {'F1','F2','F3','F4','D','L'}, 'Location','best');

    set(lg, 'Color', 'w');
    set(lg, 'EdgeColor', 'k');
    set(lg, 'TextColor', 'k');


    % =====================================================================
    % FIGURA 2 — D e L x TEMPO (mesmo eixo Y em [g])
    % =====================================================================

end
