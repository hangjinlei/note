# Bootstrap

## 参考

- https://www.harubears.com/ja/tech-ja/vue-js-ja/vue3-typescript-bootstrap5-button/
- https://www.harubears.com/ja/tech-ja/vue-js-ja/bootstratp-with-vuecli-of-vue3/

## 安装

```bash
npm install bootstrap jquery popper.js
```

## 示例

main.ts

```diff
  import { createApp } from 'vue'
  import App from './App.vue'
+ import "bootstrap"
+ import "bootstrap/dist/css/bootstrap.min.css"

  createApp(App).mount('#app')
```
