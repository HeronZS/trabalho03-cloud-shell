# Trabalho 03 - Linux, Shell Script e Cloud Computing

## Aluno
Heron Zonta

## Tema
Sistema de Gestão de Estoque para uma Loja

## Descricao do Projeto
Este projeto simula um ambiente Linux containerizado para operacao de um Sistema de Gestao de Estoque. O ambiente utiliza Docker com Ubuntu Server, Apache e Shell Scripts para automatizar tarefas operacionais como atualizacao do sistema, instalacao de servicos, backup, deploy, monitoramento e controle de permissoes, simulando um cenario real de Cloud Computing e DevOps.

## Tecnologias Utilizadas
- Linux Ubuntu 22.04
- Docker
- Docker Compose
- Apache
- Shell Script
- AWS EC2
- GitHub
- DockerHub

## Estrutura do Projeto
trabalho03-cloud-shell/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── scripts/
│   ├── 01_update.sh
│   ├── 02_apache.sh
│   ├── 03_estrutura.sh
│   ├── 04_backup.sh
│   ├── 05_deploy.sh
│   ├── 06_processos.sh
│   ├── 07_monitoramento.sh
│   ├── 08_usuarios_permissoes.sh
│   ├── 09_relatorio.sh
│   └── menu.sh
├── source/
│   ├── index.html
│   ├── sobre.html
│   └── assets/
├── backups/
├── logs/
└── evidencias/

## Como Executar

1. Clonar o repositorio:
git clone https://github.com/heronzonta/trabalho03-cloud-shell
cd trabalho03-cloud-shell

2. Subir o container:
docker compose up -d --build

3. Verificar se o container esta rodando:
docker ps

4. Entrar no container:
docker exec -it trabalho03-linux bash

## Scripts Disponiveis
| Script                    | Descricao                          |
|---------------------------|------------------------------------|
| 01_update.sh              | Atualiza pacotes do sistema        |
| 02_apache.sh              | Instala e valida Apache            |
| 03_estrutura.sh           | Cria diretorios do projeto         |
| 04_backup.sh              | Realiza backup automatizado        |
| 05_deploy.sh              | Publica arquivos no Apache         |
| 06_processos.sh           | Gerencia processos                 |
| 07_monitoramento.sh       | Monitora CPU, RAM, disco e Apache  |
| 08_usuarios_permissoes.sh | Configura usuarios e permissoes    |
| 09_relatorio.sh           | Gera relatorio operacional         |
| menu.sh                   | Menu principal interativo          |

## Como Executar o Menu Principal
cd /app/scripts
./menu.sh

## Como Executar Scripts Individualmente
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./04_backup.sh
./05_deploy.sh
./06_processos.sh listar
./06_processos.sh buscar apache
./06_processos.sh matar 1234
./07_monitoramento.sh
./08_usuarios_permissoes.sh
./09_relatorio.sh

## Como Acessar o Site no Navegador
http://<IP-DA-EC2>:8080

## DockerHub
docker pull heronzonta/trabalho03-estoque:latest
Link: https://hub.docker.com/r/heronzonta/trabalho03-estoque

## Uso de IA
Este projeto foi desenvolvido com auxilio do Claude (Anthropic) para a revisão dos scripts Shell e estrutura do projeto. Todo o conteudo foi revisado, compreendido e adaptado pelo aluno ao tema de Sistema de Gestao de Estoque.

## Dificuldades Encontradas
- Docker nao funcionava localmente, sendo necessario utilizar AWS EC2 para hospedar o ambiente
- Configuracao do Security Group na EC2 para liberar as portas necessarias
- Adaptacao dos scripts ao ambiente containerizado Ubuntu
