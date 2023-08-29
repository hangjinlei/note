# Getting Started

## Vue CLI

- [Vue CLI](https://cli.vuejs.org/zh/guide/)

```shell
npm install -g @vue/cli
```

```shell
vue create {projectname}
```

## 多文件组件

```html
<template src="./HelloWorld.html" />

<script lang="ts" src="./HelloWorld.ts" />

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped src="./HelloWorld.css" />
```

- 拆分后组件结构

```shell
.
└── HelloWorld
    ├── HelloWorld.css
    ├── HelloWorld.html
    ├── HelloWorld.ts
    └── HelloWorld.vue
```

## 参考

### Docs

- [MDN - JavaScript 参考](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Language_Overview)
- [MSDN - 开始使用](https://docs.microsoft.com/zh-cn/learn/paths/vue-first-steps/)
- [MDN - 开始使用 Vue - 学习 Web 开发](https://developer.mozilla.org/zh-CN/docs/Learn/Tools_and_testing/Client-side_JavaScript_frameworks/Vue_getting_started)

### Tutorials

- [Vue 总结笔记（超全）](https://www.cnblogs.com/zhangzhixi/p/14311057.html)
- [Build Skills 学习挑战赛｜挑战前端开发](https://aka.ms/CSCFD)
- [Vue.js 3 TypeScript Setup & Basics Tutorial | KoderHQ](https://www.koderhq.com/tutorial/vue/typescript/)
- [チュートリアルについて | 基礎から学ぶ Vue.js](https://cr-vue.mio3io.com/tutorials/)
- [vue 中使用 TS 的 class-style 代码风格 - 清和时光 - 博客园](https://www.cnblogs.com/qingheshiguang/p/14696557.html)

### CORS

- https://segmentfault.com/a/1190000037557209
- https://segmentfault.com/a/1190000039681469
