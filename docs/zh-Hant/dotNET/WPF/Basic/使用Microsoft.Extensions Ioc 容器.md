# 使用 Microsoft.Extensions 进行依赖注入

NuGet

- Microsoft.Extensions.Configuration.Json
- Microsoft.Extensions.DependencyInjection
- Microsoft.Extensions.Options.ConfigurationExtensions

App.xaml

- Remove StartupUri

```diff
<Application ......
-			StartupUri="MainWindow.xaml">
+			>
			......
</Application>
```

App.xaml.cs

```csharp
protected override void OnStartup(StartupEventArgs e)
{
	base.OnStartup(e);

	var builder = new ConfigurationBuilder();
	builder.SetBasePath(Environment.CurrentDirectory).AddJsonFile(path: "appsettings.json", optional: false, reloadOnChange: true);

	Configuration = builder.Build();

	var services = new ServiceCollection();
	services.Configure<AppSettings>(Configuration.GetSection(nameof(AppSettings)));
	services.AddTransient<MainWindow>();

	ServiceProvider = services.BuildServiceProvider();

	var mainWindow = ServiceProvider.GetRequiredService<MainWindow>();
	mainWindow.Show();
}
```
