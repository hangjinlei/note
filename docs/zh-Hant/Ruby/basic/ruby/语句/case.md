# [case](https://ihower.tw/rails/ruby.html#%E6%8E%A7%E5%88%B6%E7%B5%90%E6%A7%8Bcase)

```ruby
case condition
when value
    code
when value
    code
else
    code
end
```

## 示例

```ruby
def get_day_name(day)
    day_name = ""

    case day
    when "mon"
        day_name = "Monday"
    when "tue"
        day_name = "Tuesday"
    when "wed"
        day_name = "Wednesday"
    when "thu"
        day_name = "Thursday"
    when "fri"
        day_name = "Friday"
    when "sat"
        day_name = "Saturday"
    when "sun"
        day_name = "Sunday"
    else
        day_name = "Invalid abbreviation"
    end

    return day_name
end

puts get_day_name("mon") # => "Monday"
```
