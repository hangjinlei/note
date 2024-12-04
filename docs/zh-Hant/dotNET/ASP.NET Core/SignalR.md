# SignalR

## Program.cs

### 添加相应压缩中间件服务

```csharp
builder.Services.AddResponseCompression(options =>
	{
		options.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(
			new[] { "application/octet-stream" });
	});
```

### 添加响应压缩中间件

```csharp
app.UseResponseCompression();
```

### 添加终结点

```csharp
app.MapHub<ChatHub>("/chathub");
```

## Index.razor

### 创建连接对象

```csharp
protected override async Task OnInitializedAsync()
{
	hubConnection = new HubConnectionBuilder()
		.WithUrl(NavigationManager.ToAbsoluteUri("/chathub"))
		.Build();

	hubConnection.On<string, string>("ReceiveMessage", (user, message) =>
	{
		var encodedMsg = $"{user}: {message}";
		messages.Add(encodedMsg);
		StateHasChanged();
	});

	await hubConnection.StartAsync();
}
```

### 发送

```csharp
private async Task Send()
{
	if (hubConnection is not null)
	{
		await hubConnection.SendAsync("SendMessage", userInput, messageInput);
	}
}
```
