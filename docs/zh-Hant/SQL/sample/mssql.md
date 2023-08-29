# Microsoft SQL Server

## SQL Server

### Database

#### Create

```plaintext
以下示例

创建一个名为 `StudentManageDB` 的主数据库
数据库保存在本地磁盘 `D:\Database\StudentManageDB.mdf`
数据库的初始大小为 `5 MB`, 最大为 `100 MB`
数据库容量增长为每次 `5 MB`.

创建一个名为 `StudentManageDB_log` 的日志数据库
数据库保存在本地磁盘 `D:\Database\StudentManageDB_log.ldf`
数据库的初始大小为 `1 MB`, 无最大上限
数据库容量增长为每次 `10 %`.
```

```sql
create database StudentManageDB
on
(
	name='StudentManageDB',
	filename='D:\Database\StudentManageDB.mdf',
	size=5mb,
	maxsize=100mb,
	filegrowth=5mb
)

log on
(
	name='StudentManageDB_log',
	filename='D:\Database\StudentManageDB_log.ldf',
	size=1mb,
	maxsize=unlimited,
	filegrowth=10%
)
GO
```

#### Drop

```sql
drop database StudentManageDB
```

#### Inspect

```sql
sp_helpdb StudentManageDB
```

### Table

```sql
/*
	数据完整性
		实体完整性（Primary Key、UNIQUE（可以有多个））
		参照完整性（Foreign Key）
		域完整性（Check、Default、默认值对象、规则）
*/

```

#### Create

```sql
create table Student
(
	Stu_Id char(10) not null, -- 学号
	Stu_Name varchar(20) not null, -- 姓名
	Stu_Sex char(2) default '女', -- 性别, Default约束, 域完整性
	Stu_Birthday date, -- 出生日期
	Stu_MCCP bit, -- 是否党员
	Stu_EnterScore int, -- 入学成绩
	Stu_Major varchar(20), -- 专业
	Stu_NativePlace varchar(10), -- 籍贯
	Stu_Subsidy money, -- 补助
	Stu_Remark varchar(50), -- 备注
	constraint PK_Student primary key (Stu_Id asc), -- 主键, 实体完整性
	constraint CK_Sex check (Stu_Sex='男' or Stu_Sex='女') -- check约束, 域完整性
)
GO

create table Course
(
	Cour_Id char(5) not null, -- 课程编号
	Cour_Name varchar(20) not null, -- 课程名称
	Cour_Credit tinyint, -- 学分
	Cour_Period smallint, -- 学时
	constraint PK_Course primary key (Cour_Id), -- 主键, 实体完整性
	constraint UQ_Course_CourName UNIQUE (Cour_Name) -- UNIQUE（可以有多个）约束, 实体完整性
)
GO

create table SC_result
(
	Stu_Id char(10) not null, -- 学号
	Cour_Id char(5) not null, -- 课程编号
	Score int, -- 考试成绩
	constraint PK_Student_Result primary key (Stu_Id, Cour_Id), -- 主键, 实体完整性
	constraint FK_Result_Student foreign key (Stu_Id) references Student (Stu_Id), -- 外键, 参照完整性
	constraint FK_Result_Course foreign key (Cour_Id) references Course (Cour_Id), -- 外键, 参照完整性
	constraint CK_Score check (Score >= 0 and Score <= 100) -- Check约束, 域完整性
)
GO
```

#### Inspect

```sql
sp_help Course
```

#### Alter

```sql
alter table Student
add Stu_Phone char(12)

alter table Student
alter column Stu_Phone char(11)

alter table Student
drop column Stu_Phone
```

#### Drop

```sql
drop table SC_result
drop table Student
drop table Course
```

```sql
-- 添加主键, 实体完整性
alter table Student
add constraint PK_Student primary key (Stu_Id)

alter table SC_result
add constraint PK_Student_Result primary key (Stu_Id, Cour_Id)

alter table Course
add constraint PK_Course primary key (Cour_Id)

-- 删除主键, 实体完整性
alter table Student
drop constraint PK_Student

alter table SC_result
drop constraint PK_Student_Result

alter table Course
drop constraint PK_Course

-- 创建UNIQUE（可以有多个）约束, 实体完整性
alter table Course
add constraint UQ_Course_CourName UNIQUE (Cour_Name)

-- 删除UNIQUE（可以有多个）约束, 实体完整性
alter table Course
drop constraint UQ_Course_CourName

-- 创建外键, 参照完整性
alter table SC_result
add constraint FK_Result_Student foreign key (Stu_Id) references Student (Stu_Id)

alter table SC_result
add constraint FK_Result_Course foreign key (Cour_Id) references Course (Cour_Id)

-- 删除外键, 参照完整性
alter table SC_result
drop constraint FK_Result_Student

alter table SC_result
drop constraint FK_Result_Course

-- 创建Check约束, 域完整性
alter table Student
add constraint CK_Sex check (Stu_Sex='男' or Stu_Sex='女')

alter table SC_result
add constraint CK_Score check (Score >= 0 and Score <= 100)

-- 删除Check约束, 域完整性
alter table Student
drop constraint CK_Sex

alter table SC_result
drop constraint CK_Score

-- 创建Default约束, 域完整性
alter table Student
add constraint DF_Sex default '女' for Stu_Sex

-- 删除Default约束, 域完整性
alter table Student
drop constraint DF_Sex

-- 创建默认值对象
GO
create default default_subsidy as 300

-- 绑定默认值对象到列
exec sp_bindefault 'default_subsidy', 'Student.Stu_Subsidy'

-- 解绑默认值对象
exec sp_unbindefault 'Student.Stu_Subsidy'

-- 删除默认值对象
drop default default_subsidy

-- 创建规则
GO
create rule rule_enterscore as @enterscore >= 0 and @enterscore <=700

-- 绑定规则到列
exec sp_bindrule 'rule_enterscore', 'Student.Stu_EnterScore'

-- 解绑规则
exec sp_unbindrule 'Student.Stu_EnterScore'

-- 删除规则
drop rule rule_enterscore
```

### Query

#### Insert

```sql
insert into Student (Stu_Id, Stu_Name, Stu_Sex, Stu_Birthday, Stu_MCCP, Stu_EnterScore, Stu_Major, Stu_NativePlace, Stu_Subsidy, Stu_Remark)
values
('S201410101', '肖韦', '女', '1996-08-07', '1', '516', '计算机信息管理', '北京', '200', null),
('S201410102', '赵非', '女', '1996-11-06', '0', '582', '计算机信息管理', '上海', '200', null),
('S201410201', '钱泽', '男', '1995-01-02', '1', '467', '计算机信息管理', '山西', '200', null),
('S201410202', '王倩倩', '女', '1995-12-29', '0', '530', '计算机信息管理', '云南', '200', null),
('S201420101', '李威', '男', '1997-02-08', '0', '512', '电子商务', '北京', '200', null),
('S201420202', '张璐', '女', '1996-05-03', '1', '530', '电子商务', '福建', '200', null),
('S201430103', '马驰', '男', '1996-09-10', '0', '560', '软件工程', '陕西', '200', null),
('S201440401', '上官玲', '女', '1996-10-21', '0', '457', '市场营销', '山东', '200', null),
('S201440402', '赵非', '男', '1995-02-09', '1', '502', '市场营销', '上海', '200', null),
('S201510101', '孙鑫', default, '1996-07-07', '0', '519', '计算机信息管理', '山西', '200', null)

insert into Student (Stu_Id, Stu_Name) values
('S201430104', '李林林'),
('S201430105', '秦璐')

insert into Course (Cour_Id, Cour_Name, Cour_Credit, Cour_Period) values
('C1001', '数据结构', 3, 48),
('C1011', '高等数学', 4, 64),
('C1021', '大学英语', 4, 64),
('C1031', '马克思理论', 2, 32),
('C1041', '计算机应用基础', 3, 48),
('C1051', '计算机网络', 4, 64)

insert into SC_result (Stu_Id, Cour_Id, Score) values
('S201410101', 'C1021', 90),
('S201410101', 'C1031', 80),
('S201410102', 'C1041', 98),
('S201410102', 'C1051', 56),
('S201410201', 'C1011', 85),
('S201410201', 'C1021', 100),
('S201410201', 'C1041', 83),
('S201420202', 'C1031', 95)

```

#### Update

```sql
update Student set Stu_Name = '李小林' where Stu_Name = '李林林'
update Student set Stu_Sex = '男' where Stu_Id = 'S201510101'
update Student set Stu_NativePlace = '山西', Stu_Remark = '三好学生' where Stu_Name = '李小林'
update Student set Stu_Subsidy += 100
```

#### Delete

```sql
delete from SC_result
delete from Student
delete from Course
delete from Student where Stu_Name = '李小林'
```

### Query

```sql
/*
简单查询
	不带条件的查询（查询所有列的信息、查询部分列的信息、设置列别名、消除结果集中的重复行distinct）
	带条件的查询（比较运算符、逻辑运算符、空值判断、范围判断、模糊查询）
	查询结果的排序（order by）
	查询结果的分组统计（统计函数、分组统计group by、对分组统计结果的筛选having）
	由查询结果生成新表（select * into tableNameNew from tableNameOld）新表可以不存在
	查询结果的集合运算（并union、交intersect、差except）
多表连接查询
	内连接查询（inner join ... on ...）
		特殊的：自连接查询
	外连接查询（left outer join、right outer join、full outer join）
		left outer join：包含左侧表的全部及右侧表符合条件的项目
		right outer join：包含右侧表的全部及左侧表符合条件的项目
		full outer join：
	交叉连接查询（cross join）：返回笛卡儿积
子查询
	无关子查询
		若子查询的结果是单个值：=、<、>、<>、<=、>=、!=、!<、!>
		若子查询的结果是多个值：in、all、any
	相关子查询
		exists、not exists
	带有子查询的数据更新语句
		带有子查询的insert语句（被插入的表必须存在）
		带有子查询的update语句
		带有子查询的delete语句
*/

-- 查询所有列
select * from Student

-- 查询部分列
select Stu_Id, Stu_Name, Stu_Sex, Stu_Birthday, Stu_NativePlace from Student

-- 查询计算值
select Stu_Id as 学号, Stu_Name as 姓名, YEAR(GETDATE())-YEAR(Stu_Birthday) as 年龄 from Student

-- 去除重复行, distinct
select distinct Stu_Major from Student

-- 查询前3行, top n
select top 3 * from Student

-- 查询前50%行, top n percent
select top 50 percent Stu_Id, Stu_Name, Stu_Sex, Stu_Major from Student

-- 查询前50%行, 结尾包含并列项, top n with ties, order by
select top 50 percent with ties Stu_Id, Stu_Name, Stu_Sex, Stu_Major from Student order by Stu_Id

-- 比较运算符, =、<、>、<>、<=、>=、!=、!<、!>
select Stu_Name, Stu_EnterScore, Stu_NativePlace from Student where Stu_EnterScore >= 530
select Stu_Id, Stu_Name, Stu_Major from Student where Stu_Major <> '计算机信息管理'

-- 逻辑运算符, not、and、or
select * from Student where Stu_Major = '计算机信息管理' and Stu_Sex = '女'
select Stu_Id, Stu_Name, Stu_EnterScore, Stu_NativePlace from Student where Stu_NativePlace = '北京' or Stu_NativePlace = '上海'

-- 空值判断, is null
select * from Student where Stu_Birthday is null

-- 范围判断, between ... and ...、in (...)
select * from Student where Stu_Birthday between '1995-01-01' and '1995-12-31'
select * from Student where Stu_Major in ('软件工程', '电子商务')

-- 模糊查询
-- %：任意多个
-- _：任意一个
-- [...]：任意一个
-- [^...]：任意一个不在
select Stu_Id, Stu_Name, Stu_Sex, Stu_Major from Student where Stu_Name like '赵%'
select Stu_Id, Stu_Name, Stu_Major, Stu_EnterScore from Student where Stu_Id like 'S2014[34]0%'

-- 查询结果排序, asc、desc、with ties
select * from Student where Stu_Major = '计算机信息管理' order by Stu_Id, Stu_Birthday desc
select top 3 Stu_Id, Stu_Name, Stu_EnterScore, Stu_Major from Student order by Stu_EnterScore desc
select top 3 with ties Stu_Id, Stu_Name, Stu_EnterScore, Stu_Major from Student order by Stu_EnterScore desc

-- 统计函数, count、avg、sum、max、min、distinct
select count(*) as 人数 from Student
select count(distinct Stu_NativePlace) as 籍贯数目 from Student
select sum(Score) as 总分, avg(Score) as 平均分, max(Score) as 最高分, min(Score) as 最低分 from SC_result where Stu_Id = 'S201410201'

-- 分组统计, group by
select Stu_Major, count(*) as 人数 from Student group by Stu_Major
select Stu_Id, avg(Score) as 平均分 from SC_result group by Stu_Id

-- 对分组统计结果的筛选, group by、having
select Stu_Id, avg(Score) as 平均分 from SC_result group by Stu_Id having avg(Score) > 85
select Stu_Major, count(*) as 人数 from Student where Stu_EnterScore >= 500 group by Stu_Major having count(*) > 1

-- 由查询结果生成新表, into
select * into S1 from Student where Stu_Major = '市场营销'
select * from S1
drop table S1

-- 集合并运算, union
select Stu_Id from SC_result where Cour_Id = 'C1021'
union
select Stu_Id from SC_result where Cour_Id = 'C1031'

-- 集合交运算, intersect
select Stu_Id from SC_result where Cour_Id = 'C1021'
intersect
select Stu_Id from SC_result where Cour_Id = 'C1031'

-- 集合差运算, except
select Stu_Id from SC_result where Cour_Id = 'C1021'
except
select Stu_Id from SC_result where Cour_Id = 'C1031'

-- 内连接查询（inner join ... on ...）
select Student.*, SC_result.* from Student inner join SC_result on Student.Stu_Id = SC_result.Stu_Id
select Student.Stu_Id, Stu_Name, Stu_Sex, Course.Cour_Id, Cour_Name, Score from Student inner join SC_result on Student.Stu_Id = SC_result.Stu_Id inner join Course on SC_result.Cour_Id = Course.Cour_Id where Stu_Sex = '女'
-- 常规查询
select Student.*, SC_result.* from Student, SC_result where Student.Stu_Id = SC_result.Stu_Id
select Student.Stu_Id, Stu_Name, Stu_Sex, Course.Cour_Id, Cour_Name, Score from Student, SC_result, Course where Student.Stu_Id = SC_result.Stu_Id and SC_result.Cour_Id = Course.Cour_Id and Stu_Sex = '女'
-- 自连接查询
select A.Stu_Id, A.Cour_Id, A.Score, B.Stu_Id, B.Cour_Id, B.Score from SC_result as A inner join SC_result as B on A.Cour_Id = B.Cour_Id where A.Stu_Id = 'S201410101' and B.Stu_Id = 'S201410201'
-- 常规查询
select A.Stu_Id, A.Cour_Id, A.Score, B.Stu_Id, B.Cour_Id, B.Score from SC_result as A, SC_result as B where A.Cour_Id = B.Cour_Id and A.Stu_Id = 'S201410101' and B.Stu_Id = 'S201410201'

-- 外连接查询（left outer join、right outer join、full outer join）
select Student.Stu_Id, Stu_Name, Cour_Id, Score from Student left outer join SC_result on Student.Stu_Id = SC_result.Stu_Id
select Student.Stu_Id, Stu_Name, Cour_Id, Score from SC_result right outer join Student on Student.Stu_Id = SC_result.Stu_Id
-- 常规查询
-- 想不出

-- 交叉连接查询（cross join）
select Stu_Id, Stu_Name, Cour_Id, Cour_Name from Student cross join Course

-- 无关子查询
select * from Student where Stu_Major = (select Stu_Major from Student where Stu_Id = 'S201410101')
select * from SC_result where Stu_Id  in (select Stu_Id from Student where Stu_Major = '计算机信息管理')
select Stu_Id, Stu_Name, Stu_Sex, Stu_Major from Student where Stu_Id not in (select Stu_Id from SC_result)
select * from Student where Stu_EnterScore > all (select Stu_EnterScore from Student where Stu_Major = '电子商务')
select * from SC_result where Score > any (select Score from SC_result where Stu_Id = 'S201410101')

-- 相关子查询
select Stu_Id, Stu_Name, Stu_Major from Student where (select count(*) from SC_result where Stu_Id = Student.Stu_Id) > 1
select * from Student where exists (select * from SC_result where Stu_Id = Student.Stu_Id)

-- 带有子查询的insert语句（被插入的表必须存在）
insert into S1 select * from Student where Stu_Major = '电子商务'
insert into S1 (Stu_Id, Stu_Name, Stu_Major) select Stu_Id, Stu_Name, Stu_Major from Student where Stu_Major = '软件工程'

-- 带有子查询的update语句
update SC_result set score +=3 where Stu_Id = (select Stu_Id from Student where Stu_Major = '电子商务' and Stu_Name = '张璐')
update SC_result set score +=3 from Student inner join SC_result on Student.Stu_Id = SC_result.Stu_Id where Stu_Major = '电子商务' and Stu_Name = '张璐'

-- 带有子查询的delete语句
delete from SC_result where Stu_Id = (select Stu_Id from Student where Stu_Major = '电子商务' and Stu_Name = '张璐')
delete from SC_result from SC_result inner join Student on SC_result.Stu_Id = Student.Stu_Id where Stu_Major = '电子商务' and Stu_Name = '张璐'
```

### Programmability

#### Variable

```sql
-- 定义变量
declare @x int, @y int

-- 变量赋值
set @x =5
set @y =28

-- 输出变量
print @x
print @y
print @x + @y
select @x + @y

-- 如果查询的结果返回多个值, 仅将最后一个值赋值给变量
declare @name char(20), @sex char(2)
select @name = Stu_Name, @sex = Stu_Sex from Student where Stu_Id = 'S201410101'
select @name, @sex

```

#### Built-in function

```sql
/*
	统计函数, count、avg、sum、max、min
	数学函数, abs、ceiling、floor、power、round、square、sqrt
	字符串函数, char、charindex、left、len、lower、ltrim、right、rtrim、upper、substring、str
	日期时间函数, getdate、year、month、day、datepart、dateadd、datediff
	转换函数, cast、convert
	系统函数, user_name、host_name、db_name、system_user
*/

-- 数学函数
declare @r float
set @r = 3.5
print '圆的面积 = ' + str(3.14 * power(@r, 2), 5, 2)

-- 字符串函数
declare @id char(18)
set @id = '110108200812053689'
print '出生日期：' + substring(@id, 7, 4) + '年' + substring(@id, 11, 2) + '月' + substring(@id, 13, 2) + '日'

-- 日期时间函数
select Stu_Id, Stu_Name, year(GETDATE()) - year(Stu_Birthday) as Age from Student where Stu_Name = '肖韦'

-- 转换函数, cast、convert
print '字符：' + convert(char(2), 18)
print '字符：' + cast(18 as char(2))

-- 系统函数

```

#### Statements

```sql
/*
流程控制语句
	begin ... end
	if ... else
	case（简单case语句、搜索case语句）
	while
*/

-- begin ... end
-- if ... else
declare @n int
select @n = count(*) from Student where Stu_Sex = '男'
if (@n > 0)
	begin
		print '男同学的人数：' + str(@n, 2) + '.'
	end
else
	print 'Student 表中没有男同学信息!'

-- 简单case 语句
select Stu_Name as 姓名, 性别 =
	case Stu_Sex
		when '男' then '他是男同学'
		when '女' then '她是女同学'
	end
from Student

-- 搜索case 语句
select Stu_Name as 姓名, Stu_EnterScore as 入学成绩, 成绩级别 =
	case
		when Stu_EnterScore >= 560 then 'A'
		when Stu_EnterScore >= 530 then 'B'
		when Stu_EnterScore >= 500 then 'C'
		when Stu_EnterScore >= 460 then 'D'
		else 'E'
	end
from Student

-- while
declare @i tinyint, @s int
set @i = 1
set @s = 0
while @i <= 100
	begin
		if @i % 2 != 0
			set @s = @s + @i
		set @i += 1
	end
print @s


/*
事务
*/
declare @n int
set @n =0
begin transaction tran1
	delete from Student where Stu_Id = 'S201410101'
	set @n += @@ERROR
	delete from SC_result where Stu_Id = 'S201410101'
	set @n += @@ERROR
	if @n = 0
		commit transaction
	else
		begin
			print '删除数据失败'
			rollback transaction
		end
```

### View and index

```sql
/*
order by 子句必须搭配top 100 percent 使用
*/

-- 创建视图
create view BeijingStu
as
select top 100 percent Stu_Id as 学号, Stu_Name, Stu_Sex, Stu_EnterScore, Stu_Major from Student
where Stu_NativePlace = '北京'
order by Stu_EnterScore asc

create view Subsidy_view (学号, 姓名, 补助金额)
as
select Stu_Id, Stu_Name, Stu_Subsidy from Student

create view Score_view
as
select Student.Stu_Id as 学号, Stu_Name as 姓名, Stu_Major as 专业, Cour_Name as 课程, Score as 成绩 from Student
inner join SC_result on Student.Stu_Id = SC_result.Stu_Id
inner join Course on SC_result.Cour_Id = Course.Cour_Id

create view Credit_view
as
select Student.Stu_Id as 学号, Stu_Name as 姓名, COUNT(*) as 修课数, sum(Cour_Credit) as 学分数
from Student
inner join SC_result on Student.Stu_Id = SC_result.Stu_Id
inner join Course on SC_result.Cour_Id = Course.Cour_Id
group by Student.Stu_Id, Stu_Name

create view NonCredit_view
as
select Student.Stu_Id as 学号, Stu_Name as 姓名, Stu_Major as 专业 from Student
left join Credit_view on Student.Stu_Id = Credit_view.学号
where Credit_view.学号 is null

-- 查询视图
select * from Subsidy_view
select * from Score_view
select * from Credit_view
select * from NonCredit_view

select * from Student where Stu_Id not in (select Stu_Id from SC_result)


-- 插入数据
create view Student_view (学号, 姓名, 入学成绩, 籍贯)
as
select Stu_Id, Stu_Name, Stu_EnterScore, Stu_NativePlace from Student
insert into Student_view values ('S201420208', '张三', '480', '云南')

-- 更新数据
update Student_view set 入学成绩 = 504 where 姓名 = '张三'
select * from Student

-- 删除数据
delete from Student_view where 姓名 = '张三'
select * from Student


-- 修改视图
alter view BeijingStu
as
select Stu_Id, Stu_Name, Stu_Sex, Stu_EnterScore, Stu_Major, Stu_NativePlace from Student

select * from BeijingStu

-- 删除视图
drop view Credit_view, NonCredit_view


/*
索引
*/
```

### Procedure

#### Create

```sql
create procedure msgstudent_proc1
@name varchar(20), @id_num char(10) output
as
select @id_num = Stu_Id from Student where Stu_Name = @name

create procedure msgstudent_proc2
@name varchar(20) = '钱泽'
with encryption -- 加密, 禁止他人查看和修改
as
select Student.Stu_Id, Stu_Name, Course.Cour_Id, Cour_Name, Score from Student
inner join SC_result on Student.Stu_Id = SC_result.Stu_Id
inner join Course on SC_result.Cour_Id = Course.Cour_Id
where Stu_Name = @name
```

#### Run

```sql
declare @name varchar(20), @id_num char(10)
set @name = '李威'
execute msgstudent_proc1 @name, @id_num output
select @name as 学生姓名, @id_num as 学生学号

execute msgstudent_proc2 '肖韦'
```

#### Alter

```sql
alter procedure msgstudent_proc1
@name varchar(20), @id_num char(10) output
with encryption
as
select @id_num = Stu_Id from Student where Stu_Name = @name

alter procedure msgstudent_proc2
@major varchar(20) = '计算机信息管理'
as
select Student.Stu_Id, Stu_Name, Course.Cour_Id, Cour_Name, Score from Student
inner join SC_result on Student.Stu_Id = SC_result.Stu_Id
inner join Course on SC_result.Cour_Id = Course.Cour_Id
where Stu_Major = @major
```

#### Drop

```sql
drop procedure msgstudent_proc1
drop procedure msgstudent_proc2
```
