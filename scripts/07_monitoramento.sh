#!/bin/bash

# Script: 07_monitoramento.sh
# Descrição: Monitora recursos do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/monitoramento_$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"

# Limites de alerta
LIMITE_CPU=80
LIMITE_MEM=80
LIMITE_DISCO=80

# Função para monitorar CPU
monitorar_cpu() {
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1 | cut -d',' -f1)
    echo "[INFO] Uso de CPU: $CPU%" | tee -a "$LOG_FILE"

    if (( $(echo "$CPU > $LIMITE_CPU" | bc -l) )); then
        echo "[ALERTA] Uso de CPU acima de $LIMITE_CPU%!" | tee -a "$LOG_FILE"
    else
        echo "[OK] CPU dentro do limite." | tee -a "$LOG_FILE"
    fi
}

# Função para monitorar memória RAM
monitorar_memoria() {
    MEM=$(free | grep Mem | awk '{printf("%.0f"), $3/$2*100}')
    echo "[INFO] Uso de memória RAM: $MEM%" | tee -a "$LOG_FILE"

    if [ "$MEM" -gt "$LIMITE_MEM" ]; then
        echo "[ALERTA] Uso de memória acima de $LIMITE_MEM%!" | tee -a "$LOG_FILE"
    else
        echo "[OK] Memória dentro do limite." | tee -a "$LOG_FILE"
    fi
}

# Função para monitorar disco
monitorar_disco() {
    DISCO=$(df / | grep / | awk '{print $5}' | cut -d'%' -f1)
    echo "[INFO] Uso de disco: $DISCO%" | tee -a "$LOG_FILE"

    if [ "$DISCO" -gt "$LIMITE_DISCO" ]; then
        echo "[ALERTA] Uso de disco acima de $LIMITE_DISCO%!" | tee -a "$LOG_FILE"
    else
        echo "[OK] Disco dentro do limite." | tee -a "$LOG_FILE"
    fi
}

# Função para verificar status do Apache
verificar_apache() {
    if service apache2 status > /dev/null 2>&1; then
        echo "[OK] Apache em execução." | tee -a "$LOG_FILE"
    else
        echo "[ALERTA] Apache não está em execução!" | tee -a "$LOG_FILE"
    fi
}

echo "========================================"
echo "  MONITORAMENTO DO SISTEMA - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

echo "[INFO] Coleta iniciada em: $(date '+%d/%m/%Y %H:%M:%S')" | tee -a "$LOG_FILE"

monitorar_cpu
monitorar_memoria
monitorar_disco
verificar_apache

echo "[OK] Script 07_monitoramento.sh finalizado." | tee -a "$LOG_FILE"
echo "========================================"
