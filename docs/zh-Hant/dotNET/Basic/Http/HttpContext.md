# [HttpClient](https://docs.microsoft.com/zh-cn/dotnet/api/microsoft.aspnetcore.http.httpcontext)

| 属性            | 描述                                                         |
| :-------------- | :----------------------------------------------------------- |
| Connection      | 获取有关此请求的基础连接的信息。                             |
| Features        | 获取服务器提供的 HTTP 功能的集合，以及此请求上可用的中间件。 |
| Items           | 获取或设置可用于在此请求的范围内共享数据的键/值集合。        |
| Request         | 获取 HttpRequest 此请求的对象。                              |
| RequestAborted  | 当此请求的基础的连接被中止，因此应取消请求操作时发出通知。   |
| RequestServices | 获取或设置 IServiceProvider 提供对请求的服务容器的访问的。   |
| Response        | 获取 HttpResponse 此请求的对象。                             |
| Session         | 获取或设置对象，该对象用于管理此请求的用户会话数据。         |
| TraceIdentifier | 获取或设置在跟踪日志中表示此请求的唯一标识符。               |
| User            | 获取或设置此请求的用户。                                     |
| WebSockets      | 获取一个对象，该对象管理为此请求建立 WebSocket 连接。        |
