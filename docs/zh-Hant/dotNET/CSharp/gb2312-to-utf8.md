# GB2312 to UTF8

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
