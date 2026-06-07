FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    vim \
    net-tools \
    procps \
    && apt-get clean

RUN mkdir -p /app/estoque/produtos \
             /app/estoque/fornecedores \
             /app/estoque/pedidos \
             /app/estoque/relatorios \
             /app/estoque/logs \
             /app/estoque/backups

COPY scripts/ /app/scripts/
COPY source/ /var/www/html/

RUN chmod +x /app/scripts/*.sh

EXPOSE 80

CMD ["bash"]
