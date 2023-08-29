[toc]

# Code First

## References

- Microsoft Docs - [Entity Framework Core 工具参考 - Visual Studio 中的包管理器控制台](https://docs.microsoft.com/zh-cn/ef/core/cli/powershell)

- [Connection String](https://www.connectionstrings.com/sqlite/)

## Steps

1. NuGet

   - [Microsoft.EntityFrameworkCore.Sqlite](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Sqlite)
   - [Microsoft.EntityFrameworkCore.Tools](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Tools)

2. Storing Connection String in AppSettings

   appsettings.json

   ```json
   "ConnectionStrings": {
      "Todo": "Data Source=./Data/Todo.db;"
   }
   ```

3. 注入服务（依赖注入），以使用 Entity Framework 生成数据库

   - Program.cs

   ```csharp
   builder.Services.AddDbContext<TodoContext>(options =>
      options.UseSqlite(builder.Configuration.GetConnectionString("Todo")));
   ```

4. Using `Add-Migration` or `Update-Database` command to add a migration or update the database

   - Add-Migration
   - Update-Database

   ```PM
   Scaffold-DbContext -Connection name=Todo -Provider Microsoft.EntityFrameworkCore.Sqlite -OutputDir Models -ContextDir Data -Force
   ```

5. To ignore Reference Looping.

   ```csharp
   builder.Services.AddControllers().AddJsonOptions(options =>
      options.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles);
   ```

   NuGet: [Microsoft.AspNetCore.Mvc.NewtonsoftJson](./../NuGet.md)

   - Program.cs

   ```csharp
   builder.Services.AddMvc().AddNewtonsoftJson(options =>
      options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
   ```
