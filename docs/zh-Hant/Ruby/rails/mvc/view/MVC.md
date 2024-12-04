# MVC

- [MVC](#mvc)
  - [创建一个 Controller](#创建一个-controller)
  - [创建一个 View](#创建一个-view)
  - [创建一个 Model](#创建一个-model)
  - [应用 Migration](#应用-migration)
  - [app/controllers/articles_controller.rb](#appcontrollersarticles_controllerrb)
  - [app/views/articles/index.html.erb](#appviewsarticlesindexhtmlerb)

## 创建一个 Controller

```shell
rails g controller welcome
```

## 创建一个 View

app/views/welcome/index.html.erb

```erb
<p>Hola! It's <%= Time.now %></p>
<p><%= link_to 'Hello!', welcome_say_hello_path %></p>
```

## 应用 Migration

```shell
bin/rails db:migrate
```

## app/controllers/articles_controller.rb

```ruby
class ArticlesController < ApplicationController
     def index
         # Add the following line
         @articles = Array[Article.new(title: "Hello Rails1", body: "I am on Rails!"), Article.new(title: "Hello Rails2", body: "I am on Rails!")]
     end
end
```

## app/views/articles/index.html.erb

```erb
<h1>Articles</h1>
<ul>
  <% @articles.each do |article| %>
  <li><%= article.title %> · <%= article.body %></li>
  <% end %>
</ul>
```
