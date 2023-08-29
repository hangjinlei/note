# 容器间通信

How to connect from one docker container to another

## Sample .NET "ping" and "pong" services

- "ping" service

**pay attention to the port number**

```csharp
builder.Services.AddSingleton(sp => new HttpClient() { BaseAddress = new Uri("http://pong-service-container:80") });
```

```csharp
app.MapGet("/", async (CancellationToken cancellationToken) =>
{
    return await Task.Run(() => "Hello, I am ping service!", cancellationToken);
})
.WithName("PingService")
.WithOpenApi();

app.MapGet("/ping", async (CancellationToken cancellationToken, HttpClient client) =>
{
    try
    {
        var response = await client.GetAsync("/pong", cancellationToken);
        return $"Ping ... {await response.Content.ReadAsStringAsync(cancellationToken)}";
    }
    catch
    {
        return await Task.Run(() => "Cannot reach the pong service.", cancellationToken);
    }
})
.WithName("GetPing")
.WithOpenApi();
```

- "pong" service

```csharp
app.MapGet("/", async (CancellationToken cancellationToken) =>
{
    return await Task.Run(() => "Hello, I am pong service!", cancellationToken);
})
.WithName("PongService")
.WithOpenApi();

app.MapGet("/pong", async (CancellationToken cancellationToken) =>
{
    return await Task.Run(() => "Pong", cancellationToken);
})
.WithName("GetPong")
.WithOpenApi();
```

## Build docker image for "ping" service

Using .NET 7 features, we can build a docker image for the "ping" service using the following command:

- Install the following NuGet packages:

```shell
Microsoft.NET.Build.Containers
```

- Run the following command:

```shell
dotnet publish -c Release -r linux-x64 -p PublishProfile=DefaultContainer --self-contained
```

## Build docker image for "pong" service

Same as above.

## Run the "ping" service in a dedicated Docker container

Run the following command:

```shell
docker run --name ping-service-container -p 5001:80 ping
```

## Run the "pong" service in a dedicated Docker container

Run the following command:

```shell
docker run --name pong-service-container -p 5003:80 pong
```

## Verfiy that the "ping" and "pong" services are reachable from host

- "ping" service

```shell
curl http://localhost:5001
```

- "pong" service

```shell
curl http://localhost:5003
```

## Verfiy that "ping" service cannot reach "pong" service

```shell
curl http://localhost:5001/ping
```

## Create docker network

```shell
docker network create ping-pong-network
```

## Add the "ping" and "Pong" serivces containers to the network

1. insepct the network, you should see that the containers are not in the network

```shell
docker network inspect ping-pong-network
```

```json
[
  {
    "Name": "ping-pong-network",
    "Id": "0bf6b76e2967e65f7d6c8afa7f8d89b84ad0359fcccbecc4f6c604930672c80a",
    "Created": "2022-11-27T06:22:58.551920341Z",
    "Scope": "local",
    "Driver": "bridge",
    "EnableIPv6": false,
    "IPAM": {
      "Driver": "default",
      "Options": {},
      "Config": [
        {
          "Subnet": "172.18.0.0/16",
          "Gateway": "172.18.0.1"
        }
      ]
    },
    "Internal": false,
    "Attachable": false,
    "Ingress": false,
    "ConfigFrom": {
      "Network": ""
    },
    "ConfigOnly": false,
    "Containers": {},
    "Options": {},
    "Labels": {}
  }
]
```

2. add "ping" service container to the network

```shell
docker network connect ping-pong-network ping-service-container
```

3. add "pong" service container to the network

```shell
docker network connect ping-pong-network pong-service-container
```

## Verfiy that containers are in the network

inspect the network, you should see that the containers are now in the network

```shell
docker network inspect ping-pong-network
```

```json
[
  {
    "Name": "ping-pong-network",
    "Id": "0bf6b76e2967e65f7d6c8afa7f8d89b84ad0359fcccbecc4f6c604930672c80a",
    "Created": "2022-11-27T06:22:58.551920341Z",
    "Scope": "local",
    "Driver": "bridge",
    "EnableIPv6": false,
    "IPAM": {
      "Driver": "default",
      "Options": {},
      "Config": [
        {
          "Subnet": "172.18.0.0/16",
          "Gateway": "172.18.0.1"
        }
      ]
    },
    "Internal": false,
    "Attachable": false,
    "Ingress": false,
    "ConfigFrom": {
      "Network": ""
    },
    "ConfigOnly": false,
    "Containers": {
      "404574bacd8e6d5ede7fbf0a915891887162c7edf11c6183cb06b022702d1762": {
        "Name": "pong-service-container",
        "EndpointID": "a370b251c63085a526fc48c91bb1a086cdc461d1fcbbe9b7dc42a8fbed054c08",
        "MacAddress": "02:42:ac:12:00:03",
        "IPv4Address": "172.18.0.3/16",
        "IPv6Address": ""
      },
      "5eb66fa30564b6b140ef23b240cd366c50484a502322e40828cf1078c494093c": {
        "Name": "ping-service-container",
        "EndpointID": "0a690df93f6b70f44796d839667ee26b6f22db9116a992b1f6d2b51339dde4a0",
        "MacAddress": "02:42:ac:12:00:02",
        "IPv4Address": "172.18.0.2/16",
        "IPv6Address": ""
      }
    },
    "Options": {},
    "Labels": {}
  }
]
```

## Verify that "ping" service can now query "pong" service

## Stop the "pong" service and verify that it's removed from Docker network

## Run the "pong" service again and add it back to the network

Done! We have enabled communication between two docker containers using the Docker Network.
