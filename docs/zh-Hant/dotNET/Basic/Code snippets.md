# Code snippets

## GB2312 to UTF 8

```csharp
using (StreamReader sr = new StreamReader(infile, Encoding.GetEncoding(936)))
{
    using (StreamWriter sw = new StreamWriter(outfile, false, Encoding.UTF8))
    {
        sw.Write(sr.ReadToEnd());
        sw.Close();
    }
    sr.Close();
}
```

## 用户定义的显式和隐式转换运算符

[Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/user-defined-conversion-operators)

```csharp
public readonly struct Digit
{
    private readonly byte digit;

    public Digit(byte digit)
    {
        if (digit > 9)
        {
            throw new ArgumentOutOfRangeException(nameof(digit), "Digit cannot be greater than nine.");
        }
        this.digit = digit;
    }

    public static implicit operator byte(Digit d) => d.digit;
    public static explicit operator Digit(byte b) => new Digit(b);

    public override string ToString() => $"{digit}";
}

public static class UserDefinedConversions
{
    public static void Main()
    {
        var d = new Digit(7);

        byte number = d;
        Console.WriteLine(number);  // output: 7

        Digit digit = (Digit)number;
        Console.WriteLine(digit);  // output: 7
    }
}
```
