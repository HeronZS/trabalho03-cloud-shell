#!/bin/bash

# Script: 09_relatorio.sh
# Descrição: Gera relatório operacional do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

LOG_DIR="/app/estoque/logs"
RELATORIO="$LOG_DIR/relatorio_execucao.txt"

mkdir -p "$LOG_DIR"

# Função para gerar cabeçalho do relatório
gerar_cabecalho() {
    echo "========================================" > "$RELATORIO"
    echo "  RELATÓRIO OPERACIONAL - ESTOQUE CLOUD" >> "$RELATORIO"
    echo "  Projeto: Sistema de Gestão de Estoque" >> "$RELATORIO"
    echo "  Instituição: Unidavi" >> "$RELATORIO"
    echo "  Disciplina: Cloud Computing" >> "$RELATORIO"
    echo "  Data/Hora: $(date '+%d/%m/%Y %H:%M:%S')" >> "$RELATORIO"
    echo "========================================" >> "$RELATORIO"
}

# Função para informar uso de disco
relatorio_disco() {
    echo "" >> "$RELATORIO"
    echo "--- USO DE DISCO ---" >> "$RELATORIO"
    df -h >> "$RELATORIO"

    echo "" >> "$RELATORIO"
    echo "--- USO DOS DIRETÓRIOS DO ESTOQUE ---" >> "$RELATORIO"
    du -sh /app/estoque/* 2>/dev/null >> "$RELATORIO"
}

# Função para informar status do Apache
relatorio_apache() {
    echo "" >> "$RELATORIO"
    echo "--- STATUS DO APACHE ---" >> "$RELATORIO"

    if service apache2 status > /dev/null 2>&1; then
        echo "[OK] Apache em execução." >> "$RELATORIO"
    else
        echo "[ALERTA] Apache não está em execução." >> "$RELATORIO"
    fi

    apache2 -v 2>/dev/null >> "$RELATORIO"
}

# Função para listar backups
relatorio_backups() {
    echo "" >> "$RELATORIO"
    echo "--- ÚLTIMOS BACKUPS ---" >> "$RELATORIO"
    ls -lh /app/estoque/backups/*.tar.gz 2>/dev/null >> "$RELATORIO"

    if [ $? -ne 0 ]; then
        echo "Nenhum backup encontrado." >> "$RELATORIO"
    fi
}

# Função para listar logs
relatorio_logs() {
    echo "" >> "$RELATORIO"
    echo "--- ARQUIVOS DE LOG ---" >> "$RELATORIO"
    ls -lh "$LOG_DIR"/*.log 2>/dev/null >> "$RELATORIO"

    if [ $? -ne 0 ]; then
        echo "Nenhum log encontrado." >> "$RELATORIO"
    fi
}

# Função para listar arquivos publicados
relatorio_deploy() {
    echo "" >> "$RELATORIO"
    echo "--- ARQUIVOS PUBLICADOS NO APACHE ---" >> "$RELATORIO"
    ls -lh /var/www/html/ 2>/dev/null >> "$RELATORIO"
}

# Função para listar usuários e permissões
relatorio_usuarios() {
    echo "" >> "$RELATORIO"
    echo "--- USUÁRIOS DO SISTEMA DE ESTOQUE ---" >> "$RELATORIO"
    cat /etc/passwd | grep -E "estoque|pedido|fornecedor" >> "$RELATORIO"

    echo "" >> "$RELATORIO"
    echo "--- GRUPOS DO SISTEMA DE ESTOQUE ---" >> "$RELATORIO"
    cat /etc/group | grep estoque >> "$RELATORIO"

    echo "" >> "$RELATORIO"
    echo "--- PERMISSÕES DOS DIRETÓRIOS ---" >> "$RELATORIO"
    ls -lh /app/estoque/ 2>/dev/null >> "$RELATORIO"
}

# Função para exibir rodapé
gerar_rodape() {
    echo "" >> "$RELATORIO"
    echo "========================================" >> "$RELATORIO"
    echo "  Relatório gerado em: $(date '+%d/%m/%Y %H:%M:%S')" >> "$RELATORIO"
    echo "========================================" >> "$RELATORIO"
}

echo "========================================"
echo "  GERANDO RELATÓRIO OPERACIONAL - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

gerar_cabecalho
relatorio_disco
relatorio_apache
relatorio_backups
relatorio_logs
relatorio_deploy
relatorio_usuarios
gerar_rodape

echo "[OK] Relatório gerado em: $RELATORIO"
cat "$RELATORIO"
echo "========================================"
