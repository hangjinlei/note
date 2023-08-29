# Controller

- [Controller](#controller)
  - [重定向](#重定向)
  - [控制器方法](#控制器方法)
  - [获取参数](#获取参数)

## 重定向

- [ActionController::Redirecting](https://api.rubyonrails.org/classes/ActionController/Redirecting.html)

```ruby
return redirect_to api_v1_reservation_url(@booking_code), status: 302
```

## 控制器方法

- `before_action`

  ```ruby
  before_action :authenticate_user!
  ```

- `skip_before_action`

  ```ruby
  skip_before_action :verify_authenticity_token # 跳过跨域检查
  ```

## 获取参数

使用内置 `params` 获取参数

```ruby
def show
    @event = Event.find(params[:id])
end
```
