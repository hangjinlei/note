# Getting Started

注意的地方:

1. 语法
2. 生成 API 项目时需要 `--api`
3. 路由使用 namespace 时 `Controller` 路径要匹配, `Controller` 中的 `Module` 嵌套要匹配

- [Getting Started](#getting-started)
  - [index](#index)
  - [created](#created)
    - [添加验证](#添加验证)
  - [destroy](#destroy)
    - [异常处理](#异常处理)
  - [namespace](#namespace)

## index

```ruby
class BooksController < ApplicationController
  def index
    render json: Book.all
  end
end
```

## created

```ruby
class BooksController < ApplicationController
  def create
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    # 此处验证不起作用，下一节将添加验证
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
    #  Ruby 默认会将最后一行执行的结果作为返回值返回，与下列代码等效
    #  return params.require(:book).permit(:title, :author)
  end
end
```

### 添加验证

[Active Record Validations — Ruby on Rails Guides](https://guides.rubyonrails.org/active_record_validations.html)

```ruby
class Book < ApplicationRecord
  validates :author, presence: true, length: { minimum: 3 }
  validates :title, presence: true, length: { minimum: 3 }
end
```

## destroy

```ruby
def destroy
  Book.find(params[:id]).destroy!

  head :no_content
end
```

### [异常处理](../异常)

```ruby
class BooksController < ApplicationController
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  def destroy
    Book.find(params[:id]).destroy!

    head :no_content
  end

  private

  def not_destroyed(e)
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end
end
```

进化

```ruby
class BooksController < ApplicationController
  def destroy
    Book.find(params[:id]).destroy!

    head :no_content
  end
end
```

```ruby
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  private

  def not_destroyed(e)
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end
end
```

## namespace

```ruby
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :create, :destroy]
    end
  end
end
```

文件路径: `controller/` --> `controller/api/v1/`

请求路径: `http://*:3000/books` --> `http://*:3000/api/v1/books`

```ruby
module Api
  module V1
    class BooksController < ApplicationController
      [...]
    end
  end
end
```
