# 基礎命令

## docker

| Command        | 說明               |
| :------------- | :----------------- |
| `docker ps`    | 列出所有 container |
| `docker ps -a` | 列出所有 container |

## image

| Command                                            | 說明              |
| :------------------------------------------------- | :---------------- |
| `docker image ls`                                  | 列出所有 image    |
| `docker image ls -q`                               | 列出所有 image id |
| `docker image ls -f dangling=true`                 | 列出虛擬鏡像      |
| `docker image rm $(docker image ls -q)`            | 刪除所有 image    |
| `docker rmi $(docker image -f "dangling=true" -q)` |                   |

## container

| Command                                            | 說明                  |
| :------------------------------------------------- | :-------------------- |
| `docker container ls`                              | 列出所有 container    |
| `docker container ls -q`                           | 列出所有 container id |
| `docker container rm $(docker container ls -q)`    | 刪除所有 container    |
| `docker container rm $(docker container ls -a -q)` | 刪除所有 container    |
