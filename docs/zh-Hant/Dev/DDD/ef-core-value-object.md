# 值对象在 EF Core 中的实现

值对象与实体的区别

- 值对象没有标识符

## 值对象实现的要求

### 1. 把有紧密关系的属性打包为一个独立的类型

Geolocation.cs

```csharp
public record Geolocation
{
    public double Latitude { get; init; }
    public double Longitude { get; init; }

    public Geolocation(double latitude, double longitude)
    {
        if (latitude > -90 || latitude < 90)
        {
            throw new ArgumentOutOfRangeException(nameof(latitude));
        }
        if (longitude > -180 || longitude < 180)
        {
            throw new ArgumentOutOfRangeException(nameof(longitude));
        }

        Latitude = latitude;
        Longitude = longitude;
    }
}
```

### 2. 把领域知识放到类的定义中

Shop.cs

```csharp
public record Shop
{
    public int Id { get; init; }
    public string Name { get; init; }
    public Geolocation Location { get; init; }
}
```

### 3. 很多数值类型的属性都隐含了单位

```csharp
public record Product
{
    public int Id { get; init; }
    public string Name { get; set; }
    public CurrencyName Currency { get; set; }

}

public enum CurrencyName
{
    AED, AFN, ALL, AMD, AOA, ARS, AUD, AZN, BAM, BBD, BDT, BGN, BHD,
    BIF, BND, BOB, BRL, BSD, BTN, BWP, BYN, BZD, CAD, CDF, CHF, CLP,
    CNY, COP, CRC, CUP, CVE, CZK, DJF, DKK, DOP, DZD, EGP, ERN, ETB,
    EUR, FJD, GBP, GEL, GHS, GMD, GNF, GTQ, GYD, HNL, HRK, HTG, HUF,
    IDR, ILS, INR, IQD, IRR, ISK, JMD, JOD, JPY, KES, KGS, KHR, KMF,
    KPW, KRW, KWD, KZT, LAK, LBP, LKR, LRD, LSL, LYD, MAD, MDL, MGA,
    MKD, MMK, MNT, MRO, MUR, MVR, MWK, MXN, MYR, MZN, NAD, NGN, NIO,
    NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN, PYG, QAR, RON,
    RSD, RUB, RWF, SAR, SBD, SCR, SDG, SEK, SGD, SLL, SOS, SRD, SSP,
    STD, SYP, SZL, THB, TJS, TMT, TND, TOP, TRY, TTD, TWD, TZS, UAH,
    UGX, USD, UYU, UZS, VEF, VND, VUV, WST, XAF, XCD, XOF, YER, ZAR,
    ZMW
}
```

## 将值对象保存到实体中

ShopConfig.cs

```csharp
public class ShopConfig : IEntityTypeConfiguration<Shop>
{
    public void Configure(EntityTypeBuilder<Shop> builder)
    {
        builder.OwnsOne<Geolocation>(s => s.Location);
    }
}
```

应用迁移

```sql
exec sp_help [dbo.Shops];
```

| Column_name        | Type     |
| :----------------- | :------- |
| Id                 | int      |
| Name               | nvarchar |
| Location_Latitude  | float    |
| Location_Longitude | float    |

## 完整代码

Shop.cs

```csharp
public record Shop
{
    public int Id { get; init; }
    public string Name { get; init; }
    public Geolocation Location { get; init; }
}
```

Geolocation.cs

```csharp
public record Geolocation
{
    public double Latitude { get; init; }
    public double Longitude { get; init; }

    public Geolocation(double latitude, double longitude)
    {
        if (latitude > -90 || latitude < 90)
        {
            throw new ArgumentOutOfRangeException(nameof(latitude));
        }
        if (longitude > -180 || longitude < 180)
        {
            throw new ArgumentOutOfRangeException(nameof(longitude));
        }

        Latitude = latitude;
        Longitude = longitude;
    }
}
```

ShopConfig.cs

```csharp
public class ShopConfig : IEntityTypeConfiguration<Shop>
{
    public void Configure(EntityTypeBuilder<Shop> builder)
    {
        builder.OwnsOne<Geolocation>(s => s.Location);
    }
}
```

## 更多示例

### EF Core 应用配置

```csharp
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    base.OnModelCreating(modelBuilder);
    modelBuilder.ApplyConfigurationsFromAssembly(typeof(MyDbContext).Assembly);
}
```

### 多语言支持

MultilangString.cs

```csharp
public record MulitLangString(string? Chinese, string English);
```

Blog.cs

```csharp
public class Blog
{
    public int Id { get; set; }
    public required MulitLangString Title { get; set; }
    public required MulitLangString Content { get; set; }
}
```

BlogConfig.cs

```csharp
public class BlogConfig : IEntityTypeConfiguration<Blog>
{
    public void Configure(EntityTypeBuilder<Blog> builder)
    {
        builder.OwnsOne<MulitLangString>(b => b.Title, t =>
        {
            t.Property(e => e.Chinese).IsUnicode(true).HasMaxLength(255);
            t.Property(e => e.English).IsUnicode(false).HasMaxLength(255).HasColumnType("varchar");
        });
        builder.OwnsOne<MulitLangString>(b => b.Content, c =>
        {
            c.Property(e => e.English).HasColumnType("varchar(max)");
        });
    }
}
```

```sql
exec sp_help [dbo.Blogs];
```

| Column_name     | Type     | Length |
| :-------------- | :------- | :----- |
| Id              | int      | 4      |
| Title_Chinese   | nvarchar | 510    |
| Title_English   | varchar  | 255    |
| Content_Chinese | nvarchar | -1     |
| Content_English | varchar  | -1     |

## 更多阅读

### EF Core 中实现 strongly-typed ids

- [C# 9 records as strongly-typed ids - Part 4: Entity Framework Core integration](https://thomaslevesque.com/2020/12/23/csharp-9-records-as-strongly-typed-ids-part-4-entity-framework-core-integration/)
- [Strongly-typed IDs in EF Core (Revisited)](https://andrewlock.net/strongly-typed-ids-in-ef-core-using-strongly-typed-entity-ids-to-avoid-primitive-obsession-part-4/)
