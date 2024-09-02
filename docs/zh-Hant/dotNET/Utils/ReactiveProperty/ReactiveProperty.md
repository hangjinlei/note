# ReactiveProperty

- [ReactiveProperty](#reactiveproperty)
  - [创建实例](#创建实例)
    - [从 `IObservable<T>` 创建](#从-iobservablet-创建)
    - [从 `ReactiveProperty` 创建](#从-reactiveproperty-创建)
  - [校验](#校验)
    - [自定义校验](#自定义校验)
    - [使用 DataAnnotations](#使用-dataannotations)
  - [处理校验错误信息](#处理校验错误信息)
    - [使用 ObserveValidationErrorMessage (ReactiveProperty v7.0.0 or later)](#使用-observevalidationerrormessage-reactiveproperty-v700-or-later)
    - [使用 ObserveHasErrors](#使用-observehaserrors)
    - [使用 ObserveHasErrors 绑定到 Command CanExecuted](#使用-observehaserrors-绑定到-command-canexecuted)
    - [忽略初始化时的第一次错误](#忽略初始化时的第一次错误)
  - [ReactivePropertyMode](#reactivepropertymode)
  - [ForceNotify](#forcenotify)
  - [Change comparer logic](#change-comparer-logic)
  - [`ReadOnlyReactiveProperty` class](#readonlyreactiveproperty-class)
  - [Unsubscribe](#unsubscribe)
  - [订阅更改](#订阅更改)

```csharp
class MainWindowViewModel : INotifyPropertyChanged
{
    public event PropertyChangedEventHandler PropertyChanged;

    public ReactiveProperty<string> Input { get; }
    public ReadOnlyReactiveProperty<string> Output { get; }

    public MainWindowViewModel()
    {
        Input = new ReactiveProperty<string>("");
        Output = Input
            .Delay(TimeSpan.FromSeconds(1))
            .Select(x => x.ToUpper())
            .ToReadOnlyReactiveProperty();
    }
}
```

```xml
<StackPanel>
    <Label Content="Input" />
    <TextBox Text="{Binding Input.Value, UpdateSourceTrigger=PropertyChanged}" Margin="5" />
    <Label Content="Output" />
    <TextBlock Text="{Binding Output.Value}" Margin="5" />
</StackPanel>
```

## [创建实例](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#how-to-create-a-reactiveproperty-instance)

### [从 `IObservable<T>` 创建](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#create-from-iobservable-t)

```csharp
IObservable<long> observableInstance = Observable.Interval(TimeSpan.FromSeconds(1));

// Convert to ReactiveProperty from IObservable.
ReactiveProperty<long> counter = observableInstance.ToReactiveProperty();
```

### [从 `ReactiveProperty` 创建](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#create-from-reactiveproperty)

```csharp
var name = new ReactiveProperty<string>("");

var formalName = name.Select(x => $"Dear {x}")
    .ToReactiveProperty();`
```

## [校验](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#validation)

### [自定义校验](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#set-custom-validation-logic)

```csharp
var name = new ReactiveProperty<string>()
    .SetValidateNotifyError(x => string.IsNullOrWhiteSpace(x) ? "Error message" : null);
```

### [使用 DataAnnotations](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#work-with-dataannotations)

```csharp
class ViewModel
{
    // Set validation attributes
    [Required(ErrorMessage = "The name is required.")]
    [StringLength(100, ErrorMessage = "The name length should be lower than 30.")]
    public ReactiveProperty<string> Name { get; }

    public ViewModel()
    {
        Name = new ReactiveProperty<string>()
            // Set validation attributes into the ReactiveProperty.
            .SetValidateAttribute(() => Name);
    }
}
```

## [处理校验错误信息](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#handling-validation-errors)

### 使用 ObserveValidationErrorMessage (ReactiveProperty v7.0.0 or later)

```csharp
class ViewModel
{
    // Set validation attributes
    [Required(ErrorMessage = "The name is required.")]
    [StringLength(100, ErrorMessage = "The name length should be lower than 30.")]
    public ReactiveProperty<string> Name { get; }

    public ReadOnlyReactiveProperty<string> NameErrorMessage { get; }

    public ViewModel()
    {
        Name = new ReactiveProperty<string>()
            // Set validation attributes into the ReactiveProperty.
            .SetValidateAttribute(() => Name);

        // Handling an error message
        NameErrorMessage = Name.ObserveValidationErrorMessage()
            .ToReadOnlyReactiveProperty();
    }
}
```

### 使用 ObserveHasErrors

```csharp
var HasErrors = new[]
    {
        Name.ObserveHasErrors,
        Memo.ObserveHasErrors,
    }.CombineLatest(x => x.Any(y => y))
    .ToReadOnlyReactiveProperty();
```

### 使用 ObserveHasErrors 绑定到 Command CanExecuted

```csharp
var HasErrors = new[]
    {
        Name.ObserveHasErrors,
        Memo.ObserveHasErrors,
    };

ReactiveCommand command = HasErrors.CombineLatestValuesAreAllFalse().ToReactiveCommand().WithSubscribe(() => { });
```

### [忽略初始化时的第一次错误](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#don-t-need-an-initial-validation-error)

构造函数中设置`IgnoreInitialValidationError` flag

```csharp
public ReactiveProperty<string> FirstName { get; set; } = new ReactiveProperty<string>(mode: ReactivePropertyMode.IgnoreInitialValidationError);
```

或使用 Skip 方法忽略第一个错误事件

```csharp
class ViewModel
{
    // Set validation attributes
    [Required(ErrorMessage = "The name is required.")]
    [StringLength(100, ErrorMessage = "The name length should be lower than 30.")]
    public ReactiveProperty<string> Name { get; }

    public ReadOnlyReactiveProperty<string> NameErrorMessage { get; }

    public ViewModel()
    {
        Name = new ReactiveProperty<string>()
            .SetValidateAttribute(() => Name);

        // Handling an error message
        NameErrorMessage = Name.ObserveErrorChanged
            .Skip(1) // Skip the first error.
            .Select(x => x?.OfType<string>()?.FirstOrDefault())
            .ToReadOnlyReactiveProperty();
    }
}
```

## [ReactivePropertyMode](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#the-mode-of-reactiveproperty)

- ReactivePropertyMode.None

  > ReactiveProperty doesn't call the OnNext callback when Subscribe method is call. And calls the OnNext callback if the same value is set.

- ReactivePropertyMode.DistinctUntilChanged

  > This doesn't call OnNext callback if same value set.

- ReactivePropertyMode.RaiseLatestValueOnSubscribe

  > This calls OnNext callback when Subscribe method call.

- ReactivePropertyMode.Default

  > It is default value. It is same as ReactivePropertyMode.DistinctUntilChanged | ReactivePropertyMode.RaiseLatestValueOnSubscribe.

- ReactivePropertyMode.IgnoreInitialValidationError

  > Ignore initial validation error.

## [ForceNotify](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#forcenotify)

## [Change comparer logic](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#change-comparer-logic)

## [`ReadOnlyReactiveProperty` class](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#readonlyreactiveproperty-class)

## [Unsubscribe](https://okazuki.jp/ReactiveProperty/features/ReactiveProperty.html#unsubscribe)

## 订阅更改

```csharp
public ReactiveProperty<string> Text { get; set; }

public MainWindowViewModel()
{
    Text = new ReactiveProperty<string>(string.Empty);
    Text.Subscribe(x => Console.WriteLine(x));
}
```
