# Redis

缓存雪崩，缓存击穿，缓存穿透

## 安装

[Docker Image](https://hub.docker.com/_/redis)

```powershell
docker run --name some-redis -p 6379:6379 -d redis
```

```powershell
docker exec -it <c3acfb089247> redis-cli
```

## 指导

- [Redis configuration](https://redis.io/docs/management/config/)

## 数据类型

- 字符串 (string)
- 哈希 (hash)
- 列表 (list)
- 集合 (set)
- 有序集合 (zset)
- 流 (stream)

一个字符串类型键允许存储的数据的最大容量是 512 MB

## [Commands](https://redis.io/commands/)

### Ping

```powershell
ping
ping "hello"
4 ping
```

### 赋值与取值

```powershell
set "key" "value"
set "key" "value" EX 10 # 10 秒后过期
get "key"
expire "key" 10 # 10 秒后过期
```

### 获取符合规则的键名列表

```powershell
KEYS pattern

keys * # 查看所有的 key
keys t* # 查看所有以 t 开头的 key
```

### 判断一个键是否存在

```powershell
EXISTS key

exists k1 # 判断 key 是否存在, 1 为存在, 0 为不存在
```

### 删除键

```powershell
DEL key [key ...]

del "key"
keys "user:*" | xargs redis-cli del
del 'redis-cli keys "user:*" '
```

### 获取键值的数据类型

```powershell
TYPE key

type "key"
```

### Config

```powershell
config get * # 查看所有的配置
config set requirepass "P@ssw0rd" # 设置密码
config set requirepass "" # 清除密码
info # 查看所有的信息
client list # 查看所有的客户端
monitor # 监听所有的命令
```
