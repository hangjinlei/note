# 面向对象编程

## 类

### 构造函数

```python
class Employee:
    def __init__(self, first: str, last: str, pay: str) -> None:
            assert pay > 0

            self.first = first
            self.last = last
            self.pay = pay
            self.email = first + "." + last + "@company.com"
```

以上代码中

- `assert` 被用于对数据进行校验
- `self.first` 等被用于对 attribute 进行赋值, 与 C#, Java 中字段概念相似, 区别在于 Python 中, 无需显式定义字段

### 静态变量

```python
class Employee:
    num_of_emps: int = 0

    def __init__(self, first: str, last: str, pay: str) -> None:
        Employee.num_of_emps += 1
```

以上代码中

`num_of_emps` 声明为静态变量, 静态变量属于类, 可以通过 `Employee.num_of_emps` 访问

但是在 Python 中, 静态变量也可以通过实例对象访问, 因为在 Python 中, 当通过实例对象访问时, 首先会查找实例对象是否具有此 attribute, 如果没有, 就会向上查找类中的变量

### 属性

当希望在外部获取 attribute 时, 动态计算值, 或需要对 attribute 的修改作出限制, 则可以使用 `@property`

```python
class Employee:
    def __init__(self, first: str, last: str, pay: str) -> None:
            assert pay > 0

            self.first = first
            self.last = last
            self.pay = pay
            # self.email = first + "." + last + "@company.com"

    @property
    def email(self):
        return "{}.{}@company.com".format(self.first, self.last)

    @property
    def fullname(self):
        return "{} {}".format(self.first, self.last)

    @fullname.setter
    def fullname(self, name: str):
        first, last = name.split(" ")
        self.first = first
        self.last = last
```

以上代码中

- `email` 和 `fullname` 的 `@property` 被定义用于对访问做出控制, 动态计算值返回
- `fullname` 的 `@fullname.setter` 被定义用于对修改做出控制

### 类方法

### 实例方法

### 静态方法

### 特殊的方法

```python
class Employee:
    def __init__(self, first: str, last: str, pay: str) -> None:
        self.first = first
        self.last = last
        self.pay = pay
        self.email = first + "." + last + "@company.com"

    def __repr__(self):
        return "{}('{}', '{}', '{}')".format(self.__class__.__name__, self.first, self.last, self.pay)

    def __str__(self):
        return "{} - {}".format(self.fullname, self.email)

    def __add__(self, other):
        return self.pay + other.pay
```

以上代码中

- `__init__` 被用来对对象初始化
- `__repr__` 和 `__str__` 被用来打印信息, `__repr__` 被建议用来 debug, 而 `__str__` 被建议用来向用户输出
- `__add__` 被用来对运算符 `+` 进行重载

```python
from datetime import datetime

class Employee:

    def raise_amount(self):  # instance method
        self.pay = int(self.pay * self.raise_amnt)

    @classmethod
    def set_raise_amt(cls, amount: int):  # class method
        cls.raise_amnt = amount

    @classmethod
    def from_string(cls, emp_str: str):  # class method
        first, last, pay = emp_str.split("-")
        return cls(first, last, float(pay))

    @staticmethod
    def is_workday(day: datetime) -> bool:
        if day.weekday() == 5 or day.weekday() == 6:
            return False
        return True
```
