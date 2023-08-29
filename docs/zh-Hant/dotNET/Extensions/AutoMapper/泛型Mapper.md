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
