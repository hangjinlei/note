# 连接到 MySQL

## 安装步骤

1. 安装 MySQL
2. 安装 MySQL Connector
3. 安装 dbi `gem install dbi`
4. 安装 mysql2 `gem install mysql2`
   - 安装 `gem install mysql` 会失败, 不用管

## 连接到 MySQL

https://gihyo.jp/dev/serial/01/mysql-road-construction-news/0073

- 安装 mysql2 参考 `Mysql2Client`

  1. [下载 MySQL 8.0](https://www.mirrorservice.org/sites/ftp.mysql.com/Downloads/MySQL-8.0/)
  2. gem install dbi
  3. gem install mysql2

     1. `Error installing mysql2: ERROR: Failed to build gem native extension.` 解决方案
        - [Ruby MYSQL2 gem installation on windows 7 - Stack Overflow](https://stackoverflow.com/questions/19014117/ruby-mysql2-gem-installation-on-windows-7/19023107#19023107)
