# Routes

- [Routes](#routes)
  - [配置路由](#配置路由)
  - [默认回传 json](#默认回传-json)
  - [外卡路由 (模板路由)](#外卡路由-模板路由)
  - [路由规则](#路由规则)

config/routes.rb

- 要使用 Rails 的路由系统，可以使用 `Rails.application.routes.draw` 方法来定义路由。
- 要使用 root route，可以使用 `root 'controller#action'` 方法来定义路由。

## 配置路由

```ruby
Rails.application.routes.draw do
  # get "/path", to: "{Controller}#{Action}"
  get "/articles", to: "articles#index"
end
```

## 默认回传 json

```ruby
namespace :api, :defaults => { :format => :json } do
    # ...
end
```

## 外卡路由 (模板路由)

写在最后一行

```ruby
match ':controller(/:action(/:id(.:format)))', :via => :all
```

## 路由规则

|            Prefix | Verb   | URI Pattern                  | Controller#Action |
| ----------------: | :----- | :--------------------------- | :---------------- |
|            events | GET    | /events(.:format)            | events#index      |
|                   | POST   | /events(.:format)            | events#create     |
|         new_event | GET    | /events/new(.:format)        | events#new        |
|        edit_event | GET    | /events/:id/edit(.:format)   | events#edit       |
|             event | GET    | /events/:id(.:format)        | events#show       |
|                   | PATCH  | /events/:id(.:format)        | events#update     |
|                   | PUT    | /events/:id(.:format)        | events#update     |
|                   | DELETE | /events/:id(.:format)        | events#destroy    |
|           welcome | GET    | /welcome(.:format)           | welcome#index     |
| welcome_say_hello | GET    | /welcome/say_hello(.:format) | welcome#say       |
|              root | GET    | /                            | welcome#index     |

- show、new、edit、update、destroy 是單數，對單一元素操作
- index、create 是複數，對群集操作
- event_path(@event)需要參數，根據 HTTP 動詞決定 show、update、destroy
- events_path 毋需參數，根據 HTTP 動詞決定 index、create
