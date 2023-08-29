# [while, until, loop, next](https://ihower.tw/rails/ruby.html#%E8%BF%B4%E5%9C%88-while-loop-until-next-and-break)

`next` 的用法相当于 `contine`

`next`, `until`, `break` 后跟条件

实际中很少用`while`、`until`、`loop`

```ruby
i = 0
while (i < 10)
  puts i += 1
  next if i % 2 == 0 #跳過雙數
end
```

- until 示例

```ruby
i = 0
i += 1 until i > 10
puts i # 11
```

- loop 示例

```ruby
i = 0
loop do
    i += 1
    break if i > 10 # 中斷迴圈
end
```
