# 从 View 事件调用 ViewModel 方法的操作

使用名称空间 `xmlns:l="http://schemas.livet-mvvm.net/2011/wpf"` 中的 `LivetCallMethodAction` 类

Docs: [GitHub - runceel/Livet - View のイベントから ViewModel のメソッドを呼ぶアクション](https://github.com/runceel/Livet#view-%E3%81%AE%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88%E3%81%8B%E3%82%89-viewmodel-%E3%81%AE%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%82%92%E5%91%BC%E3%81%B6%E3%82%A2%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3)

View

```xml
xmlns:i="http://schemas.microsoft.com/xaml/behaviors"
xmlns:l="http://schemas.livet-mvvm.net/2011/wpf"
```

```xml
<Button Content="Event to Method">
    <i:Interaction.Triggers>
        <i:EventTrigger EventName="MouseEnter">
            <l:LivetCallMethodAction
                MethodName="MouseClickCommand"
                MethodParameter="{Binding RelativeSource={RelativeSource AncestorType={x:Type Button}}}"
                MethodTarget="{Binding}" />
        </i:EventTrigger>
    </i:Interaction.Triggers>
</Button>
```

ViewModel

```csharp
public void MouseClickCommand(Button button)
{
    MessageBox.Show("Mouse Enter");
}
```
