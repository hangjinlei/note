# Dialog

- [Dialog](#dialog)
  - [要点](#要点)
  - [创建对话框控件](#创建对话框控件)
  - [注册对话框和 对话框 ViewModel](#注册对话框和-对话框-viewmodel)
  - [打开对话框](#打开对话框)

## 要点

- Dialog
  - 实现 `IDialogAware` 接口 用于声明 Dialog
- ViewModel
  - 实现 `IDialogService` 接口 用于打开 Dialog

## 创建对话框控件

- 注意

  - 对话框控件必须有 ViewModel, 且必须实现 `IDialogAware` 接口

- 对话框 ViewModel 代码示例

  ```csharp
  public partial class PopupDialogViewModel : IDialogAware
  {
      public string Title { get; set; }

      public event Action<IDialogResult> RequestClose;

      // 窗口请求关闭时被调用
      public bool CanCloseDialog() => true;

      // 窗口关闭时被调用，可通过 DialogParameters 传出参数
      public void OnDialogClosed()
      {
          var dialogResult = new DialogResult(ButtonResult.OK, new DialogParameters() { { "Value", "Hello1" } });
          RequestClose?.Invoke(dialogResult);
      }

      // 窗口打开时被调用，可通过 IDialogParameters 获取传入的参数
      public void OnDialogOpened(IDialogParameters parameters)
      {
          this.Title = parameters.GetValue<string>("Value");
      }

      [RelayCommand]
      void Save()
      {
          var dialogResult = new DialogResult(ButtonResult.OK, new DialogParameters() { { "Value", "Hello2" } });
          RequestClose?.Invoke(dialogResult);
      }
  }
  ```

## 注册对话框和 对话框 ViewModel

```csharp
public void RegisterTypes(IContainerRegistry containerRegistry)
{
    containerRegistry.RegisterDialog<PopupDialog, PopupDialogViewModel>();
}
```

## 打开对话框

```csharp
private readonly IDialogService dialogService;

[RelayCommand]
void OpenDialog(string name)
{
    dialogService.ShowDialog(name, new DialogParameters() { { "Value", "Title" } }, callback =>
    {
        // 获取对话框传回的结果和参数
        if (callback.Result == ButtonResult.OK)
            this.Title = callback.Parameters.GetValue<string>("Value");
    });
}
```
