# PublishSubscribe

## 要点

- `PubSubEvent<TPayload>` 用于声明事件
- `IEventAggregator` 用于发布和订阅事件

## 声明一个事件

继承 `PubSubEvent<TPayload>` 接口

MessageEvent.cs

```csharp
using Prism.Events;

namespace PrismModule.Events;

public class MessageEvent : PubSubEvent<string>
{
}
```

## 订阅和发布事件

PopupDialogViewModel.cs

- 订阅

```csharp
private readonly IEventAggregator eventAggregator;

public PopupDialogViewModel(IEventAggregator eventAggregator)
{
    this.eventAggregator = eventAggregator;

    eventAggregator.GetEvent<MessageEvent>().Subscribe(s => MessageBox.Show(s));
}
```

- 发布

```csharp
[RelayCommand]
void Cancel() => eventAggregator.GetEvent<MessageEvent>().Publish("Hello");
```
