# Module

- [Module](#module)
  - [要点](#要点)
  - [创建 Module](#创建-module)
    - [配置类参考](#配置类参考)
  - [使用方式](#使用方式)
    - [强引用](#强引用)
    - [弱引用](#弱引用)

## 要点

- Module
  - 实现 `IModule` 接口 用于声明 Module
- ModuleProfile
  - `IContainerRegistry` 用于注入
- ViewModel
  - `IRegionManager` 用于导航

## 创建 Module

1. 新建 WPF 项目, 将项目生成类型修改为类库
2. 引用 NuGet [`Prism.DryIoc`](https://www.nuget.org/packages/Prism.DryIoc)
3. 删除所有代码文件
4. 项目根目录创建 `ModuleAProfile` 类 实现 `IModule` 接口

### 配置类参考

- 提示

  1. 与 PrismApplication 使用相似, 可以使用依赖注入

- ModuleAProfile 代码

  ```csharp
  namespace ModuleA;

  public class ModuleAProfile : IModule
  {
      public void OnInitialized(IContainerProvider containerProvider)
      {
      }

      public void RegisterTypes(IContainerRegistry containerRegistry)
      {
          containerRegistry.RegisterForNavigation<ViewA>();
      }
  }
  ```

## 使用方式

### 强引用

- 实现

  1. 添加对 Module 的引用，重写 `App` 类的 `ConfigureModuleCatalog` 方法

- App.xaml.cs

  ```csharp
  public partial class App : PrismApplication
  {
      protected override Window CreateShell() => Container.Resolve<MainWindow>();

      protected override void RegisterTypes(IContainerRegistry containerRegistry)
      {

      }

      // 注册 Module
      protected override void ConfigureModuleCatalog(IModuleCatalog moduleCatalog)
      {
          moduleCatalog.AddModule<ModuleAProfile>();
          moduleCatalog.AddModule<ModuleBProfile>();
          base.ConfigureModuleCatalog(moduleCatalog);
      }
  }
  ```

- 使用 Module 中的 View

  ```csharp
  void Navigate(string name) => regionManager.Regions["ContentRegion"].RequestNavigate(name);
  ```

### 弱引用

- 实现

  1. 重写 `CreateModuleCatalog` 方法，并返回一个 `DirectoryModuleCatalog` 对象，指定 Module dll 的路径

- App.xaml.cs

  ```csharp
  public partial class App : PrismApplication
  {
      protected override Window CreateShell() => Container.Resolve<MainWindow>();

      protected override void RegisterTypes(IContainerRegistry containerRegistry)
      {
      }

      protected override IModuleCatalog CreateModuleCatalog()
      {
          return new DirectoryModuleCatalog()
          {
              ModulePath = "./Modules"
          };
      }
  }
  ```
