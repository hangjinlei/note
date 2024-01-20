# Control

Win UI 有两种自定义控件, 分别是 UserControl 和 CustomControl.

UserControl 是一个完整的控件, 可以包含多个控件, 也可以包含其他自定义控件, 但是不能继承自其他控件.

CustomControl 更像是一个模板, 可以通过 key 值在其他控件中引用, 更改样式便捷.

## Binding

这两种控件在绑定方式上有所不同, UserControl 可以使用 `x:Bind` 绑定, 而 CustomControl 只能使用 `TemplateBinding` 和 `Binding` 绑定.

### UserControl 绑定示例

```xaml
<TextBlock Text="{x:Bind Text}"
           Margin="{x:Bind Margin}" />

<Button Command="{x:Bind Command}" />
```

### CustomControl 绑定示例

```xaml
<TextBlock Text="{Binding RelativeSource={RelativeSource Mode=TemplatedParent}, Path=Text}"
           Margin="{TemplateBinding Margin}" />

<Button Margin="{TemplateBinding Margin}"
        Command="{Binding RelativeSource={RelativeSource Mode=TemplatedParent}, Path=Command}" />
```
