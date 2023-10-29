# 5. 使用命令行參數

## Overview

CommandLine Args 支持多种格式, 但一次只能使用一种格式

-   `key=value`
-   `--key=value`
-   `--key value`
-   `/key=value`
-   `/key value`

## Prerequisites

### 安装 NuGet 包

```powershell
Install-Package Microsoft.Extensions.Configuration
Install-Package Microsoft.Extensions.Configuration.Binder
Install-Package Microsoft.Extensions.Configuration.CommandLine
```

### 示例配置

```shell
--name=Timothy --age=18 --proxy:address=172.16.20.168 --proxy:port=1234 --proxy:ids:0=1 --proxy:ids:1=2 --proxy:ids:2=3
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

## Step by Step

### 创建 `IConfigurationRoot` 对象

```csharp
// 创建 ConfigurationBuilder 对象
var configurationBuilder = new ConfigurationBuilder();

// 添加 CommandLine Args
configurationBuilder.AddCommandLine(args);

// 构造 IConfigurationRoot
var configurationRoot = configurationBuilder.Build();
```

### 获取配置

```csharp
var root = configurationRoot.Get<Root>();

Console.WriteLine(root?.Name);
Console.WriteLine(root?.Age);
Console.WriteLine(root?.Proxy?.Address);
Console.WriteLine(root?.Proxy?.Port);
Console.WriteLine(string.Join(", ", root?.Proxy?.Ids ?? Array.Empty<int>()));
```

### 完整代码

```csharp
var configurationBuilder = new ConfigurationBuilder();
configurationBuilder.AddCommandLine(args);
var configurationRoot = configurationBuilder.Build();

var root = configurationRoot.Get<Root>();

Console.WriteLine(root?.Name);
Console.WriteLine(root?.Age);
Console.WriteLine(root?.Proxy?.Address);
Console.WriteLine(root?.Proxy?.Port);
Console.WriteLine(string.Join(", ", root?.Proxy?.Ids ?? Array.Empty<int>()));
```
