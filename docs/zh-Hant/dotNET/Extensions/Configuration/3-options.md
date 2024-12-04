# 3. 将 Options 与 DI 一起使用

## Overview

3 种方式

-   **IOptions**: 不更新配置值
-   **IOptionsMonitor**: 立即更新配置值, 更新时会触发 `OnChange` 事件
-   **IOptionsSnapshot**: 在同一个 Scope 中不更新配置值

## Prerequisites

### 安装 NuGet 包

```powershell
Install-Package Microsoft.Extensions.DependencyInjection
Install-Package Microsoft.Extensions.Configuration
Install-Package Microsoft.Extensions.Configuration.Json
Install-Package Microsoft.Extensions.Configuration.Binder
Install-Package Microsoft.Extensions.Options
```

### 声明一个与配置文件结构相同的类

```csharp
public class Root
{
    public string? Name { get; set; }
    public int Age { get; set; }
    public Proxy? Proxy { get; set; }
}

public class Proxy
{
    public string? Address { get; set; }
    public int Port { get; set; }
}
```

### 示例配置文件

```json
{
    "name": "Timothy",
    "age": 18,
    "proxy": {
        "address": "172.16.20.168",
        "port": 1234
    }
}
```

## Step by Step

### 创建 `IConfigurationRoot` 对象

```csharp
// 创建 ConfigurationBuilder 对象
var configurationBuilder = new ConfigurationBuilder();

// 设置配置文件所在目录
configurationBuilder.SetBasePath(Environment.CurrentDirectory);

// 添加配置文件
configurationBuilder.AddJsonFile(path: "appsettings.json", optional: false, reloadOnChange: true);

// 构造 IConfigurationRoot
var configurationRoot = configurationBuilder.Build();
```

### 注册服务

需要将配置绑定到 `IConfigurationRoot` 上

```csharp
services.AddOptions()
    .Configure<Root>(configurationRoot.Bind)
    .Configure<Proxy>(p => configurationRoot.GetSection("proxy").Bind(p));
services.AddScoped<Controller>();
```

### 获取配置

```csharp
public class Controller
{
    private readonly IOptionsSnapshot<Root> optionsSnapshot;
    private readonly IOptionsMonitor<Root> optionsMonitor;
    private readonly IOptions<Proxy> options;

    public Controller(IOptionsSnapshot<Root> optionsSnapshot, IOptionsMonitor<Root> optionsMonitor, IOptions<Proxy> options)
    {
        this.optionsSnapshot = optionsSnapshot;
        this.optionsMonitor = optionsMonitor;
        this.options = options;

        this.optionsMonitor.OnChange((root, name) => Console.WriteLine($"optionsMonitor.OnChange: {name}"));
    }
}
```

### 完整代码

Controller

```csharp
public class Controller
{
    private readonly IOptionsSnapshot<Root> optionsSnapshot;
    private readonly IOptionsMonitor<Root> optionsMonitor;
    private readonly IOptions<Proxy> options;

    public Controller(IOptionsSnapshot<Root> optionsSnapshot, IOptionsMonitor<Root> optionsMonitor, IOptions<Proxy> options)
    {
        this.optionsSnapshot = optionsSnapshot;
        this.optionsMonitor = optionsMonitor;
        this.options = options;

        this.optionsMonitor.OnChange((root, name) => Console.WriteLine($"optionsMonitor.OnChange: {name}"));
    }

    public void ShowSnapshot()
    {
        Console.WriteLine($"[OptionsSnapshot] - {optionsSnapshot.Value.Proxy?.Address}");
    }

    public void ShowMonitor()
    {
        Console.WriteLine($"[OptionsMonitor] - {optionsMonitor.CurrentValue.Proxy?.Address}");
    }

    public void ShowOptions()
    {
        Console.WriteLine($"[Options] - {options.Value.Address}");
    }
}
```

Program.cs

```csharp
var services = new ServiceCollection();

var configurationBuilder = new ConfigurationBuilder();
configurationBuilder.SetBasePath(Environment.CurrentDirectory);
configurationBuilder.AddJsonFile(path: "appsettings.json", optional: false, reloadOnChange: true);
var configurationRoot = configurationBuilder.Build();

// services.AddOptions().Configure<Root>(r => configurationRoot.Bind(r));
services.AddOptions()
    .Configure<Root>(configurationRoot.Bind)
    .Configure<Proxy>(p => configurationRoot.GetSection("proxy").Bind(p));
services.AddScoped<Controller>();

using var sp = services.BuildServiceProvider();

while (true)
{
    using var scope = sp.CreateScope();
    var controller = scope.ServiceProvider.GetRequiredService<Controller>();
    controller.ShowSnapshot();
    controller.ShowMonitor();
    controller.ShowOptions();

    Console.WriteLine("change appsettings.json and press any key");
    Console.ReadKey();

    controller.ShowSnapshot(); // same as above
    controller.ShowMonitor(); // changed
    controller.ShowOptions(); // never changed

    Console.WriteLine("press any key to continue");
    Console.ReadKey();
}
```
