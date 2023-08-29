# json

- [将 json 数据转换为 ruby 类](https://jsonformatter.org/json-to-ruby)

## 安装

```bash
gem install json
```

## 示例

```ruby
require "rest-client"
require "json"

response = RestClient.get "https://raw.githubusercontent.com/hangjinlei/hangjinlei.github.io/data/apps/kgmusic/Singers.json"

p response.code
p response.body
p response.headers
p response.raw_headers
p response.cookies
p response.cookie_jar
p response.request
p response.history

puts response.body

data = JSON.parse(response.body)

puts data[0]
# {"uid"=>1, "shareId"=>"6b949586242f37", "headImgUrl"=>"http://shp.qlogo.cn/ttsing/9983120/9983120/100?ts=0", "nickName"=>"朝朝", "singerName"=>"MuaHueRr", "songs"=>[]}
```
