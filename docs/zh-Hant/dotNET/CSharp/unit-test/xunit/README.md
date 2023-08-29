# xUnit

- [xUnit](#xunit)
  - [预备知识](#预备知识)
    - [测试三部分](#测试三部分)
  - [示例代码](#示例代码)

## 预备知识

### 测试三部分

- Arrange：这部分为输入输出声明和实例化变量
- Act：这部分执行想要测试的单元，意味着调用要测试的方法
- Assert：这部分对输出进行断言

## 示例代码

```csharp
public class CalculatorUnitTests
{
    [Fact]
    public void TestAdding2And2()
    {
        // arrange
        double a = 2;
        double b = 2;
        double expected = 4;
        var calc = new Calculator();

        // act
        double actual = calc.Add(a, b);

        //assert
        Assert.Equal(expected, actual);
    }

    [Fact]
    public void TestAdding2And3()
    {
        // arrange
        double a = 2;
        double b = 3;
        double expected = 5;
        var calc = new Calculator();

        // act
        double actual = calc.Add(a, b);

        //assert
        Assert.Equal(expected, actual);
    }
}
```
