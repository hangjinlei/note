# RestClient

## 安装

```bash
gem install rest-client
```

## 参考

- [GitHub](https://github.com/rest-client/rest-client)
- [Docs](https://rubydoc.info/github/rest-client/rest-client/master)

### [result-handling](https://github.com/rest-client/rest-client#result-handling)

- Response#code: The HTTP response code
- Response#body: The response body as a string. (AKA .to_s)
- Response#headers: A hash of HTTP response headers
- Response#raw_headers: A hash of HTTP response headers as unprocessed arrays
- Response#cookies: A hash of HTTP cookies set by the server
- Response#cookie_jar: New in 1.8 An HTTP::CookieJar of cookies
- Response#request: The RestClient::Request object used to make the request
- Response#history: New in 2.0 If redirection was followed, a list of prior Response objects

## 示例

```ruby
puts "Fetch singer data..."
response = RestClient.get "https://raw.githubusercontent.com/hangjinlei/hangjinlei.github.io/data/apps/kgmusic/Singers.json"
data = JSON.parse(response.body)

data.each do |c|
    puts c
    existing_singer = Singer.find_by_share_id(c["shareId"])
    if existing_singer.nil?
    Singer.create!(:uid => c["uid"],
                   :share_id => c["shareId"],
                   :head_img_url => c["headImgUrl"],
                   :nick_name => c["nickName"],
                   :singer_name => c["singerName"])
    end
end

puts "Total: #{Singer.count} singers"
```

## Migrate

```ruby
class CreateSingers < ActiveRecord::Migration[7.0]
  def change
    create_table :singers do |t|
      t.integer :uid
      t.string :share_id
      t.string :head_img_url
      t.string :nick_name
      t.string :singer_name
      t.string :songs

      t.timestamps
    end

    add_index :singers, :uid
  end
end
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

puts JSON.parse(response.body)
```
