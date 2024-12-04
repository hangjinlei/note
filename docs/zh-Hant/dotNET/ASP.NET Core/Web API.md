# ASP.NET Core Web API

## HTTP Method

### GET

### POST

### PUT

### PATCH

參照官方教學 [JsonPatch in ASP.NET Core web API](https://learn.microsoft.com/en-us/aspnet/core/web-api/jsonpatch), 使用 `Microsoft.AspNetCore.JsonPatch` 套件來實現 PATCH 方法.

```csharp
[HttpPatch("{id}")]
public async Task<IActionResult> Patch(int id, [FromBody] JsonPatchDocument patch)
{
	var entity = await _context.Table.FindAsync(id);

	patch.ApplyTo(entity);

	await _context.SaveChangesAsync();

	return NoContent();
}
```

### DELETE

## AutoMapper

## Entity Framework Core

### Select

### Add

使用內建函式匹配新增資源, 這樣可以避免手動設定每個欄位的值, 並且可以避免遺漏欄位.

```csharp
_context.Table.Add(new Entity()).CurrentValues.SetValues(value);
```

### Update

使用內建函式匹配更新資源, 這樣可以避免手動設定每個欄位的值, 並且可以避免遺漏欄位.

```csharp
var entity = _context.Table.Find(id);

_context.Table.Update(entity).CurrentValues.SetValues(value);
```

### Remove

### Query

EF 支援使用原始 SQL 查詢資料庫, 要小心 SQL Injection.

```csharp
_context.Database.SqlQueryRaw<Entity>(sql);
```

## Model Validation

对于使用 Attribute 的场景, 可以使用继承 `ValidationAttribute` 的方式, 通过重写 `IsValid` 方法来实现自定义验证逻辑.

```csharp
public class CustomValidationAttribute : ValidationAttribute
{
	protected override ValidationResult IsValid(object value, ValidationContext validationContext)
	{
		if (value == null)
		{
			return new ValidationResult("Value cannot be null.");
		}

		return ValidationResult.Success;
	}
}
```

对于使用 DTO 的场景, 可以使用实现 `IValidatableObject` 接口的方式, 通过实现 `Validate` 方法来实现自定义验证逻辑. 同时可以将共通的验证逻辑抽取到基类中.

```csharp
public class CustomDto : IValidatableObject
{
	public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
	{
		if (string.IsNullOrEmpty(Name))
		{
			yield return new ValidationResult("Name cannot be null or empty.", new[] { nameof(Name) });
		}
	}
}
```

## Upload File

启用大文件上传, 可以通过配置 `Kestrel` 来设置最大请求体大小.

```csharp
builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.Limits.MaxRequestBodySize = long.MaxValue;
});
```

## Download Static File

```csharp
app.UseStaticFiles();
```
