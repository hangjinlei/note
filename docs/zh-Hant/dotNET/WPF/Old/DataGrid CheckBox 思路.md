# 关于 DataGrid 自定义 `CheckBox 列` 选择项的问题

1. 自定义 `CheckBox 列` 的 `IsChecked` 绑定到 `DataGridRow` 的 `IsSelected`
2. `CheckBox` 的 `PreviewMouseDown` 事件中处理 `CheckBox` 的 `IsChecked` 属性
3. `DataGrid` 的 `SelectionChanged` 事件中将 `IsSelected` 绑定到 `Model`
4. 使用 `behaviors` 将 `SelectionChanged` 事件传递到 `ViewModel`, 更改行首的 `CheckBox` 选中状态

```xml
<DataGrid
    Grid.Row="1"
    CanUserAddRows="False"
    ItemsSource="{Binding Persons}"
    SelectionChanged="DataGrid_SelectionChanged">

    <i:Interaction.Triggers>
        <i:EventTrigger EventName="SelectionChanged">
            <i:InvokeCommandAction Command="{Binding SelectionChangedCommand}" CommandParameter="{Binding RelativeSource={RelativeSource AncestorType={x:Type DataGrid}}}" />
        </i:EventTrigger>
    </i:Interaction.Triggers>

    <DataGrid.Columns>
        <DataGridTemplateColumn>
            <DataGridTemplateColumn.HeaderTemplate>
                <DataTemplate>
                    <CheckBox IsChecked="{Binding DataContext.IsSelectedAll, RelativeSource={RelativeSource AncestorType={x:Type mah:MetroWindow}}}" IsThreeState="True" />
                </DataTemplate>
            </DataGridTemplateColumn.HeaderTemplate>
            <DataGridTemplateColumn.CellTemplate>
                <DataTemplate>
                    <CheckBox IsChecked="{Binding IsSelected, RelativeSource={RelativeSource Mode=FindAncestor, AncestorType={x:Type DataGridRow}}}" PreviewMouseDown="CheckBox_PreviewMouseDown" />
                </DataTemplate>
            </DataGridTemplateColumn.CellTemplate>
        </DataGridTemplateColumn>
    </DataGrid.Columns>
</DataGrid>
```

```csharp
private void DataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
{
    e.AddedItems.Cast<Person>().ToList().ForEach(p => p.IsSelected = true);
    e.RemovedItems.Cast<Person>().ToList().ForEach(p => p.IsSelected = false);
}

private void CheckBox_PreviewMouseDown(object sender, MouseButtonEventArgs e)
{
    CheckBox checkBox = sender as CheckBox;

    if (e.ChangedButton == MouseButton.Left)
    {
        checkBox.IsChecked = !checkBox.IsChecked;
        e.Handled = true;
    }
}
```

ViewModel

```csharp
[RelayCommand]
void SelectionChanged(DataGrid dg)
{
    IsSelectedAll = dg.SelectedItems.Count == 0 ? false
        : dg.SelectedItems.Count < dg.Items.Count ? null : true;
}
```
