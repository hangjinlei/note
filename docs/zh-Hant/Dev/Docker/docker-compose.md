# Docker Compose

-   version (DEPRECATED)
-   [services (REQUIRED)](https://docs.docker.com/compose/compose-file/05-services/)
-   [networks](https://docs.docker.com/compose/compose-file/06-networks/)
-   [volumes](https://docs.docker.com/compose/compose-file/07-volumes/)
-   [configs](https://docs.docker.com/compose/compose-file/08-configs/)
-   [secrets](https://docs.docker.com/compose/compose-file/09-secrets/)

## Sample

compose.yaml

```yaml
version: "3"

service:
    ping:
        image: ping
        ports:
            - 5001:80
    pong:
        image: pong
        ports:
            - 5003:80

networks:
    default:
        external:
            name: ping-pong-network
```

```yaml
services:
    app:
        image: mcr.microsoft.com/devcontainers/python:0-3.9
        ports:
            - 3000:3000
        volumes:
            - .:/workspaces/app
    localstack-sqs:
        image: localstack/localstack
        ports:
            - 4566:4566
            - 4510-4559:4510-4559
    dynamodb:
        image: amazon/dynamodb-local
        ports:
            - 8000:8000
```

```plaintext
注意

version 已棄用
```

## Reference

-   [Docker Compose Docs](https://docs.docker.com/compose/compose-file/03-compose-file/)
