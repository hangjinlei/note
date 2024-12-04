# 1. .NET 中的配置系统

## Overview

1. 传统 .NET Framework 中使用 `Web.config` 文件来配置应用程序的配置信息
2. 为了兼容, 仍然可以使用 `Web.config` 和 ConfigurationManager 类, 但不推荐
3. .NET 中的配置系统支持丰富的配置源, 包括`文件 (json, xml, ini 等)`, `注册表`, `环境变量`, `命令行`, `Azure Key Vault` 等, 还可以自定义配置源, 可以跟踪配置的改变, 可以按照优先级覆盖

## Prerequisites

### 安装 NuGet 包

```powershell
Install-Package Microsoft.Extensions.Configuration
Install-Package Microsoft.Extensions.Configuration.Json
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

### 获取配置

读取多级配置时使用 `:` 分隔

```csharp
var name = configurationRoot["name"];
var address = configurationRoot["proxy:address"];
```

或使用 `GetSection` 获得一个 `IConfigurationSection`

```csharp
var port = configurationRoot.GetSection("proxy:port");
```

### 完整代码

```csharp
var configurationBuilder = new ConfigurationBuilder();
configurationBuilder.SetBasePath(Environment.CurrentDirectory);

configurationBuilder.AddJsonFile(path: "appsettings.json", optional: false, reloadOnChange: true);
var configurationRoot = configurationBuilder.Build();

var name = configurationRoot["name"];
var address = configurationRoot["proxy:address"];
var port = configurationRoot.GetSection("proxy:port");
```
