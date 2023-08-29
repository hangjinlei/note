# log4net

## NuGet

- [log4net](https://www.nuget.org/packages/log4net)
- Microsoft.Extensions.Logging.Log4Net.AspNetCore

## 配置文件参考

http://logging.apache.org/log4net/release/config-examples.html

## 使用

### .NET 5

1. 不指定配置文件路径，默认为根目录
2. Program.cs 和 Startup.cs 二选一即可

- Program

```csharp
public static IHostBuilder CreateHostBuilder(string[] args) =>
	Host
	/* * */
	.ConfigureLogging(loggingBuilder =>
	{
		loggingBuilder.AddLog4Net("CfgFile/log4net.config");
});
```

- Startup

```csharp
public void Configure(IApplicationBuilder app, IWebHostEnvironment env, Microsoft.Extensions.Logging.ILoggerFactory loggerFactory)
{
	/* * */
	loggerFactory.AddLog4Net(Configuration.GetSection("logfile").Value);
	/* * */
}
```

### .NET 6

Program

```csharp
var builder = WebApplication.CreateBuilder(args);
builder.Logging.AddLog4Net(builder.Configuration.GetSection("logfile").Value);
/* * */
```
