# 路由

## 示例

```typescript
import {
  createRouter,
  createWebHistory,
  RouteRecordRaw,
  RouterOptions,
} from "vue-router";
import HelloWorld from "../components/HelloWorld.vue";

const routes: RouteRecordRaw[] = [
  {
    path: "/",
    name: "routerTestFirst",
    component: () => HelloWorld,
  },
  {
    path: "/second",
    name: "routerTestSecond",
    component: () => HelloWorld,
  },
];

const routerOptions: RouterOptions = {
  history: createWebHistory(process.env.BASE_URL),
  routes: routes,
};

const router = createRouter(routerOptions);

export default router;
```

```javascript
{
    path: '/',
    name: 'HelloWorld',
    component: HelloWorld
}
```

`name` 属性可以在[✈ 导航](./导航)时引用

## 路由参数 (query 参数)

- query 参数参考[✈ 导航](./导航)

- 使用 `query` 参数时只需要将 `params` 替换为 `query` 即可

  ```javascript
  {
      path: "/person/details/:shareid",
      name: "Person",
      component: Person
  }
  ```

- 接收路由参数

  ```javascript
  this.shareid = this.$route.params.shareid;
  ```

- 发送路由参数

  ```javascript
  show(shareid) {
      this.$router.push({
          name: "Person",
          params: {
              shareid: shareid,
          }
      });
  }
  ```
