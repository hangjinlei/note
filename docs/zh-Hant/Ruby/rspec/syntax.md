# Syntax

```ruby
class HelloWorld
  def SayHello
    return "Hello World"
  end
end

describe "HelloWorld" do
  context "When testing the HelloWorld Class" do
    it "should say 'Hello World' when call the SayHello Method" do
      hw = HelloWorld.new
      message = hw.SayHello
      expect(message).to eql "Hello World"
    end
  end
end
```

- `describe` string block
- `context` string block
- `it` string block
