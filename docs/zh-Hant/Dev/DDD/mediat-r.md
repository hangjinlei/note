# MediatR 处理领域事件

## NuGet

[MediatR.Extensions.Microsoft.DependencyInjection](https://www.nuget.org/packages/MediatR.Extensions.Microsoft.DependencyInjection)

## 手顺

1. 创建一个 ASP.NET Core 项目, NuGet 安装 MediatR.Extensions.Microsoft.DependencyInjection
2. Program.cs 中调用 `AddMediatR()`
3. 定义一个在消息的发布者和处理者之间进行数据传递的类, 这个类需要实现 `INotification` 接口. 一般用 `record` 类型
4. 消息的处理者要实现 `INotificationHandler<TNotification>` 接口, 其中的泛型参数 `TNotification` 代表此消息处理者要处理的消息类型
5. 在需要发布消息的的类中注入 `IMediator` 类型的服务, 然后我们调用 Publish 方法来发布消息. Send()方法是用来发布一对一消息的, 而 Publish()方法是用来发布一对多消息的

## 示例代码

Program.cs

```csharp
builder.Services.AddMediatR(Assembly.GetExecutingAssembly());
```

PostNotification.cs

```csharp
public record PostNotification(string Content) : INotification;
```

MediatRController.cs

```csharp
[Route("api/[controller]")]
[ApiController]
public class MediatRController : ControllerBase
{
    private readonly IMediator mediator;

    public MediatRController(IMediator mediator)
    {
        this.mediator = mediator;
    }

    [HttpGet]
    public async Task Post(string message, CancellationToken cancellationToken)
    {
        await mediator.Publish<PostNotification>(new PostNotification(message), cancellationToken);
    }
}
```

PostNotificationHandler1.cs

```csharp
public class PostNotificationHandler1 : INotificationHandler<PostNotification>
{
    public async Task Handle(PostNotification notification, CancellationToken cancellationToken)
    {
        await Console.Out.WriteLineAsync($"{nameof(PostNotificationHandler1)}: {notification.Content}");
    }
}
```

PostNotificationHandler2.cs

```csharp
public class PostNotificationHandler2 : INotificationHandler<PostNotification>
{
    public async Task Handle(PostNotification notification, CancellationToken cancellationToken)
    {
        await Console.Out.WriteLineAsync($"{nameof(PostNotificationHandler2)}: {notification.Content}");
    }
}
```

## Invoke

```shell
curl -X 'GET' \
  'https://localhost:7145/api/MediatR?message=hello' \
  -H 'accept: */*'
```
