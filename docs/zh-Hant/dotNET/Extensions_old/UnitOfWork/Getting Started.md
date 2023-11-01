# Getting Started

- [Getting Started](#getting-started)
  - [安装](#安装)
  - [创建仓库](#创建仓库)
  - [创建服务](#创建服务)
    - [创建泛型服务基接口](#创建泛型服务基接口)
    - [创建服务基接口，继承泛型服务基接口](#创建服务基接口继承泛型服务基接口)
    - [创建服务实现](#创建服务实现)
  - [创建控制器](#创建控制器)

## 安装

- NuGet
  - [Microsoft.EntityFrameworkCore.UnitOfWork](https://www.nuget.org/packages/Microsoft.EntityFrameworkCore.UnitOfWork)

## 创建仓库

- 使用

  1. 继承 `Repository<T>` 类，并实现 `IRepository<T>` 接口
  2. 在容器中注入

- ToDoRepository

  ```csharp
  public class ToDoRepository : Repository<Todo>, IRepository<Todo>
  {
      public ToDoRepository(MyToDoContext dbContext) : base(dbContext)
      {
      }
  }
  ```

- Program.cs

  ```csharp
  builder.Services.AddDbContext<MyToDoContext>(options => options.UseSqlite(builder.Configuration.GetConnectionString("ToDoConnection")))
      .AddUnitOfWork<MyToDoContext>()
      .AddCustomRepository<Todo, ToDoRepository>()
      .AddCustomRepository<Memo, MemoRepository>()
      .AddCustomRepository<User, UserRepository>();
  ```

## 创建服务

### 创建泛型服务基接口

- IBaseService.cs

  定义一些基础的功能

  ```csharp
  namespace MyToDo.Api.Services;

  public interface IBaseService<T>
  {
      public Task<ApiResponse> GetAllAsync();
      public Task<ApiResponse> GetAsync(int id);
      public Task<ApiResponse> AddAsync(T entity);
      public Task<ApiResponse> UpdateAsync(T entity);
      public Task<ApiResponse> DeleteAsync(int id);
  }
  ```

### 创建服务基接口，继承泛型服务基接口

- IToDoService.cs

  继承泛型接口

  ```csharp
  using MyToDo.Shared.Dtos;

  namespace MyToDo.Api.Services;

  public interface IToDoService : IBaseService<ToDo>
  {

  }
  ```

### 创建服务实现

- ToDoService.cs

  注入`IUnitOfWork`, 通过`IUnitOfWork` 获取注册的 `Repository`

  实现接口中的基础功能

  ```csharp
  using MyToDo.Api.Models;

  namespace MyToDo.Api.Services;

  /// <summary>
  /// 待办事项的实现
  /// </summary>
  public class ToDoService : IToDoService
  {
      private readonly IUnitOfWork _unitOfWork;

      public ToDoService(IUnitOfWork unitOfWork)
      {
          _unitOfWork = unitOfWork;
      }

      public async Task<ApiResponse> AddAsync(ToDo entity)
      {
          try
          {
              await _unitOfWork.GetRepository<ToDo>().InsertAsync(entity);
              if (await _unitOfWork.SaveChangesAsync() > 0)
                  return new(true, entity);
              return new("添加数据失败");
          }
          catch (Exception ex)
          {
              return new(ex.Message);
          }
      }

      public async Task<ApiResponse> DeleteAsync(int id)
      {
          try
          {
              var repository = _unitOfWork.GetRepository<ToDo>();
              var todo = await repository.GetFirstOrDefaultAsync(predicate: x => x.Id.Equals(id));
              repository.Delete(todo);
              if (await _unitOfWork.SaveChangesAsync() > 0)
                  return new(true, null);
              return new("删除数据失败");
          }
          catch (Exception ex)
          {
              return new(ex.Message);
          }
      }

      public async Task<ApiResponse> GetAllAsync()
      {
          try
          {
              var repository = _unitOfWork.GetRepository<ToDo>();
              var todos = await repository.GetPagedListAsync();
              return new(true, todos);
          }
          catch (Exception ex)
          {
              return new(ex.Message);
          }
      }

      public async Task<ApiResponse> GetAsync(int id)
      {
          try
          {
              var repository = _unitOfWork.GetRepository<ToDo>();
              var todo = await repository.GetFirstOrDefaultAsync(predicate: x => x.Id.Equals(id));
              return new(true, todo);
          }
          catch (Exception ex)
          {
              return new(ex.Message);
          }
      }

      public async Task<ApiResponse> UpdateAsync(ToDo entity)
      {
          try
          {
              var repository = _unitOfWork.GetRepository<ToDo>();
              var todo = await repository.GetFirstOrDefaultAsync(predicate: x => x.Id.Equals(entity.Id));

              todo.Title = entity.Title;
              todo.Content = entity.Content;
              todo.Status = entity.Status;
              todo.UpdateTime = DateTime.Now;

              repository.Update(todo);

              if (await _unitOfWork.SaveChangesAsync() > 0)
                  return new(true, todo);
              return new("更新失败");
          }
          catch (Exception ex)
          {
              return new(ex.Message);
          }
      }
  }
  ```

## 创建控制器

- ToDoController.cs

  注入服务

  ```csharp
  using MyToDo.Api.Models;
  using MyToDo.Api.Services;

  namespace MyToDo.Api.Controllers;

  /// <summary>
  /// 待办事项控制器
  /// </summary>
  [ApiController]
  [Route("api/[controller]")]
  public class ToDoController : ControllerBase
  {
      private readonly IToDoService service;

      public ToDoController(IToDoService toDoService)
      {
          service = toDoService;
      }

      [HttpGet]
      public async Task<ApiResponse> GetAllAsync() => await service.GetAllAsync();

      [HttpGet("{id}")]
      public async Task<ApiResponse> GetAsync(int id) => await service.GetAsync(id);

      [HttpPost]
      public async Task<ApiResponse> AddAsync([FromBody] ToDo entity) => await service.AddAsync(entity);

      [HttpPut]
      public async Task<ApiResponse> UpdateAsync([FromBody] ToDo entity) => await service.UpdateAsync(entity);

      [HttpDelete("{id}")]
      public async Task<ApiResponse> DeleteAsync(int id) => await service.DeleteAsync(id);
  }
  ```
