## Program.cs

```csharp
using MatBlazor;
using Blazored.LocalStorage;

builder.Services.AddMatBlazor();
builder.Services.AddMatToaster();

builder.Services.AddBlazoredLocalStorage();
```

## Layout.cshtml

### BlazorAnimate

```cshtml
<script src="_content/BlazorAnimate/blazorAnimateInterop.js"></script>
```

### MatBlazor

```cshtml
<script src="_content/MatBlazor/dist/matBlazor.js"></script>
<link href="_content/MatBlazor/dist/matBlazor.css" rel="stylesheet" />
```

### \_Imports.razor

```csharp
@using BlazorAnimate;
@using MatBlazor;

@inject Blazored.LocalStorage.ILocalStorageService localStorage
```
