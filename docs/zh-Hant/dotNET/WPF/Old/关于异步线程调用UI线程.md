# 关于异步线程调用 UI 线程

## 使用 [🚀 MvvmLight](https://github.com/lbugnion/mvvmlight)

使用 `Application.Current.Dispatcher`

```csharp
Application.Current.Dispatcher.Invoke(() => IsBusy = true);
```

使用 `DispatcherHelper`

```csharp
DispatcherHelper.Initialize();

DispatcherHelper.CheckBeginInvokeOnUI(() => IsBusy = true);
```
