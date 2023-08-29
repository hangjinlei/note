# 在 .NET App 中使用 GB2312

NuGet

[System.Text.Encoding.CodePages](https://www.nuget.org/packages/System.Text.Encoding.CodePages)

```shell
Install-Package System.Text.Encoding.CodePages
```

```csharp
Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
```
