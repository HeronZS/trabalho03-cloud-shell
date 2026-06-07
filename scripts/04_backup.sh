#!/bin/bash

# Script: 04_backup.sh
# Descrição: Realiza backup automatizado do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

ORIGEM="/app/estoque"
DESTINO="/app/estoque/backups"
DATA=$(date +%Y-%m-%d_%H-%M)
NOME_BACKUP="backup_estoque_$DATA.tar.gz"
LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/backup_$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"
mkdir -p "$DESTINO"

# Função para realizar o backup
realizar_backup() {
    echo "[INFO] Iniciando backup do estoque..." | tee -a "$LOG_FILE"
    echo "[INFO] Origem: $ORIGEM" | tee -a "$LOG_FILE"
    echo "[INFO] Destino: $DESTINO/$NOME_BACKUP" | tee -a "$LOG_FILE"

    tar --exclude="$DESTINO" -czf "$DESTINO/$NOME_BACKUP" "$ORIGEM" 2>&1 | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        echo "[OK] Backup criado com sucesso: $NOME_BACKUP" | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Falha ao criar o backup." | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Função para validar o backup
validar_backup() {
    echo "[INFO] Validando backup..." | tee -a "$LOG_FILE"

    if [ -f "$DESTINO/$NOME_BACKUP" ]; then
        TAMANHO=$(du -sh "$DESTINO/$NOME_BACKUP" | cut -f1)
        echo "[OK] Backup validado: $NOME_BACKUP ($TAMANHO)" | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Arquivo de backup não encontrado!" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Função para listar backups existentes
listar_backups() {
    echo "[INFO] Backups disponíveis em $DESTINO:" | tee -a "$LOG_FILE"
    ls -lh "$DESTINO"/*.tar.gz 2>/dev/null | tee -a "$LOG_FILE"

    if [ $? -ne 0 ]; then
        echo "[INFO] Nenhum backup anterior encontrado." | tee -a "$LOG_FILE"
    fi
}

echo "========================================"
echo "  BACKUP AUTOMATIZADO - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

realizar_backup
validar_backup
listar_backups

echo "[OK] Script 04_backup.sh finalizado." | tee -a "$LOG_FILE"
echo "========================================"
