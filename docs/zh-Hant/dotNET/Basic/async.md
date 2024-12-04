# 异步编程

```csharp
await File.WriteAllTextAsync("test.txt", "Hello World!");
```

## Windows Forms 支持异步

事件处理方法可以使用 `async` 关键字，但是事件处理方法必须是 `void` 类型。

```csharp
private async void button1_Click(object sender, EventArgs e)
{
    await Task.Run(() => Thread.Sleep(1000));
    MessageBox.Show("Hello World!");
}
```

## WPF 支持异步

```csharp
private async void button1_Click(object sender, RoutedEventArgs e)
{
    await Task.Run(() => Thread.Sleep(1000));
    MessageBox.Show("Hello World!");
}
```

## 同步方法中调用异步方法

存在死锁的风险，因为同步方法中调用异步方法，会阻塞线程，导致 UI 线程被阻塞。

### 有返回值

```csharp
private void button1_Click(object sender, EventArgs e)
{
    var result = File.ReadAllTextAsync("test.txt", "Hello World!").Result;
    MessageBox.Show("Hello World!");
}
```

### 无返回值

```csharp
private async void button1_Click(object sender, RoutedEventArgs e)
{
    Task.Run(() => Thread.Sleep(1000)).Wait();
    MessageBox.Show("Hello World!");
}
```

## 异步 Lambda 表达式

```csharp
ThreadPool.QueueUserWorkItem(async state =>
{
    await Task.Run(() => Thread.Sleep(1000));
    MessageBox.Show("Hello World!");
});
```
