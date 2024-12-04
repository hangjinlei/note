# CollectionView

## 示例

```xaml
<CollectionView
    Grid.Row="2"
    Grid.ColumnSpan="2"
    ItemsSource="{Binding Items}">
    <CollectionView.ItemsSource>
        <x:Array Type="{x:Type x:String}">
            <x:String>Apples</x:String>
            <x:String>Bananas</x:String>
            <x:String>Orangess</x:String>
        </x:Array>
    </CollectionView.ItemsSource>
    <CollectionView.ItemTemplate>
        <DataTemplate x:DataType="{x:Type x:String}">
            <Grid Padding="0,5">
                <Frame>
                    <Label Text="{Binding .}" />
                </Frame>
            </Grid>
            </SwipeView>
        </DataTemplate>
    </CollectionView.ItemTemplate>
</CollectionView>
```
