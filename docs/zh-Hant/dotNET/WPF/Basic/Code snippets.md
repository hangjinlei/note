# Code snippets

## 在 XAML 中使用 `mscorlib` 库

```xaml
xmlns:sys="clr-namespace:System;assembly=mscorlib"
```

## 在 XAML 中使用 `System.Runtime` 库

```xaml
xmlns:sys="clr-namespace:System;assembly=System.Runtime"
```

## 在 XAML 中使用资源路径 (Pack URI)

`pack://application:,,,[/程序集名称;][可选版本号;][文件夹名称/]文件名称`

-   `pack://application:,,,` 可以省略

-   `程序集名称` `版本号` 尝试用缺省值

## 播放声音

```csharp
System.Media.SystemSounds.Asterisk.Play();
```

## 打开浏览器

```csharp
var destinationUrl = "www.google.com";
var sInfo = new ProcessStartInfo(destinationUrl)
{
    UseShellExecute = true,
};
Process.Start(sInfo);
```

## References

-   [WPF 学习笔记-使用默认浏览器打开网页出现用户未处理的异常 | 观心塾](http://xn--zsry58c.xn--6qq986b3xl/blog/WPF%20%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0-%E4%BD%BF%E7%94%A8%E9%BB%98%E8%AE%A4%E6%B5%8F%E8%A7%88%E5%99%A8%E6%89%93%E5%BC%80%E7%BD%91%E9%A1%B5%E5%87%BA%E7%8E%B0%E7%94%A8%E6%88%B7%E6%9C%AA%E5%A4%84%E7%90%86%E7%9A%84%E5%BC%82%E5%B8%B8/#%E5%8F%82%E8%80%83%E8%B5%84%E6%96%99)
-   [System.Diagnostics.Process.Start · Issue #2566 · dotnet/wpf](https://github.com/dotnet/wpf/issues/2566)
-   [c# - Open Browser with URL WPF - Stack Overflow](https://stackoverflow.com/questions/60181640/open-browser-with-url-wpf/60221582#60221582)
