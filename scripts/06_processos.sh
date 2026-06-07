#!/bin/bash

# Script: 06_processos.sh
# Descrição: Gerencia processos do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/processos_$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"

# Função para listar processos ativos
listar_processos() {
    echo "[INFO] Listando processos ativos..." | tee -a "$LOG_FILE"
    ps aux | tee -a "$LOG_FILE"
}

# Função para buscar processo por nome
buscar_processo() {
    if [ -z "$1" ]; then
        echo "[ERRO] Informe o nome do processo. Ex: ./06_processos.sh buscar apache"
        exit 1
    fi

    echo "[INFO] Buscando processo: $1" | tee -a "$LOG_FILE"
    RESULTADO=$(ps aux | grep "$1" | grep -v grep)

    if [ -z "$RESULTADO" ]; then
        echo "[INFO] Nenhum processo encontrado com o nome: $1" | tee -a "$LOG_FILE"
    else
        echo "$RESULTADO" | tee -a "$LOG_FILE"
    fi
}

# Função para encerrar processo por PID
matar_processo() {
    if [ -z "$1" ]; then
        echo "[ERRO] Informe o PID do processo. Ex: ./06_processos.sh matar 1234"
        exit 1
    fi

    echo "[ALERTA] Encerrando processo PID: $1" | tee -a "$LOG_FILE"
    kill "$1" 2>&1 | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        echo "[OK] Processo $1 encerrado com sucesso." | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Falha ao encerrar o processo $1." | tee -a "$LOG_FILE"
    fi
}

echo "========================================"
echo "  GERENCIAMENTO DE PROCESSOS - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

# Verificar parâmetro informado
case "$1" in
    listar)
        listar_processos
        ;;
    buscar)
        buscar_processo "$2"
        ;;
    matar)
        matar_processo "$2"
        ;;
    *)
        echo "Uso: ./06_processos.sh [listar | buscar <nome> | matar <PID>]"
        exit 1
        ;;
esac

echo "========================================"
