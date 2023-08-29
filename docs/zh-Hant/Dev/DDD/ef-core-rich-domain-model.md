# 充血模型在 EF Core 中的实现

## 充血模型实现的要求

### 1. 属性是只读的或者是只能被类内部的代码修改

把属性的 set 定义为 private 或者 init, 然后通过构造方法为这些属性赋予初始值

User.cs

```csharp
public record User
{
    public int Id { get; init; } // 需求1
    public DateTime CreateAt { get; init; } // 需求1
    public string UserName { get; private set; } // 需求1

    public User(string yhm)
    {
        UserName = yhm;
        CreateAt = DateTime.UtcNow;
    }
}
```

### 2. 定义有参数的构造方法

EF Core 中的实体类如果没有无参的构造方法, 则有参的构造方法中的参数的名字必须和属性的名字一致 (供 EF Core 使用)

实现方式 1: 无参构造方法定义为 private (仅供 EF Core 使用)

实现方式 2: 实体类中不定义无参构造方法, 只定义有意义的有参构造方法, 但是要求构造方法中的参数的名字和属性的名字一致

User.cs

```csharp
public record User
{
    public string UserName { get; private set; } // 需求1

    private User() // 需求2
    {
    }

    public User(string yhm) // 需求2
    {
        UserName = yhm;
    }
}
```

### 3. 有的成员变量没有对应属性, 但是这些成员变量需要映射为数据表中的列, 也就是我们需要把私有成员变量映射到数据表中的列

builder.Property("成员变量名")

User.cs

```csharp
public record User
{
    private string? passwordHash; // 需求3
    private string? remark; // 需求3
}
```

UserConfig.cs

```csharp
public class UserConfig : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.Property("passwordHash"); // 需求3
    }
}
```

### 4. 有的属性是只读的, 也就是它的值是从数据库中读取出来的, 但是我们不能修改属性值

EF Core 中提供了 "支持字段" (backing field) 来支持这种写法: 在配置实体类的代码中，使用 HasField ("成员变量名") 来配置属性

User.cs

```csharp
public record User
{
    public string? Remark { get => remark; } // 需求4
}
```

UserConfig.cs

```csharp
public class UserConfig : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.Property(u => u.Remark).HasField("remark"); // 需求4
    }
}
```

### 5. 有的属性不需要映射到数据列, 仅在运行时被使用

使用 Ignore() 来配置忽略这个属性

User.cs

```csharp
public record User
{
    public string? Tag { get; set; } // 需求5
}
```

UserConfig.cs

```csharp
public class UserConfig : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.Ignore(u => u.Tag); // 需求5
    }
}
```

## 完整代码

User.cs

```csharp
public record User
{
    public int Id { get; init; } // 需求1
    public DateTime CreateAt { get; init; } // 需求1
    public string UserName { get; private set; } // 需求1
    public int Credit { get; private set; }

    private string? passwordHash; // 需求3

    private string? remark; // 需求3
    public string? Remark { get => remark; } // 需求4

    public string? Tag { get; set; } // 需求5

    private User() // 需求2
    {
    }

    public User(string yhm) // 需求2
    {
        UserName = yhm;
        CreateAt = DateTime.UtcNow;
        Credit = 0;
    }

    public void ChangeUserName(string newName) => UserName = newName;

    public void ChangePassword(string newValue)
    {
        passwordHash = newValue.Length < 6 ? throw new ArgumentException("密码太短") :
            HashHelper.CalculateMD5Hash(newValue);
    }
}

public static class HashHelper
{
    public static string CalculateMD5Hash(string input)
    {
        // Primeiro passo, calcular o MD5 hash a partir da string
        using var md5 = System.Security.Cryptography.MD5.Create();
        byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
        byte[] hash = md5.ComputeHash(inputBytes);

        // Segundo passo, converter o array de bytes em uma string haxadecimal
        var sb = new System.Text.StringBuilder();
        for (int i = 0; i < hash.Length; i++)
        {
            sb.Append(hash[i].ToString("X2"));
        }
        return sb.ToString();
    }
}
```

UserConfig.cs

```csharp
public class UserConfig : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.Property("passwordHash"); // 需求3
        builder.Property(u => u.Remark).HasField("remark"); // 需求4
        builder.Ignore(u => u.Tag); // 需求5
    }
}
```

## EF Core 应用配置

```csharp
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    base.OnModelCreating(modelBuilder);
    modelBuilder.ApplyConfigurationsFromAssembly(typeof(MyDbContext).Assembly);
}
```
