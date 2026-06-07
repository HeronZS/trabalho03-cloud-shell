#!/bin/bash

# Script: 01_update.sh
# Descrição: Atualiza os pacotes do sistema Ubuntu
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/update_$(date +%Y-%m-%d).log"

# Função principal de atualização do sistema
atualizar_sistema() {
    echo "========================================"
    echo "  ATUALIZAÇÃO DO SISTEMA - ESTOQUE"
    echo "  $(date '+%d/%m/%Y %H:%M:%S')"
    echo "========================================"

    echo "[INFO] Iniciando atualização do sistema..." | tee -a "$LOG_FILE"

    apt update -y 2>&1 | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        echo "[OK] apt update concluído com sucesso." | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Falha ao executar apt update." | tee -a "$LOG_FILE"
        exit 1
    fi

    apt upgrade -y 2>&1 | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        echo "[OK] Pacotes atualizados com sucesso." | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Falha ao atualizar pacotes." | tee -a "$LOG_FILE"
        exit 1
    fi

    echo "[OK] Sistema do Estoque atualizado em $(date '+%d/%m/%Y %H:%M:%S')" | tee -a "$LOG_FILE"
    echo "========================================"
}

# Verificar se está rodando como root
if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Este script precisa ser executado como root (sudo)."
    exit 1
fi

# Criar diretório de log se não existir
mkdir -p "$LOG_DIR"

# Executar função
atualizar_sistema
