# Angular

## Docs

-   [Angular TW](https://angular.tw/docs)
-   [Angular CN](https://angular.cn/docs)

## [安裝 Angular CLI](https://angular.tw/guide/setup-local#install-the-angular-cli)

```shell
npm install -g @angular/cli
```

## CLI Command

-   new

    ```bash
    ng new angular-tour-of-heroes
    ```

-   run

    ```bash
    ng serve --open
    ng serve -o
    ```

-   component

    ```bash
    ng generate component <component-name>
    ng g c <component-name>
    ```

-   service

    ```bash
    ng generate service <service-path>
    ng g s <service-path>
    ```

## 跨域问题

-   [Docs - 代理到后端服务器](https://angular.cn/guide/build#proxying-to-a-backend-server)

1. 创建一个 `proxy.conf.json` 文件
2. 在 `angular.json` 中将 `proxyConfig` 设置为 `proxy.conf.json` 的路径

### 示例

src/proxy.conf.json

```json
{
    "/api": {
        "target": "https://todo.talllkai.com", // 后端服务器地址
        "secure": true, // 启用https
        "changeOrigin": true, // 后端不在localhost 时需要启用
        "pathRewrite": {
            "^/api": "" // 重写URL, 请求URL中 "api" => ""
        }
    }
}
```

angular.json

```json
// …
"architect": {
  "serve": {
    "builder": "@angular-devkit/build-angular:dev-server",
    // add
    "options": {
      "proxyConfig": "src/proxy.conf.json"
    },
// …
```
