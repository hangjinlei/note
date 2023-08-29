# Getting Started

## 安装

- NuGet

  - [MaterialDesignThemes](https://www.nuget.org/packages/MaterialDesignThemes)

## 项目中引入

- App.xaml

  ```xml
  <!--  Material Design  -->
  <ResourceDictionary Source="pack://application:,,,/MaterialDesignThemes.Wpf;component/Themes/MaterialDesignTheme.Light.xaml" />
  <ResourceDictionary Source="pack://application:,,,/MaterialDesignThemes.Wpf;component/Themes/MaterialDesignTheme.Defaults.xaml" />
  <ResourceDictionary Source="pack://application:,,,/MaterialDesignColors;component/Themes/Recommended/Primary/MaterialDesignColor.DeepPurple.xaml" />
  <ResourceDictionary Source="pack://application:,,,/MaterialDesignColors;component/Themes/Recommended/Accent/MaterialDesignColor.Lime.xaml" />

  <materialDesign:CustomColorTheme
      BaseTheme="Light"
      PrimaryColor="Aqua"
      SecondaryColor="DarkGreen" />
  ```

- View

  ```xml
  <Window [...]
          xmlns:materialDesign="http://materialdesigninxaml.net/winfx/xaml/themes"
          TextElement.Foreground="{DynamicResource MaterialDesignBody}"
          Background="{DynamicResource MaterialDesignPaper}"
          TextElement.FontWeight="Medium"
          TextElement.FontSize="14"
          FontFamily="{materialDesign:MaterialDesignFont}"
          [...] >
  ```

  OR

  ```xml
  <Window . . .
          xmlns:materialDesign="http://materialdesigninxaml.net/winfx/xaml/themes"
          TextElement.Foreground="{DynamicResource MaterialDesignBody}"
          TextElement.FontWeight="Regular"
          TextElement.FontSize="13"
          TextOptions.TextFormattingMode="Ideal"
          TextOptions.TextRenderingMode="Auto"
          Background="{DynamicResource MaterialDesignPaper}"
          FontFamily="{DynamicResource MaterialDesignFont}">
      <Grid>
          <StackPanel>
              <materialDesign:Card Padding="32" Margin="16">
                  <TextBlock Style="{DynamicResource MaterialDesignHeadline6TextBlock}">My First Material Design App</TextBlock>
              </materialDesign:Card>
          </StackPanel>
      </Grid>
  </Window>
  ```
