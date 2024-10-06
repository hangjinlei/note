# Docs

- https://angular.io/generated/navigation.json
- https://angular.tw/generated/navigation.json
- https://angular.cn/generated/navigation.json

- [理解 Angular](https://angular.tw/guide/understanding-angular-overview)
  - [元件](https://angular.tw/guide/component-overview)
    - [檢視封裝](https://angular.tw/guide/view-encapsulation)
    - [元件之間的互動](https://angular.tw/guide/component-interaction)
    - [在父子指令及元件之間共享資料](https://angular.tw/guide/inputs-outputs)
      - [把資料傳送到子元件](https://angular.tw/guide/inputs-outputs#sending-data-to-a-child-component)
      - [把資料傳送到父元件](https://angular.tw/guide/inputs-outputs#sending-data-to-a-parent-component)
      - [同時使用 @Input() 和 @Output()](https://angular.tw/guide/inputs-outputs#using-input-and-output-together)
  - [模板](https://angular.cn/guide/template-overview)
    - [绑定](https://angular.cn/guide/binding-overview)
      - [Attribute](https://angular.cn/guide/attribute-binding)
      - [Class, Style](https://angular.cn/guide/class-binding)
      - [Event](https://angular.cn/guide/event-binding)
      - [Property](https://angular.cn/guide/property-binding)
    - [管道](https://angular.cn/guide/pipes-overview)
      - [内置管道](https://angular.cn/api/common#%E7%AE%A1%E9%81%93)
  - 指令
    - [内置指令](https://angular.cn/guide/built-in-directives)
      - [ngFor](https://angular.cn/guide/built-in-directives#listing-items-with-ngfor)
        - [局部变量](https://angular.cn/api/common/NgForOf#local-variables) (index, count, etc..)
      - [ngModel](https://angular.cn/guide/built-in-directives#displaying-and-updating-properties-with-ngmodel)
  - 依赖注入
    - [Angular 中的依赖注入](https://angular.tw/guide/dependency-injection)
- [开发指南](https://angular.cn/guide/developer-guide-overview)
  - [HTTP 客户端](https://angular.cn/guide/http)
- Angular 工具
  - 开发工作流
    - [构建与本地服务器](https://angular.cn/guide/build)
      - [代理到后端服务器](https://angular.cn/guide/build#proxying-to-a-backend-server)
  - [Angular CLI 构建器](https://angular.cn/guide/cli-builder)
- 参考手册

  - 概念参考手册
    - Angular 概念
      - [模板变量](https://angular.cn/guide/template-reference-variables) `<input #TodoInput />`

- [用户输入](https://angular.cn/guide/user-input)
  - [按键事件过滤](https://angular.cn/guide/user-input#key-event-filtering-with-keyenter) `(keyup.enter)="Add(TodoInput)"`
  - [从一个模板引用变量中获得用户输入](https://angular.cn/guide/user-input#get-user-input-from-a-template-reference-variable) `$event`
