# Template

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
