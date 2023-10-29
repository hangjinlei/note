# Exception

## 语法

```ruby
begin
    code
rescue TypeError => e # catch specific exception
    code
rescue # catch remaining exceptions
    code
ensure # 始终执行
    code
end
```

## 示例

```ruby
begin
    lucky_nums = [4, 8, 15, 16, 23, 42]
    lucky_nums["dog"]
    num = 10 / 0
rescue ZeroDivisionError => e # 捕获指定异常
    puts "Divided by zero error"
rescue TypeError => e
    puts e
rescue => exception # 捕获其余异常
    puts "Error: #{exception}"
ensure # 始终执行
    puts "Ensure"
end
```

## Error

- Type Error

  ```ruby
  lucky_nums = [4, 8, 15, 16, 23, 42]
  lucky_nums["dog"]
  ```

- ZeroDivisionError

  ```ruby
  num = 10 / 0
  ```
