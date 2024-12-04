# Migrate

- [Migrate](#migrate)
  - [创建 Model](#创建-model)
  - [新增 Column](#新增-column)

## 创建 Model

```shell
rails g model event name:string description:text is_public:boolean capacity:integer
```

会生成以下代码

```ruby
class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.boolean :is_public
      t.integer :capacity

      t.timestamps
    end
  end
end
```

## 新增 Column

```shell
rails g migration add_status_to_events
```

会生成以下代码

```ruby
class AddStatusToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :table_name, :column_name, :column_type, :column_options
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
```
