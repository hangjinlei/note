# 手动配置

## NuGet

-   [AutoMapper](https://www.nuget.org/packages/AutoMapper)

## Sample

1. 继承 `MapperConfigurationExpression`

    AutoMapperProfile.cs

    ```csharp
    public class AutoMapperProfile : MapperConfigurationExpression
    {
        public AutoMapperProfile()
        {
            CreateMap<ToDo, ToDoDto>().ReverseMap();
        }
    }
    ```

2. 注册配置类

    Program.cs

    ```csharp
    var mapperConfiguration = new MapperConfiguration(config =>
    {
        config.AddProfile<AutoMapperProfile>();
    });
    builder.Services.AddSingleton(mapperConfiguration.CreateMapper());
    ```

3. [使用 Dependency Injection](../fundamentals/dependency-injection)
4. [使用 Map](../fundamentals/map)
