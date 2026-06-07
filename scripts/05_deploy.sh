#!/bin/bash

# Script: 05_deploy.sh
# Descrição: Realiza o deploy do site estático do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

ORIGEM="/var/www/html"
SOURCE="/app/source"
LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/deploy_$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"

# Função para limpar diretório de destino
limpar_destino() {
    echo "[INFO] Limpando diretório de destino: $ORIGEM" | tee -a "$LOG_FILE"
    rm -rf "$ORIGEM"/*
    echo "[OK] Diretório limpo com sucesso." | tee -a "$LOG_FILE"
}

# Função para realizar o deploy
realizar_deploy() {
    echo "[INFO] Copiando arquivos de $SOURCE para $ORIGEM..." | tee -a "$LOG_FILE"

    cp -r "$SOURCE"/* "$ORIGEM"/ 2>&1 | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        echo "[OK] Arquivos copiados com sucesso." | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Falha ao copiar arquivos." | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Função para validar o deploy
validar_deploy() {
    echo "[INFO] Validando deploy..." | tee -a "$LOG_FILE"

    if [ -f "$ORIGEM/index.html" ]; then
        echo "[OK] index.html encontrado no destino." | tee -a "$LOG_FILE"
    else
        echo "[ERRO] index.html não encontrado em $ORIGEM!" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Função para listar arquivos publicados
listar_publicados() {
    echo "[INFO] Arquivos publicados em $ORIGEM:" | tee -a "$LOG_FILE"
    ls -lh "$ORIGEM" | tee -a "$LOG_FILE"
}

echo "========================================"
echo "  DEPLOY DO SITE - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

limpar_destino
realizar_deploy
validar_deploy
listar_publicados

echo "[OK] Script 05_deploy.sh finalizado." | tee -a "$LOG_FILE"
echo "========================================"
