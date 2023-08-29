# Rails 内置配置

## 参考

- [博客园](https://www.cnblogs.com/zhangyanpei/articles/10061011.html)

## 说明

```bash
rails g controller api --no-assets
```

让其他控制器继承自 `ApiController`, 修改继承类 `ActionController::Base`

```ruby
class ApiController < ActionController::Base
    skip_before_action :verify_authenticity_token
end
```

示例

```ruby
class Application < Rails::Application
    ...

    config.action_dispatch.default_headers = {
        "Access-Control-Allow-Origin" => "http://127.0.0.1:8080",
        "Access-Control-Allow-Methods" => "POST, PUT, DELETE, GET, PATCH, OPTIONS",
        "Access-Control-Request-Method" => "*",
        "Access-Control-Allow-Headers" => "*",
    }
end
```
