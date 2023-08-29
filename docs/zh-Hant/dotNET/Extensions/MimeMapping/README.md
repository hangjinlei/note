# MimeMapping

- 说明

  此包用于根据文件后缀解析 MimeType

## 示例

```csharp
var files = Directory.GetFiles(@"C:\Users\hangj\OneDrive\Music\11");

foreach (var file in files)
{
    Console.WriteLine(MimeMapping.MimeUtility.GetMimeMapping(file));
}
```

## 参考

- [GitHub](https://github.com/zone117x/MimeMapping)
- [NuGet](https://www.nuget.org/packages/MimeMapping)
