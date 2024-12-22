# ASP.NET Core

## 内置服务器

Kestrel

## 常用环境变量

ASPNETCORE_ENVIRONMENT

```plaintext
Development
Staging
Production
Integration
Testing
QA
UAT // 用户验收测试
```

## 配置文件 `appsettings.json`

[配置文件读取顺序](https://github.com/dotnet/runtime/blob/main/src/libraries/Microsoft.Extensions.Hosting/src/HostingHostBuilderExtensions.cs#L175-L193)

```plaintext
appsettings.json
appsettings.{Environment}.json
User Secret
Environment Variables
Command Line arguments
```

## CLI

```plaintext
dotnet ./app.dll --urls="http://*:80"
```

## 特殊的依赖注入

-   IRazorViewEngine
-   ITempDataProvider
-   IActionContextAccessor

## 高级内容

-   [在 ASP.NET Core 中强制使用 HTTPS](https://learn.microsoft.com/zh-cn/aspnet/core/security/enforcing-ssl)
-   [ASP.NET Core 中的模型绑定](https://learn.microsoft.com/en-us/aspnet/core/mvc/models/model-binding)
-   [Custom Model Binding in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/mvc/advanced/custom-model-binding)
-   [Model validation in ASP.NET Core MVC and Razor Pages](https://learn.microsoft.com/en-us/aspnet/core/mvc/models/validation)

### 访问 HttpContext

ControllerBase 类中已经有 HttpContext 属性, 若需要在自定义 Service 中使用, 则需要在 Services 中注入 [IHttpContextAccessor](https://docs.microsoft.com/zh-cn/dotnet/api/microsoft.aspnetcore.http.ihttpcontextaccessor)

## ASP.NET Core with Angular

修改 csproj 文件, 添加 FrontendRoot 属性, 用于指定前端项目的根目录, 并添加 BuildAngular Target, 用于在编译时构建 Angular 项目, 并将构建结果复制到 wwwroot 目录

```diff
 <Project Sdk="Microsoft.NET.Sdk.Web">

   <PropertyGroup>
     <TargetFramework>net9.0</TargetFramework>
     <Nullable>enable</Nullable>
     <ImplicitUsings>enable</ImplicitUsings>
+    <FrontendRoot>frontend</FrontendRoot>
   </PropertyGroup>

   <ItemGroup>
     <PackageReference Include="Swashbuckle.AspNetCore" />
   </ItemGroup>

+  <ItemGroup>
+    <Folder Include="wwwroot\" />
+  </ItemGroup>
+
+  <Target Name="BuildAngular" BeforeTargets="Build">
+    <Exec Command="npm install" WorkingDirectory="$(FrontendRoot)" />
+    <Exec Command="npm run build" WorkingDirectory="$(FrontendRoot)" />
+
+    <!-- 复制文件到 wwwroot -->
+    <ItemGroup>
+      <AngularFiles Include="$(FrontendRoot)\dist\**" />
+    </ItemGroup>
+    <Copy SourceFiles="@(AngularFiles)" DestinationFolder="$(ProjectDir)wwwroot\" />
+  </Target>

 </Project>
```

## ASP.NET Core with Material Web

[Quick start](https://material-web.dev/about/quick-start/)

https://stackoverflow.com/questions/79279047/why-does-asp-net-core-9-strip-out-importmap

```cshtml
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
@{
	var data = new Microsoft.AspNetCore.Components.ImportMapDefinition(
		new Dictionary<string, string>
		{
			{ "@material/web/", "https://esm.run/@material/web/" },
		}, null, null);
}
<script type="importmap" asp-importmap="@data">
	{
	  "imports": {
		"@@material/web/": "https://esm.run/@@material/web/"
	  }
	}
</script>
<script type="module">
	import '@@material/web/all.js';
	import {styles as typescaleStyles} from '@@material/web/typography/md-typescale-styles.js';

	document.adoptedStyleSheets.push(typescaleStyles.styleSheet);
</script>
```
