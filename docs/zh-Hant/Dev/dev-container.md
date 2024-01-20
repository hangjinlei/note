# Dev Container

## References

-   [VS Code Remote / GitHub Codespaces Development Container Images](https://hub.docker.com/_/microsoft-vscode-devcontainers)
-   [Json Reference](https://containers.dev/implementors/json_reference/)
-   https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-sql-server-encryption?view=sql-server-ver16#sql-server-generated-self-signed-certificates
-   https://learn.microsoft.com/en-us/sql/tools/visual-studio-code/sql-server-develop-use-vscode?view=sql-server-ver16#encrypt-and-trust-server-certificate
-   https://github.com/Microsoft/vscode-mssql/wiki/manage-connection-profiles#edit-connections-in-the-user-settings-file

## Template

```json
{
    "name": "Node.js & TypeScript",
    "image": "mcr.microsoft.com/devcontainers/typescript-node:16-bullseye",
    "remoteUser": "node",
    "waitFor": "onCreateCommand",
    "updateContentCommand": "npm install",
    "postCreateCommand": "",
    "postAttachCommand": {
        "server": "npm start"
    },
    "customizations": {
        "codespaces": {
            "openFiles": ["index.js"]
        },
        "vscode": {
            "extensions": [],
            "settings": {}
        }
    },
    "portsAttributes": {
        "3000": {
            "label": "Application",
            "onAutoForward": "openPreview"
        }
    },
    "forwardPorts": [3000]
}
```

## Extensions

```json
{
    "extensions": [
        // Microsoft
        "ms-dotnettools.csdevkit",
        "ms-dotnettools.vscode-dotnet-pack",
        "ms-dotnettools.vscode-dotnet-runtime",
        "ms-dotnettools.vscodeintellicode-csharp",
        "ms-vscode.azure-repos",
        "ms-vscode.live-server",
        "ms-vscode-remote.vscode-remote-extensionpack",
        "ms-vscode.remote-explorer",
        "ms-vscode.remote-repositories",
        "ms-vscode.vs-keybindings",
        "ms-vsliveshare.vsliveshare",
        // IntelliSense
        "visualstudioexptteam.intellicode-api-usage-examples",
        "visualstudioexptteam.vscodeintellicode",
        "visualstudioexptteam.vscodeintellicode-completions",
        "visualstudioexptteam.vscodeintellicode-insiders",
        // GitHub
        "github.codespaces",
        "github.copilot",
        "github.copilot-chat",
        "github.copilot-labs",
        "github.github-vscode-theme",
        "github.vscode-github-actions",
        "github.vscode-pull-request-github",
        "github.remotehub",
        // Git
        "donjayamanne.githistory",
        // Formatting
        "editorconfig.editorconfig",
        "esbenp.prettier-vscode",
        // Markdown
        // "bierner.github-markdown-preview", // GitHub Markdown Preview Pack
        "yzhang.markdown-all-in-one",
        "shd101wyy.markdown-preview-enhanced",
        // Others
        "vsls-contrib.codetour",
        "streetsidesoftware.code-spell-checker",
        "vscode-icons-team.vscode-icons",
        "wayou.vscode-todo-highlight",
        "rangav.vscode-thunder-client",
        "alexcvzz.vscode-sqlite",
        "qwtel.sqlite-viewer",
        "mechatroner.rainbow-csv",
        // Flutter
        "Dart-Code.dart-code",
        "Dart-Code.flutter",
        // Python
        // "donjayamanne.python-extension-pack"
        "donjayamanne.python-environment-manager",
        "kevinrose.vsc-python-indent",
        "ms-python.pylint",
        "ms-python.python",
        // "ms-python.vscode-pylance",
        "njpwerner.autodocstring",
        // C
        "ms-vscode.cpptools",
        // MSSQL
        "ms-mssql.mssql",
        // Nodejs
        "dbaeumer.vscode-eslint",
        "formulahendry.auto-complete-tag",
        "ritwickdey.liveserver",
        "steoates.autoimport",
        // Angular
        "angular.ng-template",
        "johnpapa.angular2",
        // Vue
        "hollowtree.vue-snippets",
        "octref.vetur",
        "sdras.vue-vscode-snippets",
        "vue.volar",
        "vue.vscode-typescript-vue-plugin",
        // Ruby
        "castwide.ruby-debug",
        "castwide.solargraph",
        "hridoy.rails-snippets",
        "jnbt.vscode-rufo",
        "manuelpuyol.erb-linter",
        "mbessey.vscode-rufo",
        "shopify.ruby-extensions-pack",
        "thadeu.vscode-run-rspec-file",
        "vortizhe.simple-ruby-erb",
        "wingrunr21.vscode-ruby",
        // WeChat Mini Program
        "chandzhang.wechat-snippet",
        "seancheung.wxapp-helper"
    ]
}
```

## Settings

```json
{
    "settings": {
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
        "workbench.colorTheme": "Default Light Modern",
        // Python
        "python.formatting.autopep8Args": ["--ignore", "E402"], // E402 module level import not at top of file
        // Microsoft SQL Server
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
}
```

## postCreateCommand

### Python

```json
{
    "postCreateCommand": "pip3 install --user -r requirements.txt"
}
```

### Nodejs

```json
{
    "postCreateCommand": "npm i -g nodemon express @types/express"
}
```

### angular

```json
{
    "postCreateCommand": "npm install -g @angular/cli"
}
```
