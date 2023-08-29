# rack-cors

## 参考

- [Stack Overflow](https://stackoverflow.com/questions/29751115/how-to-enable-cors-in-rails-4-app)
- [GitHub](https://github.com/cyu/rack-cors)
- [简书](https://www.jianshu.com/p/c54a1dbaab24)

## 安装

```bash
gem install rack-cors
```

## Setup CORS

- Update `config/initializers/cors.rb` to allow all origins (\*) to make requests.

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

- Add the code below to `config/application.rb`

Rails 3/4:

```ruby
config.middleware.insert_before 0, "Rack::Cors" do
    allow do
        origins '_'
        resource '_', :headers => :any, :methods => :any
    end
end
```

Rails 5:

```ruby
config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins '_'
        resource '_', headers: :any, methods: :any
    end
end
```
