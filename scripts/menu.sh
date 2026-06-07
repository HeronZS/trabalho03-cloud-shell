#!/bin/bash

# Script: menu.sh
# Descrição: Menu principal do Sistema de Gestão de Estoque
# Tema: Sistema de Gestão de Estoque
# Autor: Aluno - Cloud Computing Unidavi

SCRIPTS_DIR="/app/scripts"

# Função para exibir cabeçalho
exibir_cabecalho() {
    clear
    echo "========================================"
    echo "  Criado por: Seu Nome Aqui"
    echo "  Instituição: Unidavi"
    echo "  Tema: Sistema de Gestão de Estoque"
    echo "========================================"
    echo "       MENU DEVOPS CLOUD - ESTOQUE"
    echo "========================================"
    echo "  1 - Atualizar sistema"
    echo "  2 - Instalar Apache"
    echo "  3 - Criar estrutura do projeto"
    echo "  4 - Realizar backup"
    echo "  5 - Fazer deploy"
    echo "  6 - Ver processos"
    echo "  7 - Monitorar sistema"
    echo "  8 - Configurar usuários e permissões"
    echo "  9 - Gerar relatório"
    echo "  0 - Sair"
    echo "========================================"
}

# Função para executar opção escolhida
executar_opcao() {
    case "$1" in
        1)
            echo "[INFO] Executando atualização do sistema..."
            bash "$SCRIPTS_DIR/01_update.sh"
            ;;
        2)
            echo "[INFO] Executando instalação do Apache..."
            bash "$SCRIPTS_DIR/02_apache.sh"
            ;;
        3)
            echo "[INFO] Criando estrutura de diretórios..."
            bash "$SCRIPTS_DIR/03_estrutura.sh"
            ;;
        4)
            echo "[INFO] Realizando backup..."
            bash "$SCRIPTS_DIR/04_backup.sh"
            ;;
        5)
            echo "[INFO] Realizando deploy..."
            bash "$SCRIPTS_DIR/05_deploy.sh"
            ;;
        6)
            echo "[INFO] Opções: listar | buscar <nome> | matar <PID>"
            read -p "Informe a ação: " acao
            read -p "Informe o argumento (se necessário): " argumento
            bash "$SCRIPTS_DIR/06_processos.sh" "$acao" "$argumento"
            ;;
        7)
            echo "[INFO] Monitorando sistema..."
            bash "$SCRIPTS_DIR/07_monitoramento.sh"
            ;;
        8)
            echo "[INFO] Configurando usuários e permissões..."
            bash "$SCRIPTS_DIR/08_usuarios_permissoes.sh"
            ;;
        9)
            echo "[INFO] Gerando relatório operacional..."
            bash "$SCRIPTS_DIR/09_relatorio.sh"
            ;;
        0)
            echo "[OK] Saindo do sistema de estoque. Até logo!"
            exit 0
            ;;
        *)
            echo "[ERRO] Opção inválida. Tente novamente."
            ;;
    esac
}

# Loop principal do menu
while true; do
    exibir_cabecalho
    read -p "Escolha uma opção: " OPCAO
    echo ""
    executar_opcao "$OPCAO"
    echo ""
    read -p "Pressione ENTER para voltar ao menu..."
done
