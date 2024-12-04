# Getting Started

- ADD
- COPY
- ENV
- EXPOSE
- LABEL
- STOPSIGNAL
- USER
- VOLUME
- WORKDIR
- ONBUILD

## dockerignore

- [docs](https://docs.docker.com/engine/reference/builder/#dockerignore-file)

- 示例

```dockerignore
# comment
*/temp*
*/*/temp*
temp?
!README*.md
```

- 排除文件 除 `README.md` 以外所有 markdown 文件都被排除

```dockerignore
*.md
!README.md
```

- 注意排除的顺序

```dockerignore
*.md
!README*.md
README-secret.md
```

```dockerignore
*.md
README-secret.md
!README*.md
```

## Dockerfile

```Dockerfile
FROM mcr.microsoft.com/devcontainers/dotnet:7.0
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
# 使端口 80 可供此容器外的环境使用
EXPOSE 80
# 定义环境变量
ENV NAME World
# 在容器启动时运行 app.py
CMD ["python", "app.py"]
```

## Command

### [ARG](https://docs.docker.com/engine/reference/builder/#arg)

- 定义变量, 可以使用 `${}` 引用

```dockerfile
ARG  CODE_VERSION=latest
FROM base:${CODE_VERSION}
CMD  /code/run-app

FROM extras:${CODE_VERSION}
CMD  /code/run-extras
```

### [FROM](https://docs.docker.com/engine/reference/builder/#from)

```dockerfile
FROM [--platform=<platform>] <image> [AS <name>]
FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]
FROM [--platform=<platform>] <image>[@<digest>] [AS <name>]
```

### [RUN](https://docs.docker.com/engine/reference/builder/#run)

## Image

- `docker pull`
- `docker images`
- `docker image ls -f dangling=true` 列出虚悬镜像(dangling image)
