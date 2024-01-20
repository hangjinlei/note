# Run PowerShell in .NET (C#)

```csharp
var path = @"";
var destination = @"";

PowerShell ps = PowerShell.Create();
ps.AddCommand("Copy-Item");
ps.AddParameter("Path", path);
ps.AddParameter("Destination", destination);
ps.AddParameter("Recurse", true);
ps.AddParameter("Force", true);

var results = ps.Invoke();
```
