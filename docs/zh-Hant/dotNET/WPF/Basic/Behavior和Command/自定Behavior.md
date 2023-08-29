# 自定 Behavior 绑定到事件

Microsoft 提供的 `InvokeCommandAction`, 参考 [Microsoft.Xaml.Behaviors.InvokeCommandAction](https://github.com/microsoft/XamlBehaviorsWpf/blob/master/src/Microsoft.Xaml.Behaviors/InvokeCommandAction.cs)

```xaml
<i:Interaction.Triggers>
    <i:EventTrigger>
        <i:InvokeCommandAction Command="{Binding}" CommandParameter="{Binding}" />
    </i:EventTrigger>
</i:Interaction.Triggers>
```

1. 继承 `TriggerAction<DependencyObject>`
2. 注册 `ICommand` 类型的命令依赖属性
3. 注册 `object` 类型的命令参数依赖属性
4. 重写 `Invoke` 方法

```csharp
public class MyEventCommand : TriggerAction<DependencyObject>
{
    // 注册 `ICommand` 类型的命令依赖属性
    public ICommand Command
    {
        get { return (ICommand)GetValue(CommandProperty); }
        set { SetValue(CommandProperty, value); }
    }

    public static readonly DependencyProperty CommandProperty =
        DependencyProperty.Register("Command", typeof(ICommand), typeof(MyEventCommand), new PropertyMetadata(null));


    // 注册 `object` 类型的命令参数依赖属性
    public object CommandParameter
    {
        get { return (object)GetValue(CommandParameterProperty); }
        set { SetValue(CommandParameterProperty, value); }
    }

    public static readonly DependencyProperty CommandParameterProperty =
        DependencyProperty.Register("CommandParameter", typeof(object), typeof(MyEventCommand), new PropertyMetadata(null));


    // 重写 `Invoke` 方法
    protected override void Invoke(object parameter)
    {
        ArgumentNullException.ThrowIfNull(Command);

        if (CommandParameter is { })
        {
            parameter = CommandParameter;
        }

        Command.Execute(parameter);
    }
}
```
