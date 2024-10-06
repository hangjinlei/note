# 关于使用第三方 js 库

## 使用 `any`

1. index.html 引入第三方库

   库文件应放置在 `assets` 目录下

2. `.d.ts` 文件中定义 $ 为 any 类型

   `tsconfig.app.json` 文件中定义了`.d.ts`文件的用法

   ```typescript

   <!-- 以JQuery 为例 -->
   declare var $: any;
   ```

## 使用 `@types`

以 JQuery 为例

1.  安装 `@types` 为编辑器提供支持
2.  `/tsconfig.app.json/types` 节中增加`"jquery"`
3.  `/src/index.html` 引入第三方库

或

`/angular.json/projects/helloworld/architect/build/scripts` 节中引入第三方库
`["node_modules/jquery/dist/jquery.min.js"]`

此操作编译后会将 Array 中的所有 js 打包成 scripts.js

## 关于 [配置 CommonJS 依賴項](https://angular.tw/guide/build#configuring-commonjs-dependencies)

以 `lodash` 为例
选用库的 `es` 版本, 即`lodash-es`
