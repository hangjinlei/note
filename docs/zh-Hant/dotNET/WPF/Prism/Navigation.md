# Navigation

- [Navigation](#navigation)
  - [要点](#要点)
  - [传递参数](#传递参数)
    - [导航时](#导航时)
    - [接收时](#接收时)
  - [拦截导航请求](#拦截导航请求)
  - [导航日志](#导航日志)

## 要点

- App
  - `IContainerRegistry` 用于注册导航
- ViewModel
  - `IRegionManager` 用于导航
  - `INavigationAware` 用于接收参数
  - `IConfirmNavigationRequest : INavigationAware` 用于拦截
  - `IRegionNavigationJournal` 用于记录导航历史

## 传递参数

### 导航时

- 实现

  1. 在 `RequestNavigate` 方法中传入 key/value pairs

- ViewModel 代码

  ```csharp
  void Navigate(string name)
  {
      regionManager.Regions["ContentRegion"].RequestNavigate(name, new NavigationParameters()
      {
          { "Content", "Hello" }
      });
  }
  ```

### 接收时

- 实现

  1. 实现 `INavigationAware` 接口
  2. 在 `OnNavigatedTo` 方法中获取参数

- ViewModel 代码

  ```csharp
  [ObservableObject]
  public partial class ViewAViewModel : INavigationAware
  {
      // 每次重新导航时, 是否重用原来的实例
      // => true, 则重用原来的实例, 否则创建新的实例
      public bool IsNavigationTarget(NavigationContext navigationContext) => true;

      // 拦截请求
      public void OnNavigatedFrom(NavigationContext navigationContext)
      {
      }

      // 接收参数
      public void OnNavigatedTo(NavigationContext navigationContext)
      {
          Content = navigationContext.Parameters.GetValue<string>("Content");
      }
  }
  ```

## 拦截导航请求

- 目的

  1. 从当前页导航到其他页面时, 对导航进行拦截

- 实现

  1. 实现 `INavigationAware` 换为实现 `IConfirmNavigationRequest` 接口, 该接口继承了 `INavigationAware`
  2. 在 `ConfirmNavigationRequest` 方法中执行 `continuationCallback` 委托

- ViewModel 代码

  ```csharp
  [ObservableObject]
  public partial class ViewAViewModel : IConfirmNavigationRequest
  {
      public void ConfirmNavigationRequest(NavigationContext navigationContext, Action<bool> continuationCallback)
      {
         var result = false;
         if (System.Windows.MessageBox.Show($"Navigate to {navigationContext.Uri}", "Confirm", System.Windows.MessageBoxButton.YesNo) is System.Windows.MessageBoxResult.Yes)
             result = true;
         continuationCallback(result);
      }
      ...
  }
  ```

## 导航日志

- 提示

  1. 导航时, 前述接收参数, 拦截的方法同样适用

- 实现

  1. 使用 `IRegionNavigationJournal`, 从 `navigationResult` 中获取导航日志
  2. 当导航成功时, 为导航日志重新赋值, 以使用最新的日志
  3. 导航前应判断是否能够导航

- ViewModel 代码

  ```csharp
  public partial class MainWindowViewModel : BindableBase
  {
      private readonly IRegionManager regionManager;
      private IRegionNavigationJournal journal;

      public MainWindowViewModel(IRegionManager regionManager)
      {
          this.regionManager = regionManager;
      }

      void Navigate(string name)
      {
          regionManager.Regions["ContentRegion"].RequestNavigate(name, navigationResult =>
          {
              if (navigationResult.Result is true)
                  journal = navigationResult.Context.NavigationService.Journal;
          }, new NavigationParameters() { { "Content", "Hello" } });
      }

      [ICommand]
      void Back()
      {
          if (journal?.CanGoBack is true)
              journal?.GoBack();
      }
  }
  ```
