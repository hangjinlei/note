# 杀进程

## 查看端口占用

```powershell
netstat -ano
```

## 查看指定端口的占用情况

数字为端口号

```powershell
netstat -aon|findstr 8080
```

## 查看 PID 对应的进程

数字为 PID

```powershell
tasklist|findstr 5769
```

## 结束该进程

杀程序

```powershell
taskkill /f /t /im xxx.exe
```

杀 PID

```powershell
taskkill /f /PID 5769
```
