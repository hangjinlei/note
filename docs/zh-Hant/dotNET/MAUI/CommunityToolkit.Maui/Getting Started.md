# CommunityToolkit.Maui

- [CommunityToolkit.Maui](#communitytoolkitmaui)
  - [安装](#安装)
  - [项目中引入](#项目中引入)
  - [Components](#components)
    - [Alerts](#alerts)
    - [Behaviors](#behaviors)
    - [Views](#views)

## 安装

- NuGet
  - [CommunityToolkit.Maui](https://www.nuget.org/packages/CommunityToolkit.Maui)

## 项目中引入

```csharp
using CommunityToolkit.Maui;
```

```xaml
xmlns:toolkit="http://schemas.microsoft.com/dotnet/2022/maui/toolkit"
```

## Components

### [Alerts](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/alerts/)

| 警报                                                                                      | 说明                                                                                                                          |
| :---------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| [Snackbar](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/alerts/snackbar) | 这是 Snackbar 默认显示在屏幕底部的计时警报。 在可配置的持续时间后将其消除。 Snackbar 是完全可自定义的，可以定位到任何 IView。 |
| [toast](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/alerts/toast)       | 这是 Toast 默认显示在屏幕底部的计时警报。 在可配置的持续时间后将其消除。                                                      |

### [Behaviors](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/behaviors/)

| 行为                             | 说明                                                                                                                                                                                                  |
| :------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CharactersValidationBehavior     | 这是 `CharactersValidationBehaviorBehavior` 允许用户根据指定的参数验证文本输入。                                                                                                                      |
| EmailValidationBehavior          | 这是 `EmailValidationBehaviorBehavior` 允许用户确定文本输入是否为有效的电子邮件地址。                                                                                                                 |
| EventToCommandBehavior           | The `EventToCommandBehavior` is a behavior that allows the user to invoke a Command through an Event. 它旨在将命令与未设计为支持命令的控件公开的事件相关联。 它允许将控件上的任何任意事件映射到命令。 |
| MaskedBehavior                   | 这是 `MaskedBehaviorBehavior` 允许用户定义数据输入的输入掩码。                                                                                                                                        |
| MaxLengthReachedBehavior         | `MaxLengthReachedBehavior` 这是一种行为，允许用户在用户达到允许 InputView 的最大长度时触发操作。                                                                                                      |
| MultiValidationBehavior          | 这是 `MultiValidationBehaviorBehavior` 允许用户组合多个验证程序以根据指定的参数验证文本输入。                                                                                                         |
| NumericValidationBehavior        | 这是 `NumericValidationBehaviorBehavior` 允许用户确定文本输入是否为有效的数值。                                                                                                                       |
| ProgressBarAnimationBehavior     | 对 `ProgressBarAnimationBehavior` 从当前进度值到一段时间内提供的值进行动画 ProgressBar 处理。                                                                                                         |
| RequiredStringValidationBehavior | 这是 `RequiredStringValidationBehaviorBehavior` 允许用户确定文本输入是否等于特定文本。                                                                                                                |
| SetFocusOnEntryCompletedBehavior | 它是 `SetFocusOnEntryCompletedBehavior` 一种 Behavior 在完成时 Entry 为指定 VisualElement 焦点提供焦点。                                                                                              |
| TextValidationBehavior           | 这是 `TextValidationBehavior` 允许用户根据指定参数验证给定文本的一种 Behavior 。                                                                                                                      |
| UriValidationBehavior            | 这是 `UriValidationBehaviorBehavior` 允许用户确定文本输入是否为有效的 URI。                                                                                                                           |
| UserStoppedTypingBehavior        | `UserStoppedTypingBehavior` 这是一种行为，允许用户在用户停止数据输入 Entry 时触发操作。                                                                                                               |

### [Views](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/views/)

| 视图                                                                                           | 说明                                                                                   |
| :--------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| [AvatarView](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/views/avatarview)   | 该 `AvatarView` 控件用于显示用户的头像图像或其首字母缩写。                             |
| [DrawingView](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/views/drawingview) | 该 `DrawingView` 图面允许使用触摸或鼠标交互绘制线条。 用户可以将绘图的结果保存为图像。 |
| [Popup](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/maui/views/popup)             | 该 `Popup` 视图允许开发人员生成自己的自定义 UI 并将其呈现给用户。                      |
