# Prism

- [Prism](#prism)
  - [安装](#安装)
  - [项目中引入](#项目中引入)
  - [绑定 View 和 ViewModel](#绑定-view-和-viewmodel)

## 安装

- NuGet
  - [Prism.DryIoc](https://www.nuget.org/packages/Prism.DryIoc)
- Visual Studio 项目模板安装
  - [Prism Template Pack](https://marketplace.visualstudio.com/items?itemName=BrianLagunas.PrismTemplatePack)

## 项目中引入

- App.xaml

- 使用

  1. 引入 prism 名称空间
  2. 修改 Application 元素

```diff
- <Application
+ <prism:PrismApplication
    x:Class="PrismDemo.App"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="clr-namespace:PrismDemo"
+   xmlns:prism="http://prismlibrary.com/">

    <Application.Resources />

- </Application>
+ </prism:PrismApplication>
```

- App.xaml.cs

- 提示

  1. 由于 partial 类的特性, 此处可以不用显式指定继承 PrismApplication
  2. 等待 IntelliSense 提示后实现抽象成员

```diff
- public partial class App : Application
+ public partial class App
  {
+   protected override Window CreateShell() => Container.Resolve<MainWindow>();
+
+   protected override void RegisterTypes (IContainerRegistry containerRegistry)
+   {
+       //throw new NotImplementedException();
+   }
  }
```

## 绑定 View 和 ViewModel

- [Registering and Discovering Modules](https://prismlibrary.com/docs/modules.html#registering-and-discovering-modules)

- 自动注入

- 注意

  - View 必须位于 Views 目录下
  - ViewModel 必须位于 ViewModels 目录下，且命名必须为 `{ViewName}ViewModel`

  - ViewA.xaml

  ```diff
    <UserControl
  +     xmlns:prism="http://prismlibrary.com/"
  +     prism:ViewModelLocator.AutoWireViewModel="True">

        <Grid>
            <TextBlock FontSize="30" Text="Module A View A" />
        </Grid>
    </UserControl>
  ```

- 注册时注入

  - App.xaml.cs

    ```csharp
    public void RegisterTypes(IContainerRegistry containerRegistry)
    {
        containerRegistry.RegisterForNavigation<ViewA, ViewAViewModel>();
    }
    ```
