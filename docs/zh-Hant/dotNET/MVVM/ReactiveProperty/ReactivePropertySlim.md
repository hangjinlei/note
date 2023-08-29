# [ReactivePropertySlim](https://okazuki.jp/ReactiveProperty/features/ReactivePropertySlim.html#reactivepropertyslim)

- [ReactivePropertySlim](#reactivepropertyslim)
  - [订阅更改](#订阅更改)
  - [创建实例](#创建实例)
  - [Dispatch to UI thread](#dispatch-to-ui-thread)

不支持从 `IObservable<T>` 创建，但可以从 `IObservable<T>` 创建 `ReadOnlyReactivePropertySlim<T>`

## 订阅更改

```csharp
public ReactiveProperty<string> Text { get; set; }

public MainWindowViewModel()
{
    Text = new ReactiveProperty<string>(string.Empty);
    Text.Subscribe(x => Console.WriteLine(x));
}
```

## 创建实例

```csharp
var rp = Observable.Interval(TimeSpan.FromSeconds(1)).ToReadOnlyReactivePropertySlim();
```

## [Dispatch to UI thread](https://okazuki.jp/ReactiveProperty/features/ReactivePropertySlim.html#dispatch-to-ui-thread)
