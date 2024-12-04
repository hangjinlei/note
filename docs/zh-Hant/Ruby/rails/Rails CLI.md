# Rails CLI

| Command                 | Description                        | Example                                                  |
| :---------------------- | :--------------------------------- | :------------------------------------------------------- |
| rails c / rails console | REPL                               | Book.create!(author: "Timothy", title: "C#")             |
| rails db:create         | 创建 Database                      | rails db:create db:migrate                               |
| rails db:migrate        | 应用 Migration                     | rails db:create db:migrate                               |
| rails g controller      | 创建 Controller, 同时创建方法      | rails generate controller Articles index --skip-routes   |
| rails g migration       | 创建新的 Migration, 如添加字段     | rails g migration add_status_to_events                   |
| rails g model           | 创建 Model                         | rails generate model Post title:string content:text      |
| rails g scaffold        | 创建 CRUD, MVC 模式时还会生成 View | rails g scaffold Api::V1::Post title:string content:text |
| rails new               | 创建 Project                       | rails new myapi                                          |
|                         |                                    | rails new myapi --api                                    |
| rails s / rails server  | Run                                |                                                          |

- [rails cli 参考](https://guides.rubyonrails.org/command_line.html)
- [rails g 参考](https://guides.rubyonrails.org/command_line.html#bin-rails-generate)
- 数据库配置文件 `/config/database.yml`
