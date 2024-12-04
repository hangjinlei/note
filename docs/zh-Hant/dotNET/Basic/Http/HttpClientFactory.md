# HttpClientFactory

NuGet

- [Microsoft.Extensions.Http](https://www.nuget.org/packages/Microsoft.Extensions.Http)

## 示例

```csharp
// 使用服务注入时可以不使用Client Name
builder.Services.AddHttpClient<IUserService, UserService>("UserService", client =>
{
	client.BaseAddress = new Uri("https://localhost:7284/api/Users/");
	client.DefaultRequestHeaders.Add("User-Agent", "BlazorServer");
}).AddHttpMessageHandler<ValidateHeaderHandler>(); // 校验HTTP 头

builder.Services.AddTransient<ValidateHeaderHandler>(); // 校验HTTP 头
```

## 注意

- 注册时可同时注册服务内的 HttpClient 实例
- 构造注入时仍然使用 HttpClient
