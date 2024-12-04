# XAML

- [属性元素](https://docs.microsoft.com/zh-cn/dotnet/maui/xaml/fundamentals/essential-syntax#property-elements)
- [附加属性](https://docs.microsoft.com/zh-cn/dotnet/maui/xaml/fundamentals/essential-syntax#attached-properties)
- [内容属性](https://docs.microsoft.com/zh-cn/dotnet/maui/xaml/fundamentals/essential-syntax#content-properties)

```csharp
[ContentProperty("Content")]
public class ContentPage : TemplatedPage
{
  ...
}
```

- [平台差异](https://docs.microsoft.com/zh-cn/dotnet/maui/xaml/fundamentals/essential-syntax#platform-differences)
- 标记扩展

## x 名称空间

- x:Type
- x:Array
- x:String
- [x:Static](https://docs.microsoft.com/zh-cn/dotnet/maui/xaml/fundamentals/markup-extensions#xstatic-markup-extension)

## Pack URI

`pack://application:,,,[/程序集名称;][可选版本号;][文件夹名称/]文件名称`

- `pack://application:,,,` 可以省略

- `程序集名称` `版本号` 尝试用缺省值
