# Deploy to GitHub Pages

Version: dotnet 9.0

```powershell
dotnet workload install wasm-tools
```

```powershell
dotnet publish -c Release
```

```powershell
cp .\BlazorApp\bin\Release\net9.0\publish\wwwroot\* .\docs\ -Recurse
```

change base href in index.html from `<base href="/" />` to `<base href="./" />`

```powershell
cp .\docs\index.html .\docs\404.html
```

```powershell
New-Item .\docs\.nojekyll -ItemType File
```
