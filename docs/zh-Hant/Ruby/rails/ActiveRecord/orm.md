# ActiveRecord

| 方法/属性    | 说明                   |
| :----------- | :--------------------- |
| `has_many`   | 主键表, 一对多         |
| `has_one`    | 主键表, 一对一         |
| `belongs_to` | 外键表, 一对多, 一对一 |
| `:optional`  | 允许该属性为空         |

## [一对多](https://ihower.tw/rails/activerecord.html#一對多關聯one-to-many)

当建立 `has_many`, `belongs_to` 关系时, Rails 会自动确立外键关系

Shell

```shell
rails g model event name:string description:text is_public:boolean capacity:integer

rails g model attendee name:string event_id:integer

rails g model category
```

Model

```ruby
class Event < ApplicationRecord
    has_many :attendees # 複數
    belongs_to :category, :optional => true
    #...
end

class Attendee < ApplicationRecord
    belongs_to :event # 單數
end

class Category < ApplicationRecord
    has_many :events
end
```

## [一对一](https://ihower.tw/rails/activerecord.html#一對一關聯one-to-one)

Shell

```shell
rails g model location name:string event_id:integer
```

Model

```ruby
class Event < ApplicationRecord
    has_one :location # 單數
    #...
end

class Location < ApplicationRecord
    belongs_to :event # 單數
end
```

## ~~[ORM](https://ihower.tw/rails/intro.html#orm)~~

```sql
SELECT * FROM orders, users WHERE orders.user_id = users.id AND orders.status = "Paid" LIMIT 5 ORDER BY orders.created_at;
```

```ruby
Order.where(:status => "paid").includes(:user).limit(5).order("created_at")
```
