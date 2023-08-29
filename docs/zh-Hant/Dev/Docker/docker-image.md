# 常用镜像参考

## Microsoft SQL Server

[Docker Hub](https://hub.docker.com/_/microsoft-mssql-server)

### 使用 Docker Compose

DockerFile

```dockerfile
FROM mcr.microsoft.com/mssql/server
EXPOSE 1433
WORKDIR /workspaces/mssql
COPY . /workspaces/mssql
```

docker-compose.yml

```yml
version: "3"
services:
  mssql:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "1433:1433"
    environment:
      SA_PASSWORD: "P@ssw0rd"
      ACCEPT_EULA: "Y"
    volumes:
      - ./data:/var/opt/mssql
      - ./logs:/var/opt/mssql/log
      - ./backups:/var/opt/mssql/backup
    image: mcr.microsoft.com/mssql/server
```

### 直接拉取镜像

```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" -p 1433:1433 -d mcr.microsoft.com/mssql/server
```

## RabbitMQ

[Docker Hub](https://hub.docker.com/_/rabbitmq)

[RabbitMQ Configure](https://www.rabbitmq.com/configure.html)

```shell
docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 -p 5672:5672 rabbitmq:3-management
docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 -p 5672:5672 -e RABBITMQ_DEFAULT_USER=user -e RABBITMQ_DEFAULT_PASS=password rabbitmq:3-management
```

## nginx

### To run in foreground:

```shell
nginx -g 'daemon off;'
```

### To run in background:

```shell
nginx
```
