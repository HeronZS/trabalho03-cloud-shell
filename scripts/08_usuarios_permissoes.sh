#!/bin/bash

# Script: 08_usuarios_permissoes.sh
# Descrição: Cria usuários, grupos e permissões do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

LOG_DIR="/app/estoque/logs"
LOG_FILE="$LOG_DIR/usuarios_$(date +%Y-%m-%d).log"

mkdir -p "$LOG_DIR"

# Função para criar grupos
criar_grupos() {
    echo "[INFO] Criando grupos do sistema de estoque..." | tee -a "$LOG_FILE"

    groupadd -f estoque_ops
    echo "[OK] Grupo estoque_ops criado." | tee -a "$LOG_FILE"

    groupadd -f estoque_viewers
    echo "[OK] Grupo estoque_viewers criado." | tee -a "$LOG_FILE"
}

# Função para criar usuários
criar_usuarios() {
    echo "[INFO] Criando usuários do sistema de estoque..." | tee -a "$LOG_FILE"

    if ! id "estoque_admin" &>/dev/null; then
        useradd -r -g estoque_ops -s /bin/bash -m estoque_admin
        echo "[OK] Usuário estoque_admin criado." | tee -a "$LOG_FILE"
    else
        echo "[INFO] Usuário estoque_admin já existe." | tee -a "$LOG_FILE"
    fi

    if ! id "pedido_user" &>/dev/null; then
        useradd -r -g estoque_ops -s /bin/bash -m pedido_user
        echo "[OK] Usuário pedido_user criado." | tee -a "$LOG_FILE"
    else
        echo "[INFO] Usuário pedido_user já existe." | tee -a "$LOG_FILE"
    fi

    if ! id "fornecedor_user" &>/dev/null; then
        useradd -r -g estoque_viewers -s /bin/bash -m fornecedor_user
        echo "[OK] Usuário fornecedor_user criado." | tee -a "$LOG_FILE"
    else
        echo "[INFO] Usuário fornecedor_user já existe." | tee -a "$LOG_FILE"
    fi
}

# Função para aplicar permissões
aplicar_permissoes() {
    echo "[INFO] Aplicando permissões nos diretórios..." | tee -a "$LOG_FILE"

    # Permissão total para estoque_ops nos diretórios operacionais
    chown -R estoque_admin:estoque_ops /app/estoque/produtos
    chmod -R 750 /app/estoque/produtos
    echo "[OK] Permissões aplicadas em /app/estoque/produtos (750)" | tee -a "$LOG_FILE"

    chown -R pedido_user:estoque_ops /app/estoque/pedidos
    chmod -R 750 /app/estoque/pedidos
    echo "[OK] Permissões aplicadas em /app/estoque/pedidos (750)" | tee -a "$LOG_FILE"

    # Permissão somente leitura para viewers em fornecedores
    chown -R fornecedor_user:estoque_viewers /app/estoque/fornecedores
    chmod -R 740 /app/estoque/fornecedores
    echo "[OK] Permissões aplicadas em /app/estoque/fornecedores (740)" | tee -a "$LOG_FILE"

    # Logs acessíveis apenas pelo admin
    chown -R estoque_admin:estoque_ops /app/estoque/logs
    chmod -R 750 /app/estoque/logs
    echo "[OK] Permissões aplicadas em /app/estoque/logs (750)" | tee -a "$LOG_FILE"
}

# Função para exibir resumo
exibir_resumo() {
    echo "[INFO] Resumo de usuários e permissões:" | tee -a "$LOG_FILE"
    echo "--- Grupos ---" | tee -a "$LOG_FILE"
    cat /etc/group | grep estoque | tee -a "$LOG_FILE"
    echo "--- Usuários ---" | tee -a "$LOG_FILE"
    cat /etc/passwd | grep estoque | tee -a "$LOG_FILE"
    cat /etc/passwd | grep pedido | tee -a "$LOG_FILE"
    cat /etc/passwd | grep fornecedor | tee -a "$LOG_FILE"
    echo "--- Permissões ---" | tee -a "$LOG_FILE"
    ls -lh /app/estoque/ | tee -a "$LOG_FILE"
}

# Verificar se está rodando como root
if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Este script precisa ser executado como root (sudo)."
    exit 1
fi

echo "========================================"
echo "  USUÁRIOS E PERMISSÕES - ESTOQUE"
echo "  $(date '+%d/%m/%Y %H:%M:%S')"
echo "========================================"

criar_grupos
criar_usuarios
aplicar_permissoes
exibir_resumo

echo "[OK] Script 08_usuarios_permissoes.sh finalizado." | tee -a "$LOG_FILE"
echo "========================================"
