# View

- [View](#view)
  - [链接](#链接)
  - [表单](#表单)
  - [搜索](#搜索)
  - [Check Box](#check-box)
  - [Radio Button](#radio-button)

## 链接

```erb
<p><%= link_to "Hello!", welcome_say_hello_path %></p>
```

`welcome_say_hello_path` 以 `config/routes.rb` 中的路径为准，以`\_path` 为后缀。

## 表单

index.html.erb

```erb
<%= form_with url: "/articles/search", method: :get do |form| %>

<% end %>
```

## 搜索

```erb
<%= form_with url: "/articles/search", method: :get do |form| %>
    <%= form.label :query, "Search for:" %>
    <%= form.text_field :query %>
    <%= form.submit "Search" %>
<% end %>
```

## Check Box

```erb
<%= form.check_box :pet_dog %>
<%= form.label :pet_dog, "I own a dog" %>

<%= form.check_box :pet_cat %>
<%= form.label :pet_cat, "I own a cat" %>
```

## Radio Button

```erb
<%= form.radio_button :age, "child" %>
<%= form.label :age_child, "I am younger than 18" %>

<%= form.radio_button :age, "adult" %>
<%= form.label :age_adult, "I am over 18" %>
```
