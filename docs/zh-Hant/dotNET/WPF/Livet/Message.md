# Message

- [Message](#message)
  - [支持从 View 打开 Dialog，并通过回调方法将消息传递到 ViewModel](#支持从-view-打开-dialog并通过回调方法将消息传递到-viewmodel)
  - [从 ViewModel 打开 Dialog](#从-viewmodel-打开-dialog)
    - [示例 - 从 View 打开 Dialog，并通过回调方法将消息传递到 ViewModel](#示例---从-view-打开-dialog并通过回调方法将消息传递到-viewmodel)
    - [示例 - 从 ViewModel 打开 Dialog](#示例---从-viewmodel-打开-dialog)

---

Docs: [GitHub - runceel/Livet - Messenger](https://github.com/runceel/Livet#messenger)

- 支持从 View 打开 Dialog，并通过回调方法将消息传递到 ViewModel
- 支持从 ViewModel 打开 Dialog

> namespace `Livet.Behaviors.Messaging`
>
> - `ConfirmationDialogInteractionMessageAction`
> - `InformationDialogInteractionMessageAction`
>
> namespace `Livet.Behaviors.Messaging.IO`
>
> - `OpenFileDialogInteractionMessageAction`
> - `SaveFileDialogInteractionMessageAction`
>
> namespace `Livet.Messaging`
>
> - `ConfirmationMessage`
> - `InformationMessage`
> - `OpeningFileSelectionMessage`
> - `SavingFileSelectionMessage`

---

## 支持从 View 打开 Dialog，并通过回调方法将消息传递到 ViewModel

1. 在 XAML 中使用 `InteractionMessageAction`, 如 `ConfirmationDialogInteractionMessageAction`
2. 通过使用 `DirectInteractionMessage` 直接打开 Dialog
3. 必须传入 `ConfirmationMessage`

   ```xml
   <l:ConfirmationDialogInteractionMessageAction>
       <l:DirectInteractionMessage CallbackMethodName="ConfirmFromView" CallbackMethodTarget="{Binding}">
           <l:ConfirmationMessage Caption="テスト" Text="これはテスト用メッセージです。" />
       </l:DirectInteractionMessage>
   </l:ConfirmationDialogInteractionMessageAction>
   ```

## 从 ViewModel 打开 Dialog

1. ViewModel 通过设置的`MessageKey` 来查找视图中的 Dialog

---

### 示例 - 从 View 打开 Dialog，并通过回调方法将消息传递到 ViewModel

```xml
xmlns:i="http://schemas.microsoft.com/xaml/behaviors"
xmlns:l="http://schemas.livet-mvvm.net/2011/wpf"
```

- ConfirmationDialog 示例

  - 从 View 打开

    View

    ```diff
     <Button Content="ConfirmFromView">
         <i:Interaction.Triggers>
             <i:EventTrigger EventName="Click">
    +            <l:ConfirmationDialogInteractionMessageAction>
    +                <l:DirectInteractionMessage CallbackMethodName="ConfirmFromView" CallbackMethodTarget="{Binding}">
    +                    <l:ConfirmationMessage Caption="テスト" Text="これはテスト用メッセージです。" />
    +                </l:DirectInteractionMessage>
    +            </l:ConfirmationDialogInteractionMessageAction>
             </i:EventTrigger>
         </i:Interaction.Triggers>
     </Button>
    ```

    ViewModel

    ```csharp
    public void ConfirmFromView(ConfirmationMessage message)
    {
        OutputMessage = $"{DateTime.Now}: ConfirmFromView: {message.Response ?? false}";
    }
    ```

- OpenFileDialog 示例

  - 从 View 打开

    View

    ```diff
     <Button
         Width="200"
         Height="30"
         Content="File Open">
         <i:Interaction.Triggers>
             <i:EventTrigger EventName="Click">
    +            <l:OpenFileDialogInteractionMessageAction>
    +                <l:DirectInteractionMessage CallbackMethodName="RequestFile" CallbackMethodTarget="{Binding}">
    +                    <l:OpeningFileSelectionMessage Filter="Image files (*.bmp, *.jpg)|*.bmp;*.jpg|All files (*.*)|*.*" />
    +                </l:DirectInteractionMessage>
    +            </l:OpenFileDialogInteractionMessageAction>
             </i:EventTrigger>
         </i:Interaction.Triggers>
     </Button>
    ```

    ViewModel

    ```csharp
    public void RequestFile(OpeningFileSelectionMessage message)
    {
        MessageBox.Show("Open");
    }
    ```

### 示例 - 从 ViewModel 打开 Dialog

View

```xml
<Window
    ...>

    ...

    <!--  必须添加，确保MessageKey 与调用者的MessageKey 一致, Messenger 已绑定到ViewModel  -->
    <i:Interaction.Triggers>
        <l:InteractionMessageTrigger MessageKey="MessageKey_Confirm" Messenger="{Binding Messenger}">
            <l:ConfirmationDialogInteractionMessageAction />
        </l:InteractionMessageTrigger>
    </i:Interaction.Triggers>
</Window>
```

ViewModel

```csharp
// 确保已创建InteractionMessenger
public InteractionMessenger Messenger { get; set; } = new InteractionMessenger();
public async void ConfirmFromViewModel()
{
    // 确保 MessageKey 与View 中的MessageKey 匹配
    var message = new ConfirmationMessage("これはテスト用メッセージです。", "テスト", "MessageKey_Confirm")
    {
        Button = MessageBoxButton.OKCancel,
    };
    await Messenger.RaiseAsync(message);
    OutputMessage.Value = $"{DateTime.Now}: ConfirmFromViewModel: {message.Response ?? false}";
}
```
