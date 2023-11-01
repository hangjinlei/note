# Redis

缓存雪崩，缓存击穿，缓存穿透

## 安装

[Docker Image](https://hub.docker.com/_/redis)

```bash
docker run --name some-redis -p 6379:6379 -d redis
```

```bash
docker exec -it <c3acfb089247> redis-cli
```

## 数据类型

-   字符串 (string)
-   哈希 (hash)
-   列表 (list)
-   集合 (set)
-   有序集合 (zset)
-   流 (stream)

一个字符串类型键允许存储的数据的最大容量是 512 MB

## [Commands](https://redis.io/commands/)

### Syntax (Frequently used commands)

| Command                                     | Syntax                           | Description                  |
| :------------------------------------------ | :------------------------------- | :--------------------------- |
| [EXPIRE](https://redis.io/commands/expire/) | `EXPIRE key seconds`             | 设置一个键的过期时间         |
| [GET](https://redis.io/commands/get/)       | `GET key`                        | 获取一个键值对               |
| [KEYS](https://redis.io/commands/keys/)     | `KEYS pattern`                   | 获取所有符合条件的键         |
| [KEYS](https://redis.io/commands/keys/)     | `KEYS t*`                        | 获取所有以 t 开头的键        |
| MSET                                        | `MSET key value [key value ...]` | 设置多个键值对               |
| PING                                        | `PING [message]`                 | 测试连接                     |
| PSETEX                                      | `PSETEX key milliseconds value`  | 设置一个有过期时间的键值对   |
| [SET](https://redis.io/commands/set/)       | `SET key value`                  | 设置一个键值对               |
| [SET](https://redis.io/commands/set/)       | `SET key value EX seconds`       | 设置一个键值对，设置过期时间 |
| SETEX                                       | `SETEX key seconds value`        | 设置一个有过期时间的键值对   |
| STRLEN                                      | `STRLEN key`                     | 获取一个键值对的长度         |
| SETNX                                       | `SETNX key value`                | 设置一个键值对，如果键不存在 |
| TTL                                         | `TTL key`                        | 查看一个键的剩余过期时间     |

### Ping

-   `4 ping`

### Query

#### Delete

-   `del key key [key ...]`
-   `del key`
-   `flushall`

```bash
keys "user:*" | xargs redis-cli del
del 'redis-cli keys "user:*" '
```

### 判断一个键是否存在

```bash
EXISTS key

exists k1 # 判断 key 是否存在, 1 为存在, 0 为不存在
```

### 获取键值的数据类型

```bash
TYPE key

type "key"
```

### Config

```bash
config get * # 查看所有的配置
config set requirepass "P@ssw0rd" # 设置密码
config set requirepass "" # 清除密码
info # 查看所有的信息
client list # 查看所有的客户端
monitor # 监听所有的命令
```

## References

-   [Redis configuration](https://redis.io/docs/management/config/)
