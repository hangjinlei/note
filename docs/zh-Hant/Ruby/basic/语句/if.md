# [if](https://ihower.tw/rails/ruby.html#%E6%8E%A7%E5%88%B6%E7%B5%90%E6%A7%8Bif)

`then` 通常可以省略

```ruby
if <condition> then
    code
elsif <condition> then
    code
else
    code
end
```

OR

```ruby
code if <condition>
```

## 示例

```ruby
ismale = false
istall = true

if ismale and istall
    puts "You are a tall male"
elsif ismale and !istall
    puts "you are a short male"
elsif !ismale and istall
    puts "You are not male but are tall"
else
    puts "You are not male and not tall"
end
```

OR

```ruby
puts "greater than ten" if total > 10
```
