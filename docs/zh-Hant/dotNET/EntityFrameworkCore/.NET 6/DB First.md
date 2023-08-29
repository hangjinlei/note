# DB First

## 参考

- [Entity Framework Core 工具参考 - Visual Studio 中的包管理器控制台](https://docs.microsoft.com/zh-cn/ef/core/cli/powershell)
- [Connection String](https://www.connectionstrings.com/sqlite/)

## Steps

1. NuGet

   - [Microsoft.EntityFrameworkCore.Sqlite](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Sqlite)
   - [Microsoft.EntityFrameworkCore.Tools](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.Tools)

2. Using `Scaffold-DbContext` command to create a DbContext

   ```PM
   Scaffold-DbContext -Connection name=Todo -Provider Microsoft.EntityFrameworkCore.Sqlite -OutputDir Models -ContextDir Data -Force
   ```

3. Storing Connection String in AppSettings

   appsettings.json

   ```json
   "ConnectionStrings": {
      "Todo": "Data Source=./Data/Todo.db;"
   }
   ```

4. Updating models after DB update

   ```PM
   Scaffold-DbContext -Connection name=Todo -Provider Microsoft.EntityFrameworkCore.Sqlite -OutputDir Models -ContextDir Data -Force
   ```

5. 注入服务（依赖注入），以使用 Entity Framework 自动生成代码

   Program.cs

   ```csharp
   builder.Services.AddDbContext<TodoContext>(options =>
      options.UseSqlite(builder.Configuration.GetConnectionString("Todo")));
   ```

6. To ignore Reference Looping.

   NuGet

   - [Microsoft.AspNetCore.Mvc.NewtonsoftJson](https://www.nuget.org/packages/Microsoft.AspNetCore.Mvc.NewtonsoftJson)

   Program.cs

   ```csharp
   builder.Services.AddMvc().AddNewtonsoftJson(options =>
      options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);
   ```
