# AutoMapper

-   [NuGet](https://www.nuget.org/packages/AutoMapper)
-   [Docs](https://docs.automapper.org/en/stable/index.html)

## Getting Started

1. 注册 services

    ```csharp
    builder.Services.AddAutoMapper(Assembly.GetExecutingAssembly());
    ```

2. 创建一个配置档

    ```csharp
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<Source, Destination>();
        }
    }
    ```

3. 依赖注入

    ```csharp
    public class Service
    {
        private readonly IMapper _mapper;

        public Service(IMapper mapper)
        {
            _mapper = mapper;
        }
    }
    ```

4. 使用

    ```csharp
    var destination = _mapper.Map<Destination>(source);
    ```

---

## 手动配置

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

## 关于 Map 的说明

### 反向映射

```csharp
public async Task<ApiResponse> AddAsync(ToDoDto entity)
{
    try
    {
        var mapEntity = _mapper.Map<ToDo>(entity);

        await _unitOfWork.GetRepository<ToDo>().InsertAsync(mapEntity);
        if (await _unitOfWork.SaveChangesAsync() > 0)
            return new(true, mapEntity);
        return new("添加数据失败");
    }
    catch (Exception ex)
    {
        return new(ex.Message);
    }
}
```

---

## 关于 Profile 的说明

```plaintext
对于简单的属性名会自动映射, 直接在构造函数中使用 `CreateMap` 即可

当需要匹配的属性名为 类型 + 属性名的 组合形式, 如 `Singer.Name`, 将 DTO 的属性名设为 `SingerName` 时可以完成自动匹配

对于复杂的属性名需要使用 `ForMember` 进行映射, 其中, 使用 `MapFrom` 指定被映射的值的数据来源, 可以在其中对值进行拼接等操作

对于需要反向映射的属性, 需要使用 `ReverseMap`
```

### 示例代码

AutoMapperProfile.cs

```csharp
public class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<IEnumerable<Song>, IEnumerable<SongDto>>().ReverseMap();
        CreateMap<Song, SongDto>().ReverseMap();

        CreateMap<Singer, SingerDto>()
            .ForMember(a => a.TotalCount, b => b.MapFrom(c => c.Songs.Count))
            .ForMember(a => a.AvailableCount, b => b.MapFrom(c => c.Songs.Count(s => !string.IsNullOrEmpty(s.PlayUrl))))
            .ForMember(a => a.UnAvailableCount, b => b.MapFrom(c => c.Songs.Count(s => string.IsNullOrEmpty(s.PlayUrl))))
            .ReverseMap();

        CreateMap<Singer, SingerDetailsDto>()
            .ForMember(a => a.TotalCount, b => b.MapFrom(c => c.Songs.Count))
            .ForMember(a => a.AvailableCount, b => b.MapFrom(c => c.Songs.Count(c => !string.IsNullOrEmpty(c.PlayUrl))))
            .ForMember(a => a.UnAvailableCount, b => b.MapFrom(c => c.Songs.Count(s => string.IsNullOrEmpty(s.PlayUrl))))
            .ForMember(a => a.AvailableSongs, b => b.MapFrom(c => c.Songs.Where(s => !string.IsNullOrEmpty(s.PlayUrl))))
            .ForMember(a => a.UnAvailableSongs, b => b.MapFrom(c => c.Songs.Where(s => string.IsNullOrEmpty(s.PlayUrl))))
            .ReverseMap();

        CreateMap<IPagedList<Singer>, PagedList<SingerDto>>().ReverseMap();
    }
}
```

---

## Reference

-   [Microsoft Learn - 创建数据传输对象 (DTO)](https://docs.microsoft.com/zh-cn/aspnet/web-api/overview/data/using-web-api-with-entity-framework/part-5)

## 泛型 Mapper

当使用 `AutoMapper` 匹配泛型时，泛型类型也需要在配置类中配置

示例: 使用 `Arch.EntityFrameworkCore.UnitOfWork.Collections.PagedList` 泛型时

AutoMapperProfile.cs

```csharp
public class AutoMapperProfile : MapperConfigurationExpression
{
    public AutoMapperProfile()
    {
        CreateMap<Singer, SingerDto>(); // 必须添加
        CreateMap<IPagedList<Singer>, PagedList<SingerDto>>().ReverseMap();
    }
}
```

Mapper 时

```csharp
var mapSingers = _mapper.Map<IPagedList<Singer>, PagedList<SingerDto>>(singers);
```
