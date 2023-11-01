# Profile

## Sample

### 注意

```plaintext
CreateMap 方法中的泛型类型, 第一个为源类型, 第二个为目标类型
```

### 说明

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
