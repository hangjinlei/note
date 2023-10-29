# Hash

- **key 必须唯一**

## Syntax

```ruby
states = Hash.new
states[:Pennsylvania] = "PA"
states["New York"] = "NY"
states["Oregon"] = "OR"
states["California"] = "CA"
states[1] = "one"
```

```ruby
states = {
    :Pennsylvania => "PA",
    "New York" => "NY",
    "Oregon" => "OR",
    "California" => "CA",
    1 => "one",
}
```

```ruby
puts states # => {:Pennsylvania=>"PA", "New York"=>"NY", "Oregon"=>"OR", "California"=>"CA", 1=>"one"}
puts states[:Pennsylvania] # PA
puts states["New York"] # NY
puts states[1] # one
```

## Methods

- length
- delete

## Fetch Keys and Values

```ruby
<keys array variable> = <hash variable>.keys( )
<values array variable> = <hash variable>.values( )
```

Example:

```ruby
K = myhash.keys( )
V = myhash.values( )
```
