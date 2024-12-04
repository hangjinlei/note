# Getting Started

[Docs-CN](https://router.vuejs.org/zh/)

## 参考

- [Vue.js に Vue Router を導入して、タグで画面遷移する方法！ | コードライク](https://codelikes.com/install-vue-router/)

## 安装

```shell
npm install vue-router
```

## 示例

src/router.ts

```typescript
import { createWebHistory, createRouter } from "vue-router";
import { RouteRecordRaw } from "vue-router";

const routes: Array<RouteRecordRaw> = [
  {
    path: "/",
    name: "tutorials",
    alias: "/tutorials",
    component: () => import("./components/TutorialsList.vue"),
  },
  {
    path: "/tutorials/:id",
    name: "tutorial-details",
    component: () => import("./components/TutorialDetails.vue"),
  },
  {
    path: "/add",
    name: "add",
    component: () => import("./components/AddTutorial.vue"),
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
```

src/main.ts

```typescript
import router from "./router";

const app = createApp(App);

app.use(router);
app.mount("#app");
```
