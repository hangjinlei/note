# Design

## 使用紧凑视图 (Compact view)

通过在 `App.xaml` 中引入 `<ResourceDictionary Source="ms-appx:///Microsoft.UI.Xaml/DensityStyles/Compact.xaml" />` 资源, 或将资源单独应用到控件资源中使用紧凑视图.

```diff
 <ResourceDictionary.MergedDictionaries>
     <XamlControlsResources xmlns="using:Microsoft.UI.Xaml.Controls" />
     <!-- Other merged dictionaries here -->
+    <ResourceDictionary Source="ms-appx:///Microsoft.UI.Xaml/DensityStyles/Compact.xaml" />
 </ResourceDictionary.MergedDictionaries>
```
