# SwipeView

## 示例

```xaml
<SwipeView>
    <SwipeView.RightItems>
        <SwipeItems>
            <SwipeItem
                BackgroundColor="Red"
                Command="{Binding Source={RelativeSource AncestorType={x:Type viewmodel:MainViewModel}}, Path=DeleteCommand}"
                CommandParameter="{Binding .}"
                Text="Delete" />
        </SwipeItems>
    </SwipeView.RightItems>
    <Grid Padding="0,5">
        <Frame>
            <Label Text="{Binding .}" />
        </Frame>
    </Grid>
</SwipeView>
```
