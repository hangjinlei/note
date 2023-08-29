# Common

```json
{
    "diffEditor.renderSideBySide": false,
    "editor.accessibilitySupport": "on",
    "editor.formatOnPaste": true,
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.inlineSuggest.enabled": true,
    "editor.linkedEditing": true,
    "editor.rulers": [120],
    "editor.unicodeHighlight.nonBasicASCII": false,
    "files.autoSave": "onFocusChange",
    "files.insertFinalNewline": true,
    "files.trimTrailingWhitespace": true,
    "git.ignoreRebaseWarning": true,
    "window.commandCenter": true,
    "window.menuBarVisibility": "classic",
    "workbench.sideBar.location": "right",
    "workbench.colorTheme": "Default Light Modern"
}
```

## Python

```json
{
    "python.formatting.autopep8Args": ["--ignore", "E402"] // E402 module level import not at top of file
}
```

## MSSQL

```json
{
    "mssql.connections": [
        {
            "server": "localhost,1433",
            "database": "",
            "authenticationType": "SqlLogin",
            "user": "sa",
            "password": "",
            "emptyPasswordInput": false,
            "savePassword": false,
            "profileName": "mssql-container",
            "encrypt": "Mandatory",
            "trustServerCertificate": true
        }
    ]
}
```
