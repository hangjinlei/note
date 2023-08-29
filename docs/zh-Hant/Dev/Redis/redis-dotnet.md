# Redis with .NET

- [Docs](https://stackexchange.github.io/StackExchange.Redis/)
- [Redis with .NET](https://docs.redis.com/latest/rs/references/client_references/client_csharp/)

## NuGet

```powershell
PM> Install-Package StackExchange.Redis
```

## Console Application

### Cache

```csharp
using var connectionMultiplexer = ConnectionMultiplexer.Connect("localhost:6379");
var database = connectionMultiplexer.GetDatabase();
database.StringSet("test", "Hello from .NET App");
var value = database.StringGet("test");
Console.WriteLine(value);
```

## ASP.NET Core

appsettings.json

```json
{
  "RedisConnection": "localhost:6379"
}
```

Program.cs

```csharp
builder.Services.AddSingleton<IConnectionMultiplexer>(sp
    => ConnectionMultiplexer.Connect(builder.Configuration.GetValue<string>("RedisConnection")));
```

### Cache

Controller

```csharp
[ApiController]
[Route("api/[controller]")]
public class RedisController : ControllerBase
{
    private readonly IConnectionMultiplexer redis;

    public RedisController(IConnectionMultiplexer redis)
    {
        this.redis = redis;
    }

    [HttpGet]
    [Route("put")]
    public async Task<string> PutAsync(CancellationToken cancellationToken)
    {
        var database = redis.GetDatabase();
        var value = await database.StringSetAndGetAsync("asp", "Hello from ASP.NET Core");
        return value;
    }
}
```

### Message

1. 创建后台订阅服务, 从后台服务订阅消息
2. 注册后台服务
3. 或从控制器中发布消息

Program.cs

```csharp
builder.Services.AddHostedService<RedisSubscriber>();
```

Controller

```csharp
[ApiController]
[Route("api/[controller]")]
public class RedisController : ControllerBase
{
    private readonly IConnectionMultiplexer redis;

    public RedisController(IConnectionMultiplexer redis)
    {
        this.redis = redis;
    }

    [HttpGet]
    [Route("publish")]
    public Task PublishAsync(CancellationToken cancellationToken)
    {
        ISubscriber subscriber = redis.GetSubscriber();
        return subscriber.PublishAsync("messages", "Hello from ASP.NET Core");
    }
}
```

RedisSubscriber

```csharp
public class RedisSubscriber : BackgroundService
{
    private readonly IConnectionMultiplexer redis;

    public RedisSubscriber(IConnectionMultiplexer redis)
    {
        this.redis = redis;
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        ISubscriber subscriber = redis.GetSubscriber();
        return subscriber.SubscribeAsync(channel: "messages", (channel, value) =>
        {
            Console.WriteLine($"Received {value} on {channel}");
        });
    }
}
```

Redis-CLI

```powershell
publish messages "Hello from .NET App"
```

## 集群

```powershell
docker run -p 6379:6379 --name redis-master \
    -e REDIS_REPLICATION_MODE=master \
    -e ALLOW_EMPTY_PASSWORD=yes \
    -d redis
```

```powershell
docker run -p 6380:6379 --name redis-replica --link redis-master:master \
    -e REDIS_REPLICATION_MODE=slave \
    -e REDIS_MASTER_HOST=master \
    -e REDIS_MASTER_PORT_NUMBER=6379 \
    -e REDIS_MASTER_PASSWORD= \
    -e ALLOW_EMPTY_PASSWORD=yes \
    -d redis
```

appsettings.json

```json
{
  "RedisConnection": "localhost:6379,localhost:6380"
}
```
