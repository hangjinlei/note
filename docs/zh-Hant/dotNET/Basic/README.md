# Getting Started

## 中国大陆镜像

https://nuget.cdn.azure.cn/v3/index.json

## 配置文件架构

https://json.schemastore.org/appsettings.json

## CLI Arguments

```shell
dotnet run red yellow 50
```

```csharp
Console.ForegroundColor = (ConsoleColor)Enum.Parse(typeof(ConsoleColor), args[0], true);
Console.BackgroundColor = (ConsoleColor)Enum.Parse(typeof(ConsoleColor), args[1], true);
Console.CursorSize = int.Parse(args[2]);
```

## References

-   [C# 枚举高级技巧](https://zhuanlan.zhihu.com/p/252986069)
-   [C#教程（非常详细）](http://c.biancheng.net/csharp/)
-   [吕毅](https://blog.walterlv.com/)
