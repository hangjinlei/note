# Froms

```erb
<%= form_with url: "/articles/form", method: :get do |form| %>
    <%= form.label :query, "Search for:" %>
    <%= form.text_field :query %>
    <%= form.submit "Search" %>

    <%= form.check_box :pet_dog %>
    <%= form.label :pet_dog, "I own a dog" %>
    <%= form.check_box :pet_cat %>
    <%= form.label :pet_cat, "I own a cat" %>

    <%= form.radio_button :age, "child" %>
    <%= form.label :age_child, "I am younger than 18" %>
    <%= form.radio_button :age, "adult" %>
    <%= form.label :age_adult, "I am over 18" %>

    <%= form.text_area :message, size: "70x5" %>

    <%= form.hidden_field :parent_id, value: "foo" %>

    <%= form.password_field :password %>

    <%= form.number_field :price, in: 1.0..20.0, step: 0.5 %>

    <%= form.range_field :discount, in: 1..100 %>

    <%= form.date_field :born_on %>

    <%= form.time_field :started_at %>

    <%= form.datetime_local_field :graduation_day %>

    <%= form.month_field :birthday_month %>

    <%= form.week_field :birthday_week %>

    <%= form.search_field :name %>

    <%= form.email_field :address %>

    <%= form.telephone_field :phone %>

    <%= form.url_field :homepage %>

    <%= form.color_field :favorite_color %>
<% end %>
```
