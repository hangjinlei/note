# for

```ruby
# 1
for <variable> in <collection>
    code
end

# 2
collection.each do [|variable|]
    code
end

# 3
number.times do [|variable|]
    code
end
```

## 示例

```ruby
friends = ["Kevin", "Karen", "Jim", "Oscar", "Toby"]

# 1
for friend in friends do
    puts "Hello, #{friend}!"
end

# 2
friends.each do |friend|
    puts "Hello, #{friend}!"
end

# 4
6.times do |index|
    puts index
end

# 4
for index in 0..5
    puts index
end
```
