# Dependency Injection 在 .NET App 中的应用

## 概述

## 预备知识

本文假设读者已了解以下内容:

1. C#
2. 控制反转 (Inversion of Control, IoC)
3. 依赖注入 (Dependency Injection, DI)
4. 生命周期 (Singleton, Transient, Scope)

## API 参考

- [Microsoft.Extensions.DependencyInjection](https://learn.microsoft.com/zh-cn/dotnet/api/microsoft.extensions.dependencyinjection)
- [IServiceCollection](https://learn.microsoft.com/zh-cn/dotnet/api/microsoft.extensions.dependencyinjection.iservicecollection)
- [ServiceProvider](https://learn.microsoft.com/zh-cn/dotnet/api/microsoft.extensions.dependencyinjection.serviceprovider)

## 手顺

### 1. 安装 NuGet 包

```powershell
Install-Package Microsoft.Extensions.DependencyInjection
```

### 2. 创建 `ServiceCollection` 对象

```csharp
var services = new ServiceCollection();
```

### 3. 注册服务

- AddSingleton
- AddSingleton<>
- AddTransient
- AddTransient<>
- AddScoped
- AddScoped<>

```csharp
services.AddTransient<ITestService, TestServiceEN>();
```

### 4. 创建 `ServiceProvider` 对象

注意 `ServiceProvider` 类实现了 `IDisposable, IAsyncDisposable` 接口

```csharp
using var sp = services.BuildServiceProvider();
```

### 5. 获取服务

```csharp
var s = sp.GetService<ITestService>();
```

### 完整代码

```csharp
var services = new ServiceCollection();
services.AddTransient<ITestService, TestServiceEN>();

using var sp = services.BuildServiceProvider();
var s = sp.GetService<ITestService>();
```

## 注意

### 生命周期 (Scope)

- 当使用 `AddScoped` 方法注册服务时, 可以使用 `IServiceProvider` 的 扩展方法 `CreateScope` 创建一个 Scope

```csharp
using var scope = sp.CreateScope();
var s1 = scope.ServiceProvider.GetService<ITestService>();
```

- 对于 ASP.NET Core 程序, 一个 Scope 对应一个 HTTP 请求

- 不应该将短生命周期的服务用于长生命周期的服务

### 服务依赖

- 当注册的服务依赖于其他服务时, 需要同时注册所依赖的服务

### 获取服务

#### 获取 1 个实现

- 当 1 个服务有多个实现时, 若使用获取 1 个服务的方法, 则后注册的将覆盖先注册的
- 服务不存在时返回 null: (`GetService`, `GetService<>`)
- 服务不存在时抛出异常: (`GetRequiredService`, `GetRequiredService<>`)

#### 获取多个实现

- 服务不存在时返回长度为 0 的 `IEnumerable<>`: (`GetServices`, `GetServices<>`)

## 使用指南

### 使用扩展方法

- 可以为 `IServiceCollection` 接口添加新的扩展方法, 如 `AddConsoleLogger`
- 为了便于引用, 可将扩展方法放在 `Microsoft.Extensions.DependencyInjection` 名称空间下

LoggerExtension

```csharp
namespace Microsoft.Extensions.DependencyInjection;

public static class LoggerExtension
{
  public static void AddConsoleLogger(this IServiceCollection services)
  {
    services.AddScoped<ILoggerProvider, ConsoleLoggerProvider>();
  }
}
```

Program.cs

```csharp
// services.AddScoped<ILoggerProvider, ConsoleLoggerProvider>();
services.AddConsoleLogger();
```

### 多个服务读取顺序

- 实现配置的分层读取

IConfigReader

```csharp
public interface IConfigReader
{
    public string? GetValue(string name);
}
```

LayeredConfigReader : IConfigReader

```csharp
public class LayeredConfigReader : IConfigReader
{
    private readonly IEnumerable<IConfigService> services;

    public LayeredConfigReader(IEnumerable<IConfigService> services)
    {
        this.services = services;
    }

    public string? GetValue(string name)
    {
        string? value = null;

        foreach (var service in services)
        {
            if (service.GetValue(name) is { } newValue)
            {
                value = newValue;
            }
        }

        return value;
    }
}
```
