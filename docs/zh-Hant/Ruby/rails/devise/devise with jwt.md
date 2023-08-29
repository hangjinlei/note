# devise with jwt

- [GitHub](https://github.com/heartcombo/devise)
- [Tutorial](https://enlear.academy/how-to-create-a-rails-6-api-with-devise-jwt-46fa35085e85)

1. Gemfile

   ```shell
   gem 'devise'
   gem 'devise-jwt'
   ```

2. `bundle`
3. Generate users with devise

- `rails g devise:install`
- `rails g devise user`
- `rails db:migrate`
