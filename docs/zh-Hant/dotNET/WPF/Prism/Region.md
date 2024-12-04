# Region

- [Region](#region)
  - [要点](#要点)
  - [使用概要](#使用概要)
  - [使用详情](#使用详情)
    - [使用 Region 前](#使用-region-前)
    - [使用 Region 后](#使用-region-后)

---

## 要点

1. App 中 `IContainerRegistry` 用于注册
2. ViewModel 中 `IRegionManager` 用于导航

## 使用概要

- App.xaml

  ```XML
  xmlns:prism="http://prismlibrary.com/"

  <ContentControl Grid.Row="1" prism:RegionManager.RegionName="ContentRegion" />
  ```

- ViewModel

  ```csharp
  private readonly IRegionManager regionManager;

  public MainWindowViewModel(IRegionManager regionManager)
  {
       this.regionManager = regionManager;
  }

  [RelayCommand]
  void Navigate(string name)
  {
       regionManager.Regions["ContentRegion"].RequestNavigate(name);
  }
  ```

## 使用详情

### 使用 Region 前

1. 需要根据传入名称实例化控件

- View 代码

  ```xml
  <Window
    ...>
      <Grid>
          <Grid.RowDefinitions>
              <RowDefinition Height="Auto" />
              <RowDefinition Height="1*" />
          </Grid.RowDefinitions>

          <StackPanel Orientation="Horizontal">
              <Button
                  Command="{Binding NavigateCommand}"
                  CommandParameter="ViewA"
                  Content="ViewA" />
              <Button
                  Command="{Binding NavigateCommand}"
                  CommandParameter="ViewB"
                  Content="ViewB" />
              <Button
                  Command="{Binding NavigateCommand}"
                  CommandParameter="ViewC"
                  Content="ViewC" />
          </StackPanel>

          <ContentControl Grid.Row="1" Content="{Binding Body}" />
      </Grid>
  </Window>
  ```

- ViewModel 代码

  ```csharp
  public partial class MainWindowViewModel : BindableBase
  {
      [ObservableProperty]
      object body;

      [RelayCommand]
      void Navigate(string name)
      {
          switch (name)
          {
              case "ViewA": Body = new ViewA(); break;
              case "ViewB": Body = new ViewB(); break;
              case "ViewC": Body = new ViewC(); break;
              default:
                  break;
          }
      }
  }
  ```

### 使用 Region 后

- 实现

  1. App 中注册导航页面
  2. 根据传入的名称交由 IRegionManager 进行导航

- App.xaml.cs 代码

  ```csharp
  protected override void RegisterTypes(IContainerRegistry containerRegistry)
  {
      containerRegistry.RegisterForNavigation<ViewA>();
      containerRegistry.RegisterForNavigation<ViewB>();
      containerRegistry.RegisterForNavigation<ViewC>();
  }
  ```

- MainWindow 代码

  ```xml
    <Window
        ...
        xmlns:prism="http://prismlibrary.com/"
        prism:ViewModelLocator.AutoWireViewModel="True">
        <Grid>
             ...

             <ContentControl Grid.Row="1" prism:RegionManager.RegionName="ContentRegion" />
         </Grid>
    </Window>
  ```

- MainWindowViewModel 代码

  ```csharp
  public partial class MainWindowViewModel : BindableBase
  {
    private readonly IRegionManager regionManager;

    public MainWindowViewModel(IRegionManager regionManager)
    {
        this.regionManager = regionManager;
    }

    [RelayCommand]
    void Navigate(string name)
    {
        regionManager.Regions["ContentRegion"].RequestNavigate(name);
    }
  }
  ```
