# Getting Started

## 参考

- [TypeORM](https://typeorm.io/)
- [Step-by-Step Guide](https://typeorm.io/#step-by-step-guide)

## 配置数据库连接

## 创建实体 (类似 Java 中的 Annotation 方式)

## 初始化连接

```typescript
const dataSource = await AppDataSource.initialize();
```

## 操作数据库

### 使用 `Entity Manager`

```typescript
const photos = AppDataSource.manager.find(Photo);
```

### 使用 `Repository`

```typescript
const photoRepository = dataSource.getRepository(Photo);
const photos = await photoRepo.find();
```
