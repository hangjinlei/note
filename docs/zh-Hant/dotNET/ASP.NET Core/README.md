# ASP.NET Core

## 内置服务器

Kestrel

## 常用环境变量

ASPNETCORE_ENVIRONMENT

```plaintext
Development
Staging
Production
Integration
Testing
QA
UAT // 用户验收测试
```

## 配置文件 `appsettings.json`

[配置文件读取顺序](https://github.com/dotnet/runtime/blob/main/src/libraries/Microsoft.Extensions.Hosting/src/HostingHostBuilderExtensions.cs#L175-L193)

```plaintext
appsettings.json
appsettings.{Environment}.json
User Secret
Environment Variables
Command Line arguments
```

## CLI

```plaintext
dotnet ./app.dll --urls="http://*:80"
```

## 特殊的依赖注入

-   [IHttpContextAccessor](https://docs.microsoft.com/zh-cn/dotnet/api/microsoft.aspnetcore.http.ihttpcontextaccessor)
-   IRazorViewEngine
-   ITempDataProvider
-   IActionContextAccessor

## 高级内容

-   [在 ASP.NET Core 中强制使用 HTTPS](https://learn.microsoft.com/zh-cn/aspnet/core/security/enforcing-ssl)
-   [ASP.NET Core 中的模型绑定](https://learn.microsoft.com/en-us/aspnet/core/mvc/models/model-binding)
