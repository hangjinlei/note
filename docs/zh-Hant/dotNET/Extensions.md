# Extensions

## 在 .NET App 中使用 GB2312

[System.Text.Encoding.CodePages](https://www.nuget.org/packages/System.Text.Encoding.CodePages)

```csharp
Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
```
