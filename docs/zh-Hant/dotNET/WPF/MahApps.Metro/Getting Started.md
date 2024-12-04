# Getting Started

## 安装

- NuGet

  - [MahApps.Metro](https://www.nuget.org/packages/MahApps.Metro)
  - [MahApps.Metro.IconPacks](https://www.nuget.org/packages/MahApps.Metro.IconPacks)

## [README](https://github.com/MahApps/MahApps.Metro)

## [Quick Start](https://mahapps.com/docs/guides/quick-start)

### MahApps build-in styles and themes

App.xaml

```xml
<ResourceDictionary.MergedDictionaries>
    <!-- MahApps.Metro resource dictionaries. Make sure that all file names are Case Sensitive! -->
    <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Controls.xaml" />
    <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Fonts.xaml" />
    <!-- Theme setting -->
    <ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Themes/Light.Blue.xaml" />
</ResourceDictionary.MergedDictionaries>
```

### Using the MetroWindow

`xmlns:mah="clr-namespace:MahApps.Metro.Controls;assembly=MahApps.Metro"`

OR

`xmlns:mah="http://metro.mahapps.com/winfx/xaml/controls"`
