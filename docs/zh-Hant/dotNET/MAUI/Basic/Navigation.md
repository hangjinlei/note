# Navigation

- [Navigation](#navigation)
  - [Shell (Recommend)](#shell-recommend)
  - [NavigationPage](#navigationpage)

## [Shell](https://docs.microsoft.com/zh-cn/dotnet/maui/fundamentals/shell/navigation) (Recommend)

    1. [注册路由](https://docs.microsoft.com/zh-cn/dotnet/maui/fundamentals/shell/navigation#register-routes)
    1. [注册详细信息页路由](https://docs.microsoft.com/zh-cn/dotnet/maui/fundamentals/shell/navigation#register-detail-page-routes)

## [NavigationPage](https://docs.microsoft.com/zh-cn/dotnet/maui/user-interface/pages/navigationpage)

    - 使用 NavigationPage

    ```csharp
    public App()
    {
        InitializeComponent();
        MainPage = new NavigationPage(new MainPage());
    }
    ```

    - 使用 Microsoft.Maui.Controls.NavigableElement 的 Navigation 属性

    ```csharp
    Navigation.PushAsync(new MainPage());
    ```
