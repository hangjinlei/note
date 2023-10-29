# Map

## Prerequisites

1. [使用 Dependency Injection](../dependency-injection)
2. [使用 Profile 配置](../profile)

## Sample

```csharp
var mapped = IMapper.Map<SongDto>(values);
```

## 反向映射

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
