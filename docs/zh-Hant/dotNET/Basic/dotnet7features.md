# dotnet 7 features

## ASP.NET Core

### Rate limiting middleware in ASP.NET Core

- [Docs - en_US](https://learn.microsoft.com/en-us/aspnet/core/performance/rate-limit)
- [Docs - zh_CN](https://learn.microsoft.com/zh-CN/aspnet/core/performance/rate-limit)

Sample Usage

```csharp
using Microsoft.AspNetCore.RateLimiting;
using System.Threading.RateLimiting;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddRateLimiter(_ => _
  .AddFixedWindowLimiter(policyName: "fixed", options =>
  {
      options.PermitLimit = 4;
      options.Window = TimeSpan.FromSeconds(12);
      options.QueueProcessingOrder = QueueProcessingOrder.OldestFirst;
      options.QueueLimit = 2;
  }));

var app = builder.Build();

app.UseRateLimiter();

static string GetTicks() => (DateTime.Now.Ticks & 0x11111).ToString("00000");

app.MapGet("/", () => Results.Ok($"Hello {GetTicks()}"))
                          .RequireRateLimiting("fixed");

app.Run();
```

前面的代码：

- 调用 UseRateLimiter 以启用速率限制。
- 创建具有策略名称和集的 "fixed" 固定窗口限制程序：
- permitLimit 到 4，时间 window 到 12。 每个 12 秒窗口最多允许 4 个请求。
- 将 queueProcessingOrder 指定为 QueueProcessingOrder.OldestFirst。
- queueLimit 到 2.

### Caching in ASP.NET Core

- [Docs - en_US](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/overview)
- [Docs - zh_CN](https://learn.microsoft.com/zh-cn/aspnet/core/performance/caching/overview)

### API Groups

- [Docs - en_US](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/minimal-apis/route-handlers#route-groups)
- [Docs - zh_CN](https://learn.microsoft.com/zh-cn/aspnet/core/fundamentals/minimal-apis/route-handlers#route-groups)

## C\#

- required

```csharp
public required string Name { get; set; }
```

- raw string

```csharp
Name = """
Capuchin "Monkey"
""",
```

## Containers

Microsoft.NET.Build.Containers

```shell
dotnet publish -c Release -r linux-x64 -p PublishProfile=DefaultContainer --self-contained
```

## Native AOT

```xml
<Project Sdk="Microsoft.NET.Sdk">

<PropertyGroup>
  ...
  <PublishAot>true</PublishAot>
</PropertyGroup>

</Project>
```

```shell
dotnet publish -r win-x64 -c Release
```
