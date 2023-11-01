# Array

- [Array](#array)
  - [使用索引](#使用索引)
  - [方法](#方法)
  - [include?](#include)
  - [**_Warning_**](#warning)

```ruby
friends = Array["Kevin", "Karen", "Jim", "Oscar", "Toby"]
friends = ["Kevin", "Karen", "Jim", "Oscar", "Toby"]
```

## 使用索引

- Get Values

  ```ruby
  puts friends[1] # Karen (index 1)
  puts friends[-1] # Toby (last element)
  puts friends[0, 2] # Kevin, Karen (index 0, 2 elements)
  ```

- Set Values

  ```ruby
  friends[0] = "Timothy"
  puts friends[0] # Timothy

  friends = Array.new
  friends[0] = "Kevin"
  puts friends[0] # Kevin

  friends[5] = "Timothy"
  puts friends[5] # Timothy

  # bad_array = Array["Kevin", "Karen", 1, "Oscar", "Toby"]
  # puts bad_array.sort() # Error: can't compare String with Fixnum
  ```

## 方法

> - length()
> - reverse()
> - sort()
> - size()

```ruby
puts friends.length() # 5
puts friends.reverse() # Toby, Oscar, Jim, Karen, Kevin
puts friends.sort() # Karen, Kevin, Jim, Oscar, Toby
```

## include?

```ruby
puts friends.include? "Timothy" # false
```

## **_Warning_**

```ruby
color = Array.new

color[0] = "red", color[4] = "orange" # 注意', '的位置

puts color[0] # =>
=begin
red
orange
=end
```
