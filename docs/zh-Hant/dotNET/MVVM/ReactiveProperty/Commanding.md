# Commanding

- [Commanding](#commanding)
  - [示例](#示例)
  - [Work with LINQ](#work-with-linq)

## 示例

```csharp
public class ViewModel
{
    public ReactiveCommand UpdateTimeCommand { get; }

    public ReactiveProperty<string> Time { get; }

    public ViewModel()
    {
        Time = new ReactiveProperty<string>();
        UpdateTimeCommand = new ReactiveCommand();
        UpdateTimeCommand.Subscribe(_ => Time.Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));
    }
}
```

## [Work with LINQ](https://okazuki.jp/ReactiveProperty/features/Commanding.html#work-with-linq)

```diff
 public class CommandingViewModel
 {
     public ReactiveCommand UpdateTimeCommand { get; }

     public ReactiveProperty<string?> Time { get; }

     public CommandingViewModel()
     {
-        Time = new ReactiveProperty<string>();
-        UpdateTimeCommand = new ReactiveCommand();
-        UpdateTimeCommand.Subscribe(_ => Time.Value = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss"));

+        UpdateTimeCommand = new ReactiveCommand();
+
+        Time = UpdateTimeCommand.Select(_ => DateTime.UtcNow.ToString("yyyy/MM/dd HH:mm:ss")).ToReactiveProperty();
     }
 }
```
