# RabbitMQ 在 .NET App 中的使用

## 前提条件

[RabbitMQ 的基本概念](../../rabbitmq)

## NuGet

[RabbitMQ.Client](https://www.nuget.org/packages/RabbitMQ.Client)

## Sender

```csharp
var connectionFactory = new ConnectionFactory
{
    HostName = "localhost", // RabbitMQ server address
    UserName = "user", // user name
    Password = "password",
    DispatchConsumersAsync = true // 异步消费
};
var exchangeName = "exchange1";
var eventName = "routingKey1";

using var connection = connectionFactory.CreateConnection();

while (true)
{
    using var channel = connection.CreateModel(); // 创建信道
    var properties = channel.CreateBasicProperties(); // 创建消息属性
    properties.DeliveryMode = 2; // 持久化消息
    channel.ExchangeDeclare(exchange: exchangeName, type: "direct"); // 声明交换机, Type 有 direct, fanout, topic, headers 四种

    var msg = DateTime.UtcNow.ToString();
    var body = Encoding.UTF8.GetBytes(msg);

    channel.BasicPublish(exchange: exchangeName, routingKey: eventName, mandatory: true, basicProperties: properties, body: body);

    Console.WriteLine("发送消息：" + msg);

    Thread.Sleep(1000);
}
```

## Consumer

```csharp
var connectionFactory = new ConnectionFactory
{
    HostName = "localhost", // RabbitMQ server address
    UserName = "user", // user name
    Password = "password",
    DispatchConsumersAsync = true // 异步消费
};
var exchangeName = "exchange1"; // 交换机名称
var eventName = "routingKey1"; // 路由键名称
var queueName = "queue1"; // 队列名称

using var connection = connectionFactory.CreateConnection(); // 创建连接
using var channel = connection.CreateModel(); // 创建信道

channel.ExchangeDeclare(exchange: exchangeName, type: "direct"); // 声明交换机, Type 有 direct, fanout, topic, headers 四种
channel.QueueDeclare(queue: queueName, durable: true, exclusive: false, autoDelete: false, arguments: null); // 声明队列, durable: true 表示持久化, exclusive: false 表示不是独占队列, autoDelete: false 表示不是自动删除队列
channel.QueueBind(queue: queueName, exchange: exchangeName, routingKey: eventName); // 将队列绑定到交换机上


var consumer = new AsyncEventingBasicConsumer(channel);
consumer.Received += Consumer_Received;
channel.BasicConsume(queue: queueName, autoAck: false, consumer: consumer);
Console.ReadLine();

async Task Consumer_Received(object sender, BasicDeliverEventArgs @event)
{
    try
    {
        var body = @event.Body.ToArray();
        var message = Encoding.UTF8.GetString(body);
        Console.WriteLine($"[{DateTime.UtcNow}] - Received message: {message}");
        channel.BasicAck(deliveryTag: @event.DeliveryTag, multiple: false); // 手动确认, deliveryTag: 该消息的index
        await Task.Delay(800);
    }
    catch (Exception ex)
    {
        channel.BasicReject(deliveryTag: @event.DeliveryTag, requeue: true); // 拒绝消息, requeue: 是否重新入队
        throw;
    }
}
```
