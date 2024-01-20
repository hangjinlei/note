# Win UI

## 支持 .NET 8

- [[Breaking change]: Projects targeting .NET 8 and higher will by default use a smaller, portable RID graph.](https://github.com/dotnet/docs/issues/36527)
- [Stable channel release notes for the Windows App SDK - Known issues](https://learn.microsoft.com/en-us/windows/apps/windows-app-sdk/stable-channel#known-issues)

从项目模版创建的项目目标框架为 .NET 6, 因此需要修改项目文件将目标框架升级为 .NET 8

```diff
 <OutputType>WinExe</OutputType>
-<TargetFramework>net6.0-windows10.0.19041.0</TargetFramework>
+<TargetFramework>net8.0-windows10.0.19041.0</TargetFramework>
 <TargetPlatformMinVersion>10.0.17763.0</TargetPlatformMinVersion>
 <RootNamespace>App1</RootNamespace>
 <ApplicationManifest>app.manifest</ApplicationManifest>
 <Platforms>x86;x64;ARM64</Platforms>
-<RuntimeIdentifiers>win10-x86;win10-x64;win10-arm64</RuntimeIdentifiers>
-<PublishProfile>win10-$(Platform).pubxml</PublishProfile>
+<RuntimeIdentifiers>win-x86;win-x64;win-arm64</RuntimeIdentifiers>
+<PublishProfile>win10-$(Platform).pubxml</PublishProfile>
+<UseRidGraph>true</UseRidGraph>
 <UseWinUI>true</UseWinUI>
 <EnableMsixTooling>true</EnableMsixTooling>
```
