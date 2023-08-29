# range

## Basic

### Syntax

```ruby
<variable> = (<range beginning> .. <range end>)
<variable> = (<range beginning> ... <range end>)
```

Using Ranges in decision making

```ruby
case (<variable>)
when (<range 1 begin> … <range 1 end>)
#Statements to be executed when <variable> falls in range 1
when (<range 2 begin> … <range 2 end>)
#Statements to be executed when <variable> falls in range 2
when (<range 3 begin> … <range 3 end>)
#Statements to be executed when <variable> falls in range 3
when (<range 4 begin> … <range 4 end>)
#Statements to be executed when <variable> falls in range 4
…
…
…
when (<range n begin> … <range n end>)
#Statements to be executed when <variable> falls in range n
else
#Statements to be executed when <variable> does not fall in any
range.
end
```

### Sample

```ruby
range1 = (1..5)
range2 = ('a'...'e')

puts range1.to_a # => [1, 2, 3, 4, 5]
puts range2.to_a # => ["a", "b", "c", "d"]
```

```ruby
puts "\nEnter an alphabet: "
alpha = gets
alpha = alpha . chomp
if (( 'a' .. 'z' ) === alpha )
puts "\n #{ alpha } is in lower case.\n"
elsif (( 'A' .. 'Z' ) === alpha )
puts "\n #{ alpha } is in upper case.\n"
else
puts "\nInvalid input. Only single alphabets are allowed.\n\n"
end
```
