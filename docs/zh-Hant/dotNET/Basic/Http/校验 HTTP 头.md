# 校验 HTTP 头

## 步骤

1. 继承 `DelegatingHandler`
2. 重写方法

## 示例

```csharp
public class ValidateHeaderHandler : DelegatingHandler
{
	protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
	{
		if (!request.Headers.Contains("Authorization"))
		{
			return new HttpResponseMessage(System.Net.HttpStatusCode.BadRequest);
		}

		return await base.SendAsync(request, cancellationToken);
	}
}
```
