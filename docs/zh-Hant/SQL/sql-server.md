# SQL Server 相关

## View the Table Definition

https://learn.microsoft.com/en-us/sql/relational-databases/tables/view-the-table-definition

```sql
EXEC sp_help 'dbo.mytable';
```

## 不信任的服务器证书

Add `TrustServerCertificate=True` to the connection string.

```sql
Server=127.0.0.1,1433;Database=AdventureWorks2019;User Id=sa;Password=P@ssw0rd;TrustServerCertificate=True;
```
