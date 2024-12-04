# IO

- [IO](#io)
  - [步骤](#步骤)
  - [说明](#说明)
  - [示例](#示例)
  - [读取](#读取)
    - [读取的方法](#读取的方法)
  - [写入](#写入)

## 步骤

1. 打开文件
2. 读取文件的文本数据
3. 输出文件的文本数据
4. 关闭文件

## 说明

```ruby
File.open(arg1, arg2)
```

- arg1: file name
- arg2: mode (r, r+, w, w+, a, a+, etc.)
  - mode 参考: [Stack Overflow](https://stackoverflow.com/questions/3682359/what-are-the-ruby-file-open-modes-and-options)
- 需要注意文件指针的位置

## 示例

```ruby
file = File.open("./employees.txt", "r")
puts file.read()
file.close()
```

## 读取

```ruby
file.read() # reads the entire file
file.readchar() # reads one character
file.readline() # reads one line
file.readlines() # reads all lines
```

### 读取的方法

- read()
- readchar()
- readline()
- readlines()
- each_line()

```ruby
File.open("./employees.txt", "r") do |file|
    puts file.read() # read the entire file
    puts file.readchar() # read one character
    puts file.readchar() # read next character
    puts file.readline() # read one line
    puts file.readline() # read next line

    puts file.readlines() # read all lines

    for line in file.readlines do
        puts line
    end
end
```

## 写入

```ruby
file = File.open("./employees.txt", "a")

file.write("Oscar, Accounting\n")

file = File.open("index.html", "w") do |f|
    f.write("<h1>Hello</h1>")
end
```

```ruby
File.open("index.html", "a+") do |f|
    puts f.readchar
    puts f.readchar
    puts f.readchar
    puts f.readchar
    puts f.readchar

    f.write("<h1>Hello</h1>")
end
```
