# Authentication

- [GitHub](https://github.com/heartcombo/devise)
- [Getting started](https://github.com/heartcombo/devise#getting-started)

- 編輯 Gemfile 加上 `gem "devise"`
- 執行 `bundle，然後重啟伺服器`
- 執行 `rails g devise:install`
- 執行 `rails g devise user`
- 執行 `rails db:migrate`

## 控制器中使用

```ruby
before_action :authenticate_user!
```

## 获取用户

- `member_signed_in?`
- `current_member`
- `member_session`

## 生成 token

- app/models/user.rb

  ```ruby
  before_create :generate_authentication_token

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end
  ```
