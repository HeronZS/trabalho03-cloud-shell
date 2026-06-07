#!/bin/bash

# Script: 03_estrutura.sh
# Descrição: Cria a estrutura de diretórios do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/estrutura_$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"

# Função para remover estrutura antiga
limpar_estrutura() {
    echo "[INFO] Removendo estrutura antiga se existir..." | tee -a "$LOG_FILE"
    rm -rf /app/estoque/produtos
    rm -rf /app/estoque/fornecedores
    rm -rf /app/estoque/pedidos
    rm -rf /app/estoque/relatorios
    echo "[OK] Estrutura antiga removida." | tee -a "$LOG_FILE"
}

# Função para criar estrutura de diretórios temática
criar_estrutura() {
    echo "[INFO] Criando estrutura de diretórios do Estoque..." | tee -a "$LOG_FILE"

    mkdir -p /app/estoque/produtos
    mkdir -p /app/estoque/fornecedores
    mkdir -p /app/estoque/pedidos
    mkdir -p /app/estoque/relatorios
    mkdir -p /app/estoque/logs
    mkdir -p /app/estoque/backups

    echo "[OK] Diretórios criados com sucesso." | tee -a "$LOG_FILE"
}

# Função para criar arquivos iniciais
criar_arquivos_iniciais() {
    echo "[INFO] Criando arquivos iniciais..." | tee -a "$LOG_FILE"

    echo "id,nome,quantidade,preco,categoria" > /app/estoque/produtos/produtos.csv
    echo "1,Produto Exemplo,100,29.90,Geral" >> /app/estoque/produtos/produtos.csv

    echo "id,nome,contato,email" > /app/estoque/fornecedores/fornecedores.csv
    echo "1,Fornecedor Exemplo,47999990000,fornecedor@email.com" >> /app/estoque/fornecedores/fornecedores.csv

    echo "id,produto,quantidade,status,data" > /app/estoque/pedidos/pedidos.csv
    echo "1,Produto Exemplo,10,Pendente,$(date +%Y-%m-%d)" >> /app/estoque/pedidos/pedidos.csv

    echo "[OK] Arquivos iniciais criados." | tee -a "$LOG_FILE"
}

# Função para exibir estrutura criada
exibir_estrutura() {
    echo "[INFO] Estrutura de diretórios criada:" | tee -a "$LOG_FILE"
    find /app/estoque -type d | tee -a "$LOG_FILE"
}

echo "========================================"
echo "  ESTRUTURA DE DIRETÓRIOS - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

limpar_estrutura
criar_estrutura
criar_arquivos_iniciais
exibir_estrutura

echo "[OK] Script 03_estrutura.sh finalizado." | tee -a "$LOG_FILE"
echo "========================================"
