# Property 和 Attribute

- Property

  用[]包住属性名，等号右侧写 TS 中声明的变量

  ```html
  <div [hidden]="!hidden">
    <input type="text" [(ngModel)]="name" />
  </div>
  ```

- Attribute

  使用 `attr. `的綁定，就什麼名稱都可以正常綁定

  常用的 `data-_`也可以使用`[attr.data-_]`來綁定
