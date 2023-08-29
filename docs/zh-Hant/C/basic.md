# Basic of C Programing Language

## Data Types

```c
int b = 23;
float a = 1.1;
double c = 3.7;
char d = 'A';

char name[] = "timothy liu"; // string
int nums[] = {1, 2, 3}; // array
```

### const

```c
const int NUM = 10;
NUM = 11; /* can not be modify */
```

## Output and Input

### output

printf

```c
printf("%s %d %f","Timothy", "10", "10.0");
```

占位符说明

-   `%c` 字符
-   `%s` 字符串
-   `%d` int 型数字
-   `%f` double 型数字
-   `%p` Memory address

以下示例, 将会输出 10 位字符, 左对齐, 对于 double 型数据, 保留两位小数.

```c
printf("%-10.2f", 11.1111);
```

### input

scanf

```c
int age;
scanf_s("%d", &age);
```

占位符说明

-   `%c` 字符
-   `%s` 字符串,
-   `%d` int 型数字
-   `%lf` double 型数字

> 使用 scanf 读取字符时, 读取到空格就会结束
>
> ```c
> char name[20];
> scanf_s("%s", &name); // John Smith
> printf("%s", name); // John
> ```

> 一次读取多个值
>
> ```c
> char firstName[20];
> char lastName[20];
>
> scanf_s("%s %s", firstName, 20, lastName, 20);
> printf("Your name is %s %s", firstName, lastName);
> ```

fgets

```c
printf("Enter your name: ");
char name[20];
fgets(name, 20, stdin);
printf("Welcome %s\n", name);
```

> 使用 fgets 时会读取回车

## functions

### prototype

在 C 语言中，函数原型（function prototype）是在使用函数之前提供的函数声明，它描述了函数的名称、返回类型以及参数的类型和顺序。函数原型的目的是告诉编译器有关函数的信息，以便在函数被调用之前对其进行正确的类型检查。

函数原型通常位于函数定义之前，可以单独声明函数原型，也可以与函数定义结合在一起。函数原型的一般形式如下：
