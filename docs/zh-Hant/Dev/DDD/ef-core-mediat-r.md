# 在 EF Core 中触发 MediatR

## 前提条件

[MediatR 处理领域事件](../mediat-r)

## 概述

1. 声明 `IDomainEvents` 接口
2. 使抽象类 `BaseEntity` 实现该接口, 其中存储事件的集合
3. 重写 `DbContext` 的 `SaveChanges` 或 `SaveChangesAsync` 方法, 在保存数据之前获取实现 `IDomainEvents` 接口的实体, 发布存储的事件

## 示例代码

### IDomainEvents.cs

```csharp
public interface IDomainEvents
{
    IEnumerable<INotification> GetDomainEvents();
    void AddDomainEvent(INotification notification);
    void ClearDomainEvents();
}
```

### BaseEntity.cs

```csharp
public abstract class BaseEntity : IDomainEvents
{
    private ICollection<INotification> notifications = new List<INotification>();

    public void AddDomainEvent(INotification notification)
    {
        notifications.Add(notification);
    }

    public void ClearDomainEvents()
    {
        notifications.Clear();
    }

    public IEnumerable<INotification> GetDomainEvents()
    {
        return notifications;
    }
}
```

### DbContext.cs

```csharp
public override async Task<int> SaveChangesAsync(bool acceptAllChangesOnSuccess, CancellationToken cancellationToken = default)
{
    var domainEntities = this.ChangeTracker.Entries<IDomainEvents>().Where(x => x.Entity.GetDomainEvents().Any());
    var domainEvents = domainEntities.SelectMany(x => x.Entity.GetDomainEvents()).ToList();
    domainEntities.ToList().ForEach(x => x.Entity.ClearDomainEvents());

    foreach (var domainEvent in domainEvents)
    {
        await mediator.Publish(domainEvent, cancellationToken);
    }

    return await base.SaveChangesAsync(acceptAllChangesOnSuccess, cancellationToken);
}
```
