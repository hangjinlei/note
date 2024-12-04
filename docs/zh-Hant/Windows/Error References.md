# Error References

## PowerShell

### 0x7FF80EC6E0A4

```plaintext
[0x7FF80EC6E0A4] ANOMALY: use of REX.w is meaningless (default operand size is 64)
```

`\HKEY_LOCAL_MACHINE\SOFTWARE\TEC\Ocular.3\agent\config` 下, 新建 [字符串值] `hookapi_disins`, 数值数据: `1`

## Windows Update

### 0x800F0954

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU`, 其中 `UseWUServer` 默认值为 `1`, 改成 `0`

Restart Windows Update Service
