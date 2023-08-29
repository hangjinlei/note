# 语言基础

## 5 种下划线

1. `_var`: 命名约定, 不影响程序, 仍旧可以被外部使用, 但是不建议从外部使用.
2. `__var`: 会影响程序, 无法被外部使用, 相当于 C#, Java 中被 private 修饰的变量
3. `__func__`: Python 语言内部使用
4. `var_`: 用于命名冲突时, 例如保留关键字
5. `_`: 弃元, 类似 C# 用法

## Check attribute or key

```python
hasattr()

"key" in {}
```

## UUID

```python
import uuid
str(uuid.uuid4())
```

## JSON

```python
import json
from enum import Enum


class Source(Enum):

    Cloud = 1
    Other = 2


class SourceEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Enum):
            return obj.value
        return json.JSONEncoder.default(self, obj)


class DevicePrintCount():
    @property
    def id(self):
        return self.__id

    @id.setter
    def id(self, value):
        self.__id = value

    @property
    def source(self):
        return self.__source

    @source.setter
    def source(self, value):
        self.__source = value


d = DevicePrintCount()
d.id = "1"
d.source = Source.Cloud

# 注意这里指定了编码器

json.dumps(d.__dict__, cls=SourceEncoder)


# 我有类似以上的代码，当我在执行时遇到了 Object of type Source is not JSON serializable
```

## System Path

```python
import sys

sys.path.append('..')
```

## Data Format

```python
import datetime
import json

date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
```

## Variables Name

```python
try:
    a = "aaaaaaaaaaa"
    print(locals()[a])
    raise Exception("test")
except Exception as e:
    message = (str(e))
    print(message)
```
