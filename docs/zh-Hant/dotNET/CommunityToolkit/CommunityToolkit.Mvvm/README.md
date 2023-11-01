# CommunityToolkit.Mvvm

## Code snippets

### BaseViewModel

```csharp
[ObservableObject]
public partial class BaseViewModel // : ObservableObject
{
    [ObservableProperty]
    [NotifyPropertyChangedFor(nameof(IsNotBusy))]
    bool isBusy;

    [ObservableProperty]
    string title = string.Empty;

    public bool IsNotBusy => !IsBusy;
}
```

## References

-   [GitHub](https://github.com/CommunityToolkit/dotnet)
-   [Docs](https://docs.microsoft.com/zh-cn/dotnet/communitytoolkit/)
