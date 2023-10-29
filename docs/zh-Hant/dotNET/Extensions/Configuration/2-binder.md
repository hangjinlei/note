# 2. 将配置文件绑定到类

## Overview

## Prerequisites

### 安装 NuGet 包

```powershell
Install-Package Microsoft.Extensions.Configuration
Install-Package Microsoft.Extensions.Configuration.Json
Install-Package Microsoft.Extensions.Configuration.Binder
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

### 声明一个与配置文件结构相同的类

```csharp
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

// 设置配置文件所在目录
configurationBuilder.SetBasePath(Environment.CurrentDirectory);

// 添加配置文件
configurationBuilder.AddJsonFile(path: "appsettings.json", optional: false, reloadOnChange: true);

// 构造 IConfigurationRoot
var configurationRoot = configurationBuilder.Build();
```

### 获取配置

```csharp
var proxy = configurationRoot.GetSection("proxy").Get<Proxy>();
```

### 完整代码

```csharp
var configurationBuilder = new ConfigurationBuilder();
configurationBuilder.SetBasePath(Environment.CurrentDirectory);
configurationBuilder.AddJsonFile(path: "appsettings.json", optional: false, reloadOnChange: true);
var configurationRoot = configurationBuilder.Build();

var proxy = configurationRoot.GetSection("proxy").Get<Proxy>();
```

### 可以将根映射到类

```csharp
public class Root
{
    public string? Name { get; set; }
    public int Age { get; set; }
    public Proxy? Proxy { get; set; }
}
```

```csharp
var root = configurationRoot.Get<Root>();
```
