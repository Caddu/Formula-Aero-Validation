#include <HX711.h>
#include <EEPROM.h>
#include <math.h>

// Forward declarations of globals used
extern unsigned long t0;
extern unsigned long lastTick;

// ===== PINOS =====
const byte DT[5]    = {2, 4, 6, 8, 10};
const byte SCKHX[5] = {3, 5, 7, 9, 11};

// ===== OBJETOS =====
HX711 sc[5];

// ===== CONFIG =====
unsigned long sampleIntervalMs = 100; // intervalo do STREAM (ms)
int    avgCal  = 10;                  // media so para CAL
bool   streaming=false, plotMode=false, csvMode=false;

// ===== ESTADO ESCALA =====
float scaleFactor[5] = {1,1,1,1,1};
long  offsetRaw[5]   = {0,0,0,0,0};
float knownWeight[5] = {0,0,0,0,0};
bool  cell_ok[5]     = {true,true,true,true,true};

// ===== Momento =====
bool  momApply=false, momAdapt=false;   // momAdapt = aplica (a,b)
float momSlope[4] = {0,0,0,0};          // a_i
float momInter[4] = {0,0,0,0};          // b_i
uint16_t momN=0; unsigned long momTms=0; bool momCsv=false;

// ===== Buffers de leitura nao-bloqueante =====
float lastGood[5]          = {NAN,NAN,NAN,NAN,NAN};
unsigned long lastUpdMs[5] = {0,0,0,0,0};
const unsigned long STALE_MS = 2000; // marca inativa se >2s sem atualizar

// ===== Serial Parser =====
String cmdBuf; unsigned long lastCharTime=0; const unsigned long CMD_IDLE_MS=150;

// ===== Sinalizacao para script do PC =====
bool   hostLogSignal=false;   // PCLOG ON/OFF
String hostLogName="run";    // nome logico do log (apenas marcador no Serial)

// ===== EEPROM =====
struct PersistData{
  uint32_t magic;          // 0xC0FFEEB9
  float    scale[5];
  long     offs[5];
  uint8_t  flags;          // bit0: momApply, bit1: momAdapt
  float    momSlope[4];
  float    momInter[4];
  uint16_t crc;
};
const uint32_t MAGIC=0xC0FFEEB9;
const int EEPROM_ADDR=0;

uint16_t crc16_update(uint16_t crc, uint8_t a){ crc^=a; for(int i=0;i<8;i++) crc=(crc&1)?(crc>>1)^0xA001:(crc>>1); return crc; }
uint16_t calcCRC(const PersistData &p){ const uint8_t* b=(const uint8_t*)&p; size_t n=sizeof(PersistData)-sizeof(uint16_t); uint16_t crc=0xFFFF; for(size_t i=0;i<n;i++) crc=crc16_update(crc,b[i]); return crc; }
void saveEEPROM(){
  PersistData p; p.magic=MAGIC;
  for(int i=0;i<5;i++){ p.scale[i]=scaleFactor[i]; p.offs[i]=offsetRaw[i]; }
  p.flags=0; if(momApply) p.flags|=0x01; if(momAdapt) p.flags|=0x02;
  for(int i=0;i<4;i++){ p.momSlope[i]=momSlope[i]; p.momInter[i]=momInter[i]; }
  p.crc=calcCRC(p); EEPROM.put(EEPROM_ADDR,p);
  Serial.println(F("[OK] EEPROM salva."));
}
bool loadEEPROM(){
  PersistData p; EEPROM.get(EEPROM_ADDR,p);
  if(p.magic!=MAGIC || calcCRC(p)!=p.crc) return false;
  for(int i=0;i<5;i++){ scaleFactor[i]=p.scale[i]; offsetRaw[i]=p.offs[i]; }
  momApply=(p.flags&0x01)!=0; momAdapt=(p.flags&0x02)!=0;
  for(int i=0;i<4;i++){ momSlope[i]=p.momSlope[i]; momInter[i]=p.momInter[i]; }
  Serial.println(F("[OK] EEPROM carregada."));
  return true;
}
void applyScaleOffsets(){ for(int i=0;i<5;i++){ sc[i].set_scale(scaleFactor[i]); sc[i].set_offset(offsetRaw[i]); }}

// ===== Utils =====
int idxFromStr(const String &s){ if(!s.length()) return -1; int k=s.toInt(); return (k>=1&&k<=5)?k-1:-1; }
void printVal3(float x){ if(isnan(x)) Serial.print(F("NA")); else Serial.print(x,3); }
void printVal5(float x){ if(isnan(x)) Serial.print(F("0")); else Serial.print(x,5); }
bool hasValidMomCal(){ for(int i=0;i<4;i++) if(isfinite(momSlope[i])&&isfinite
(momInter[i])&&(momSlope[i]!=0||momInter[i]!=0)) return true; return false; }

bool waitReadyTimeout(int i, unsigned long to_ms){ unsigned long t0=millis(); while(!sc[i].is_ready()){ if(millis()-t0>to_ms) return false; delay(1);} return true; }

// ===== Leitura NAO-BLOQUEANTE =====
inline void pollOne(int i){
  if(!cell_ok[i]) return;
  if(sc[i].is_ready()){
    float v=sc[i].get_units(1);
    if(isfinite(v)){ lastGood[i]=v; lastUpdMs[i]=millis(); }
  }
  if(millis()-lastUpdMs[i] > STALE_MS) cell_ok[i]=false;
}
void pollAll(){ for(int i=0;i<5;i++) pollOne(i); }

// Semeia leituras boas no boot/LOAD/CAL
void primeReadAll(unsigned long to_ms_per_cell=800){
  for(int i=0;i<5;i++){
    if(waitReadyTimeout(i,to_ms_per_cell)){
      float v=sc[i].get_units(1);
      lastGood[i]=v; lastUpdMs[i]=millis(); cell_ok[i]=true;
    } else {
      cell_ok[i]=false;
      Serial.print(F("[WARN] C")); Serial.print(i+1); Serial.println(F(" sem resposta no primeRead."));
    }
  }
}

// Pequeno burst para atualizar antes de um READ
void burstPollMs(unsigned long ms){ unsigned long t0=millis(); while((millis()-t0)<ms){ pollAll(); delay(1);} }

// ===== Saida corrigida (aplica MOM e FLIP em runtime se momAdapt) =====
void computeOutputs(float &F1,float &F2,float &F3,float &F4,float &D,float &L){
  float v[5]; for(int i=0;i<5;i++) v[i]=lastGood[i];
  bool apply = momApply || momAdapt;
  float out[4];
  if(apply){
    float Dnow=v[4];
    for(int i=0;i<4;i++){
      float base=v[i];
      if(isfinite(base)&&isfinite(Dnow)) out[i]=base - (momSlope[i]*Dnow + momInter[i]);
      else out[i]=base;
      if(momAdapt && isfinite(out[i])) out[i] = out[i]; // FLIP runtime F1..F4 //No FLIP at now
    }
  } else {
    for(int i=0;i<4;i++) out[i]=v[i];
  }
  F1=out[0]; F2=out[1]; F3=out[2]; F4=out[3]; D=v[4];
  L=0; if(!isnan(out[0])) L+=out[0]; if(!isnan(out[1])) L+=out[1]; if(!isnan(out[2])) L+=out[2]; if(!isnan(out[3])) L+=out[3];
}

// ===== MOMCAL helpers (nao-bloqueante) =====
static bool readInstantAll_window(float &f1,float &f2,float &f3,float &f4,float &d, unsigned long window_ms){
  unsigned long t0 = millis();
  float tmp[5] = {NAN,NAN,NAN,NAN,NAN};
  bool gotD = false;
  while ((millis() - t0) < window_ms && !gotD) {
    if (sc[4].is_ready()) { tmp[4] = sc[4].get_units(1); gotD = true; }
    for (int i=0;i<4;i++) if (isnan(tmp[i]) && sc[i].is_ready()) tmp[i] = sc[i].get_units(1);
    delay(1);
  }
  for (int i=0;i<4;i++) if (isnan(tmp[i]) && sc[i].is_ready()) tmp[i] = sc[i].get_units(1);
  f1=tmp[0]; f2=tmp[1]; f3=tmp[2]; f4=tmp[3]; d=tmp[4];
  return gotD;
}

void doMomentCalibration(unsigned long t_ms, uint16_t N){
  if (N < 5) N = 5; if (t_ms < 50) t_ms = 50;
  unsigned long dt = t_ms / N; if (dt < 5) dt = 5;

  bool wasStreaming = streaming; streaming = false;
  bool wasAdapt     = momAdapt;  momAdapt   = false;

  uint16_t n[4] = {0,0,0,0};
  double meanD[4] = {0,0,0,0};
  double meanF[4] = {0,0,0,0};
  double Sxx[4]   = {0,0,0,0};
  double Sxy[4]   = {0,0,0,0};

  unsigned long tStart = millis();
  if (momCsv) Serial.println(F("t,F1,F2,F3,F4,D"));

  for (uint16_t k = 0; k < N; ++k) {
    unsigned long tSampleStart = millis();
    unsigned long tGoal = tSampleStart + dt;

    unsigned long win = dt/2; if (win > 120) win = 120; if (win < 20) win = 20;

    float f1,f2,f3,f4,d;
    bool gotD = readInstantAll_window(f1,f2,f3,f4,d, win);

    if (momCsv) {
      float tsec = (millis() - tStart)/1000.0f;
      Serial.print(tsec,3); Serial.print(',');
      float ff[4]={f1,f2,f3,f4};
      for (int i=0;i<4;i++){ if (isnan(ff[i])||!isfinite(ff[i])) Serial.print(""); else Serial.print(ff[i],5); Serial.print(','); }
      if (isnan(d)||!isfinite(d)) Serial.println(""); else Serial.println(d,5);
    }

    if (gotD && isfinite(d)) {
      float ff[4] = {f1,f2,f3,f4};
      for (int i=0;i<4;i++) if (!isnan(ff[i]) && isfinite(ff[i])) {
        n[i]++;
        double Di_prevMean = meanD[i];
        double Fi_prevMean = meanF[i];
        meanD[i] += (((double)d)    - meanD[i]) / (double)n[i];
        meanF[i] += (((double)ff[i]) - meanF[i]) / (double)n[i];
        double dD = ((double)d)     - Di_prevMean;
        double dF = ((double)ff[i]) - Fi_prevMean;
        Sxx[i]   += dD * ( ((double)d)     - meanD[i] );
        Sxy[i]   += dD * ( ((double)ff[i]) - meanF[i] );
      }
    }

    while ((long)(tGoal - millis()) > 0) { pollAll(); delay(1); }
  }

  momTms = t_ms; uint16_t minN = 0xFFFF;
  Serial.println(F("===== MOMCAL resultado (robusta) ====="));
  for (int i=0;i<4;i++) {
    if (n[i] < minN) minN = n[i];
    const double VAR_EPS = 1e-6;
    if (n[i] < 5 || fabs(Sxx[i]) < VAR_EPS) {
      momSlope[i] = 0.0f; momInter[i] = (float)meanF[i];
      Serial.print(F("C")); Serial.print(i+1); Serial.println(F(": variacao de D insuficiente/poucas amostras -> a=0, b=mean(F)"));
      continue;
    }
    double a = Sxy[i] / Sxx[i];
    double b = meanF[i] - a * meanD[i];
    if (!isfinite(a) || fabs(a) > 1e3) a = 0.0;
    if (!isfinite(b) || fabs(b) > 1e5) b = 0.0;
    momSlope[i] = (float)a; momInter[i] = (float)b;
    Serial.print(F("C")); Serial.print(i+1); Serial.print(F(": a=")); Serial.print(momSlope[i],6); Serial.print(F("  b=")); Serial.println(momInter[i],6);
  }
  momN = (minN==0xFFFF ? 0 : minN);
  Serial.print(F("N(min por canal)=")); Serial.println(momN);
  Serial.print(F("T(ms)=")); Serial.println(momTms);
  Serial.println(F("[OK] Use MOMAPPLY ON ou MOMADAPT ON (flip) e SAVE para persistir."));

  momAdapt   = wasAdapt;
  streaming  = wasStreaming;
}

// ===== HELP / STATUS =====
void printHelp(){
  Serial.println(F("==== Comandos ===="));
  Serial.println(F("HELP, STATUS"));
  Serial.println(F("SETWEIGHT <i> <val>   | CAL <i>|ALL       | SETSCALE <i> <val> | SHOWSCALE"));
  Serial.println(F("FLIP <i>|ALL          | TARE <i>|ALL      | SCAN               | ENABLE <i> ON|OFF"));
  Serial.println(F("MOMCAL <t_ms> <n>     | MOMCSV ON|OFF     | MOMAPPLY ON|OFF    | MOMSTATUS"));
  Serial.println(F("MOMADAPT ON|OFF|STATUS| PLOT ON|OFF       | CSV ON|OFF | CSVHEADER"));
  Serial.println(F("PCLOG ON [nome]|OFF   -> envia marcadores p/ script do PC iniciar/parar log"));
  Serial.println(F("READ                  | STREAM ON|OFF     | RATE <ms>          | AVGCAL <n>"));
}
void printStatus(){
  Serial.println(F("==== STATUS ===="));
  Serial.print(F("STREAM: ")); Serial.println(streaming?F("ON"):F("OFF"));
  Serial.print(F("PLOT: "));   Serial.println(plotMode?F("ON"):F("OFF"));
  Serial.print(F("CSV: "));    Serial.println(csvMode?F("ON"):F("OFF"));
  Serial.print(F("PCLOG: "));  Serial.print(hostLogSignal?F("ON (nome=\""):F("OFF")); if(hostLogSignal){ Serial.print(hostLogName); Serial.print(F("\")")); } Serial.println();
  Serial.print(F("RATE: "));   Serial.print(sampleIntervalMs); Serial.println(F(" ms"));
  Serial.println(F("Celulas (age):"));
  for(int i=0;i<5;i++){
    Serial.print(F(" C")); Serial.print(i+1); Serial.print(F(": "));
    if(cell_ok[i]){ Serial.print(F("OK, ")); Serial.print(millis()-lastUpdMs[i]); Serial.println(F("ms")); }
    else Serial.println(F("INATIVA"));
  }
  Serial.print(F("MOMAPPLY: ")); Serial.println(momApply?F("ON"):F("OFF"));
  Serial.print(F("MOMADAPT: ")); Serial.println(momAdapt?F("ON"):F("OFF"));
  Serial.println(F("Momento (a_i, b_i):"));
  for(int i=0;i<4;i++){ Serial.print(F(" C")); Serial.print(i+1); Serial.print(F(": a=")); Serial.print(momSlope[i],6); Serial.print(F(" b=")); Serial.println(momInter[i],6);}  
  Serial.print(F("MOM N(min)=")); Serial.print(momN); Serial.print(F("  T(ms)=")); Serial.println(momTms);
  Serial.println(F("================"));
}

// ===== SERIAL =====
void handleCommand(String line);
void readAndDispatchSerial(){
  while(Serial.available()){
    char c=(char)Serial.read();
    if(c=='\r'||c=='\n'){
      if(cmdBuf.length()>0){ String line=cmdBuf; cmdBuf=""; handleCommand(line); }
    } else { cmdBuf+=c; lastCharTime=millis(); }
  }
  if(cmdBuf.length()>0 && (millis()-lastCharTime)>CMD_IDLE_MS){ String line=cmdBuf; cmdBuf=""; handleCommand(line); }
}

// ===== PARSER =====
void handleCommand(String line){
  line.trim(); line.toUpperCase(); if(!line.length()) return;
  int sp=line.indexOf(' '); String cmd=(sp<0)?line:line.substring(0,sp); String rest=(sp<0)?"":line.substring(sp+1); rest.trim();

  if(cmd=="HELP"){ printHelp(); return; }
  if(cmd=="STATUS"){ printStatus(); return; }

  if(cmd=="SETWEIGHT"){
    int s=rest.indexOf(' '); if(s<0){ Serial.println(F("[ERRO] SETWEIGHT <i> <valor>")); return; }
    int i=idxFromStr(rest.substring(0,s)); if(i<0){ Serial.println(F("[ERRO] i=1..5")); return; }
    knownWeight[i]=rest.substring(s+1).toFloat();
    Serial.print(F("[OK] Peso C")); Serial.print(i+1); Serial.print(F(" = ")); Serial.println(knownWeight[i],6); return;
  }

  if(cmd=="SETSCALE"){
    int s=rest.indexOf(' '); if(s<0){ Serial.println(F("[ERRO] SETSCALE <i> <valor>")); return; }
    int i=idxFromStr(rest.substring(0,s)); if(i<0){ Serial.println(F("[ERRO] i=1..5")); return; }
    float v=rest.substring(s+1).toFloat(); scaleFactor[i]=v; sc[i].set_scale(v);
    Serial.print(F("[OK] Fator C")); Serial.print(i+1); Serial.print(F(" = ")); Serial.println(v,6); return;
  }

  if(cmd=="SHOWSCALE"){
    Serial.println(F("=== Fatores (RAW/unidade) ==="));
    for(int i=0;i<5;i++){ Serial.print(F("C")); Serial.print(i+1); Serial.print(F(": ")); Serial.println(scaleFactor[i],6); }
    return;
  }

  if(cmd=="CAL"){
    if(rest=="ALL"){
      for(int i=0;i<5;i++){
        if(knownWeight[i]==0){ Serial.print(F("[AVISO] C")); Serial.print(i+1); Serial.println(F(": peso=0 (ignorado)")); continue; }
        if(!waitReadyTimeout(i,1000)){ Serial.print(F("[WARN] C")); Serial.print(i+1); Serial.println(F(" sem resposta.")); continue; }
        long raw=sc[i].get_value(avgCal); float factor=(float)raw/knownWeight[i];
        scaleFactor[i]=factor; sc[i].set_scale(factor);
        float v=sc[i].get_units(1); lastGood[i]=v; lastUpdMs[i]=millis(); cell_ok[i]=true;
        Serial.print(F("C")); Serial.print(i+1); Serial.print(F(" RAW=")); Serial.print(raw);
        Serial.print(F(" Peso=")); Serial.print(knownWeight[i],6); Serial.print(F(" -> Fator=")); Serial.println(factor,6);
      }
      Serial.println(F("[OK] Use SAVE p/ persistir.")); return;
    } else {
      int i=idxFromStr(rest); if(i<0){ Serial.println(F("[ERRO] CAL <i>|ALL")); return; }
      if(knownWeight[i]==0){ Serial.println(F("[ERRO] Defina SETWEIGHT antes.")); return; }
      if(!waitReadyTimeout(i,1000)){ Serial.println(F("[WARN] Celula sem resposta.")); return; }
      long raw=sc[i].get_value(avgCal); float factor=(float)raw/knownWeight[i];
      scaleFactor[i]=factor; sc[i].set_scale(factor);
      float v=sc[i].get_units(1); lastGood[i]=v; lastUpdMs[i]=millis(); cell_ok[i]=true;
      Serial.print(F("C")); Serial.print(i+1); Serial.print(F(" RAW=")); Serial.print(raw);
      Serial.print(F(" Peso=")); Serial.print(knownWeight[i],6); Serial.print(F(" -> Fator=")); Serial.println(factor,6);
      Serial.println(F("[OK] Use SAVE p/ EEPROM.")); return;
    }
  }

  if(cmd=="FLIP"){
    if(rest=="ALL"){ for(int i=0;i<5;i++){ scaleFactor[i]=-scaleFactor[i]; sc[i].set_scale(scaleFactor[i]); } Serial.println(F("[OK] FLIP ALL (persistente).")); return; }
    int i=idxFromStr(rest); if(i<0){ Serial.println(F("[ERRO] FLIP <i>|ALL")); return; }
    scaleFactor[i]=-scaleFactor[i]; sc[i].set_scale(scaleFactor[i]);
    Serial.print(F("[OK] FLIP C")); Serial.println(i+1); return;
  }

  if(cmd=="TARE"){
    if(rest=="ALL"){
      for(int i=0;i<5;i++){
        if(waitReadyTimeout(i,1000)){ sc[i].tare(); offsetRaw[i]=sc[i].get_offset(); cell_ok[i]=true; lastUpdMs[i]=millis(); }
        else { cell_ok[i]=false; Serial.print(F("[WARN] C")); Serial.print(i+1); Serial.println(F(" sem resposta no TARE.")); }
      }
      primeReadAll(800); Serial.println(F("[OK] TARE ALL.")); return;
    } else {
      int i=idxFromStr(rest); if(i<0){ Serial.println(F("[ERRO] TARE <i>|ALL")); return; }
      if(waitReadyTimeout(i,1000)){ sc[i].tare(); offsetRaw[i]=sc[i].get_offset(); cell_ok[i]=true; lastUpdMs[i]=millis(); float v=sc[i].get_units(1); lastGood[i]=v; Serial.print(F("[OK] TARE C")); Serial.println(i+1); }
      else { cell_ok[i]=false; Serial.print(F("[WARN] C")); Serial.print(i+1); Serial.println(F(" sem resposta.")); }
      return;
    }
  }

  if(cmd=="MOMCAL"){
    int s=rest.indexOf(' '); if(s<0){ Serial.println(F("[ERRO] MOMCAL <t_ms> <n>")); return; }
    unsigned long tms=(unsigned long)rest.substring(0,s).toInt();
    uint16_t n=(uint16_t)rest.substring(s+1).toInt(); if(n==0){ Serial.println(F("[ERRO] n>0")); return; }
    doMomentCalibration(tms,n); primeReadAll(800); return;
  }

  if(cmd=="MOMCSV"){
    if(rest=="ON"){ momCsv=true; Serial.println(F("[OK] MOMCSV ON")); return; }
    if(rest=="OFF"){ momCsv=false; Serial.println(F("[OK] MOMCSV OFF")); return; }
    Serial.println(F("[ERRO] MOMCSV ON|OFF")); return;
  }

  if(cmd=="MOMAPPLY"){
    if(rest=="ON"){ momApply=true; Serial.println(F("[OK] MOMAPPLY ON")); return; }
    if(rest=="OFF"){ momApply=false; Serial.println(F("[OK] MOMAPPLY OFF")); return; }
    Serial.println(F("[ERRO] MOMAPPLY ON|OFF")); return;
  }

  if(cmd=="MOMSTATUS"){ printStatus(); return; }

  if(cmd=="MOMADAPT"){
    if(rest=="ON"){ if(!hasValidMomCal()) Serial.println(F("[AVISO] Rode MOMCAL antes; (a_i,b_i)=0.")); momAdapt=true; momApply=true; Serial.println(F("[OK] MOMADAPT ON: aplica (a_i,b_i)")); return; }
    if(rest=="OFF"){ momAdapt=false; Serial.println(F("[OK] MOMADAPT OFF.")); return; }
    if(rest=="STATUS"){ Serial.print(F("MOMADAPT: ")); Serial.println(momAdapt?F("ON"):F("OFF")); return; }
    Serial.println(F("[ERRO] MOMADAPT ON|OFF|STATUS")); return;
  }

  if(cmd=="PLOT"){ if(rest=="ON"){ plotMode=true; Serial.println(F("[OK] PLOT ON")); return; } if(rest=="OFF"){ plotMode=false; Serial.println(F("[OK] PLOT OFF")); return; } Serial.println(F("[ERRO] PLOT ON|OFF")); return; }

  if(cmd=="CSV"){ if(rest=="ON"){ csvMode=true; Serial.println(F("[OK] CSV ON")); return; } if(rest=="OFF"){ csvMode=false; Serial.println(F("[OK] CSV OFF")); return; } Serial.println(F("[ERRO] CSV ON|OFF")); return; }
  if(cmd=="CSVHEADER"){ Serial.println(F("t,F1,F2,F3,F4,D,L")); return; }

  if(cmd=="PCLOG"){
    if(rest.startsWith("ON")){
      // Pode vir "ON" ou "ON <nome>"
      String tail=rest.substring(2); tail.trim(); if(tail.length()>0) hostLogName=tail; else hostLogName="run";
      hostLogSignal=true; t0=0; // reinicia relogio do CSV
      Serial.print(F("$PCLOG,START,")); Serial.println(hostLogName);
      Serial.println(F("t,F1,F2,F3,F4,D,L")); // header p/ script
      csvMode=true; // garante saida em CSV
      Serial.println(F("[OK] PCLOG ON (inicie o script no PC para salvar)."));
      return;
    } else if(rest=="OFF"){
      hostLogSignal=false; Serial.println(F("$PCLOG,STOP")); Serial.println(F("[OK] PCLOG OFF.")); return;
    } else { Serial.println(F("[ERRO] PCLOG ON [nome] | OFF")); return; }
  }

  if(cmd=="SCAN"){
    for(int i=0;i<5;i++){
      bool ready=waitReadyTimeout(i,200);
      cell_ok[i]=ready; Serial.print(F("C")); Serial.print(i+1); Serial.print(F(": "));
      if(ready){ Serial.println(F("OK")); } else { Serial.println(F("NAO PRONTA")); }
    }
    return;
  }

  if(cmd=="ENABLE"){
    int s=rest.indexOf(' '); if(s<0){ Serial.println(F("[ERRO] ENABLE <i> ON|OFF")); return; }
    int i=idxFromStr(rest.substring(0,s)); String sw=rest.substring(s+1);
    if(i<0){ Serial.println(F("[ERRO] i=1..5")); return; }
    if(sw=="ON"){ cell_ok[i]=true; lastUpdMs[i]=millis(); Serial.print(F("[OK] C")); Serial.print(i+1); Serial.println(F(" habilitada.")); }
    else if(sw=="OFF"){ cell_ok[i]=false; Serial.print(F("[OK] C")); Serial.print(i+1); Serial.println(F(" desabilitada.")); }
    else Serial.println(F("[ERRO] Use ON ou OFF."));
    return;
  }

  if(cmd=="READ"){
    burstPollMs(60);
    float F1,F2,F3,F4,D,L; computeOutputs(F1,F2,F3,F4,D,L);
    Serial.println(F("===== LEITURA ====="));
    Serial.print(F("F1 (g): ")); printVal3(F1); Serial.println();
    Serial.print(F("F2 (g): ")); printVal3(F2); Serial.println();
    Serial.print(F("F3 (g): ")); printVal3(F3); Serial.println();
    Serial.print(F("F4 (g): ")); printVal3(F4); Serial.println();
    Serial.print(F("D  (g): ")); printVal3(D);  Serial.println();
    Serial.print(F("L  (g): ")); printVal3(L);  Serial.println();
    return;
  }

  if(cmd=="STREAM"){ if(rest=="ON"){ streaming=true; Serial.println(F("[OK] STREAM ON")); return; } if(rest=="OFF"){ streaming=false; Serial.println(F("[OK] STREAM OFF")); return; } Serial.println(F("[ERRO] STREAM ON|OFF")); return; }

  if(cmd=="RATE"){ unsigned long ms=rest.toInt(); if(ms<20) ms=20; sampleIntervalMs=ms; Serial.print(F("[OK] RATE=")); Serial.print(sampleIntervalMs); Serial.println(F(" ms")); return; }

  if(cmd=="AVGCAL"){ int n=rest.toInt(); if(n<1) n=1; avgCal=n; Serial.print(F("[OK] AVGCAL=")); Serial.println(avgCal); return; }

  if(cmd=="SAVE"){ saveEEPROM(); return; }
  if(cmd=="LOAD"){ if(!loadEEPROM()) Serial.println(F("[ERRO] EEPROM invalida.")); applyScaleOffsets(); primeReadAll(800); return; }

  Serial.println(F("[ERRO] Comando desconhecido. Digite HELP."));
}

// ===== SETUP / LOOP =====
unsigned long lastTick=0, t0=0;
void setup(){
  Serial.begin(115200); Serial.setTimeout(200);
  for(int i=0;i<5;i++){ sc[i].begin(DT[i],SCKHX[i]); sc[i].set_scale(1.0); }
  if(!loadEEPROM()){
    Serial.println(F("[INFO] EEPROM vazia/desatualizada. Fazendo TARE inicial..."));
    for(int i=0;i<5;i++){
      if(waitReadyTimeout(i,1000)){ sc[i].tare(); offsetRaw[i]=sc[i].get_offset(); cell_ok[i]=true; lastUpdMs[i]=millis(); }
      else { cell_ok[i]=false; Serial.print(F("[WARN] C")); Serial.print(i+1); Serial.println(F(" sem resposta no boot.")); }
    }
  } else { applyScaleOffsets(); }
  primeReadAll(800);
  Serial.println(F("HX711 x5 pronto. Digite HELP."));
}

void loop(){
  readAndDispatchSerial();
  pollAll();

  if(streaming && (millis()-lastTick)>=sampleIntervalMs){
    lastTick=millis();
    float F1,F2,F3,F4,D,L; computeOutputs(F1,F2,F3,F4,D,L);

    if(plotMode){
      Serial.print(F("F1:")); printVal5(F1); Serial.print(' ');
      Serial.print(F("F2:")); printVal5(F2); Serial.print(' ');
      Serial.print(F("F3:")); printVal5(F3); Serial.print(' ');
      Serial.print(F("F4:")); printVal5(F4); Serial.print(' ');
      Serial.print(F("D:"));  printVal5(D);  Serial.print(' ');
      Serial.print(F("L:"));  printVal5(L);  Serial.println();
    } else if(csvMode){
      if(t0==0) t0=millis(); float tsec=(millis()-t0)/1000.0f;
      Serial.print(tsec,3); Serial.print(',');
      printVal5(F1); Serial.print(','); printVal5(F2); Serial.print(',');
      printVal5(F3); Serial.print(','); printVal5(F4); Serial.print(',');
      printVal5(D);  Serial.print(','); printVal5(L);  Serial.println();
    } else {
      Serial.println(F("===== LEITURA ====="));
      Serial.print(F("F1 (g): ")); printVal3(F1); Serial.println();
      Serial.print(F("F2 (g): ")); printVal3(F2); Serial.println();
      Serial.print(F("F3 (g): ")); printVal3(F3); Serial.println();
      Serial.print(F("F4 (g): ")); printVal3(F4); Serial.println();
      Serial.print(F("D  (g): ")); printVal3(D);  Serial.println();
      Serial.print(F("L  (g): ")); printVal3(L);  Serial.println();
    }
  }
}
