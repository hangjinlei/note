# Entity Framework Core

## 基础

-   [迁移](https://learn.microsoft.com/zh-cn/ef/core/managing-schemas/migrations)
    -   [Add-Migration](https://learn.microsoft.com/zh-cn/ef/core/cli/powershell#add-migration)
-   [反向工程](https://learn.microsoft.com/zh-cn/ef/core/managing-schemas/scaffolding)
    -   [Scaffold-DbContext](https://learn.microsoft.com/zh-cn/ef/core/cli/powershell#scaffold-dbcontext)
-   [数据种子设定](https://learn.microsoft.com/zh-cn/ef/core/modeling/data-seeding)
-   [自动创建数据库 | DatabaseFacade.EnsureCreated 方法 (Microsoft.EntityFrameworkCore.Infrastructure)](https://learn.microsoft.com/zh-cn/dotnet/api/microsoft.entityframeworkcore.infrastructure.databasefacade.ensurecreated)
    -   [自动创建数据库示例](https://learn.microsoft.com/zh-cn/training/modules/interact-with-data-blazor-web-apps/5-exercise-access-data-from-blazor-components)

## 适用于 ASP.NET Core

-   [关联数据和序列化 (适用于循环引用)](https://learn.microsoft.com/zh-cn/ef/core/querying/related-data/serialization)
-   [ASP.NET Core 依赖关系注入中的 DbContext](https://learn.microsoft.com/zh-cn/ef/core/dbcontext-configuration/#dbcontext-in-dependency-injection-for-aspnet-core)

## 外部资源

-   [Connection String](https://www.connectionstrings.com/sqlite/)

## 注意

-   当处于 ToList 操作前时, 不能对中间结果进行转换, 否则可能会导致异常
