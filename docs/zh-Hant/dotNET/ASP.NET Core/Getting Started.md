# Getting Started

1. 内置服务器: `Kestrel`

2. 常用环境变量 `ASPNETCORE_ENVIRONMENT`

   ```shell
   Development
   Staging
   Production
   Integration
   Testing
   QA // 质量保证
   UAT // 用户验收测试
   ```

3. 配置文件 `appsettings.json`

   [🚀 配置文件读取顺序](https://github.com/dotnet/runtime/blob/8048fe613933a1cd91e3fad6d571c74f726143ef/src/libraries/Microsoft.Extensions.Hosting/src/HostingHostBuilderExtensions.cs)

   ```shell
   appsettings.json
   appsettings.{Environment}.json
   User Secret 用户机密
   Environment Variables 环境变量
   Command Line arguments 命令行参数
   ```

4. CLI

   - 指定端口启动 `--urls`

     ```shell
     dotnet .\BlazorWebAssembly.Server.dll --urls="http://*:80"
     ```
