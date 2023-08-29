# CLI Arguments

```shell
dotnet run red yellow 50
```

```csharp
Console.ForegroundColor = (ConsoleColor)Enum.Parse(typeof(ConsoleColor), args[0], true);
Console.BackgroundColor = (ConsoleColor)Enum.Parse(typeof(ConsoleColor), args[1], true);
Console.CursorSize = int.Parse(args[2]);
```
