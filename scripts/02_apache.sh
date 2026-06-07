#!/bin/bash

# Script: 02_apache.sh
# Descrição: Instala e valida o Apache para o Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/apache_$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"

# Função para instalar o Apache
instalar_apache() {
    echo "[INFO] Instalando Apache..." | tee -a "$LOG_FILE"
    apt install -y apache2 2>&1 | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        echo "[OK] Apache instalado com sucesso." | tee -a "$LOG_FILE"
    else
        echo "[ERRO] Falha ao instalar o Apache." | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Função para iniciar e validar o Apache
verificar_apache() {
    echo "[INFO] Iniciando o serviço Apache..." | tee -a "$LOG_FILE"
    service apache2 start 2>&1 | tee -a "$LOG_FILE"

    if service apache2 status > /dev/null 2>&1; then
        echo "[OK] Apache está em execução." | tee -a "$LOG_FILE"
    else
        echo "[ALERTA] Apache não está em execução." | tee -a "$LOG_FILE"
    fi
}

# Função para exibir a versão do Apache
versao_apache() {
    echo "[INFO] Versão do Apache instalada:" | tee -a "$LOG_FILE"
    apache2 -v 2>&1 | tee -a "$LOG_FILE"
}

# Verificar se está rodando como root
if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Este script precisa ser executado como root (sudo)."
    exit 1
fi

echo "========================================"
echo "  INSTALAÇÃO DO APACHE - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

instalar_apache
verificar_apache
versao_apache

echo "[OK] Script 02_apache.sh finalizado." | tee -a "$LOG_FILE"
echo "========================================"
