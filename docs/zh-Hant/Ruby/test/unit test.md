# Unit Test

- [rspec-rails](https://github.com/rspec/rspec-rails)
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
- [rspec-rails Installation](https://github.com/rspec/rspec-rails#installation)

1. Gemfile

   ```ruby
   group :development, :test do
     [...]
     gem "rspec-rails"
   end
   ```

2. project directory

   ```shell
   bundle install
   ```

   ```shell
   rails g rspec:install
   ```

3. `spec/requests/books_spec.rb`

   ```ruby
   require "rails_helper"

   describe "Books API", type: :request do
     it "returns all books" do
       get "/api/v1/books"

       expect(response).to have_http_status(:success)
       expect(JSON.parse(response.body).size).to eq(2)
     end
   end
   ```

## [factory_bot_rails Installation](https://github.com/thoughtbot/factory_bot_rails#rails)

1. Gemfile

   ```ruby
   group :development, :test do
     [...]
     gem "factory_bot_rails"
   end
   ```

2. project directory

   ```shell
   bundle install
   ```

3. `spec/factories/book.rb`

   ```ruby
   FactoryBot.define do
     factory :book do
     end
   end
   ```

4. `spec/requests/books_spec.rb`

   ```diff
    require "rails_helper"

    describe "Books API", type: :request do
      it "returns all books" do
   +    FactoryBot.create(:book, title: "Book 1", author: "Author 1")
   +    FactoryBot.create(:book, title: "Book 2", author: "Author 2")

        get "/api/v1/books"

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end
   ```

## run

- project directory

  ```shell
  rspec
  ```

  OR

  ```shell
  rspec spec/requests/books_spec.rb
  ```

  OR

  ```shell
  bundle exec rspec spec/requests/books_spec.rb
  ```
