# 自定 Command

```csharp
public class ButtonCommand : ICommand
{
    public event EventHandler? CanExecuteChanged;

    private readonly Func<object, bool> canExecute;
    private readonly Action<object> execute;

    public ButtonCommand(Func<object, bool> canExecute, Action<object> execute)
    {
        this.canExecute = canExecute;
        this.execute = execute;
    }

    public bool CanExecute(object? parameter) => canExecute.Invoke(parameter);

    public void Execute(object? parameter) => execute?.Invoke(parameter);
}
```
