# Dependency Injection

## NuGet

-   [AutoMapper.Extensions.Microsoft.DependencyInjection](https://www.nuget.org/packages/AutoMapper.Extensions.Microsoft.DependencyInjection)

## 示例代码

### 注册 AutoMapper

Program.cs

```csharp
builder.Services.AddAutoMapper(typeof(Program));
```

### 注入 IMapper 服务

Service.cs

```csharp
private readonly IMapper _mapper;

public Service(IMapper mapper)
{
    _mapper = mapper;
}
```
