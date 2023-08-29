# Routes

1. 定义路由参数
2. 导入路由模块
3. 导出路由类 - APP 模块导入

```typescript
const routes: Routes = [
  { path: "", redirectTo: "/home", pathMatch: "full" },
  { path: "home", component: homeComponent },
  { path: "collect", component: collectComponent },
  { path: "**", redirectTo: "/home", pathMatch: "full" },
];
```

## 访问路由页面

使用`[routerLink]="['./home']"`

```html
<a [routerLink]="['./home']">
  <div [ngClass]="navItem">Home</div>
</a>
<a [routerLink]="['./collect']">
  <div [ngClass]="navItem">Collect</div>
</a>
```

## 获取路由参数

```html
<a [routerLink]="['/collect/'+(id-1)]">Pervious</a>
<a [routerLink]="['/collect/'+(id+1)]">Next</a>
```

```typescript
export class ComiComponent implements OnInit, OnDestroy {
  id!: number;
  ss!: Subscription;

  constructor(private routePar: ActivatedRoute) { }
  ngOnInit(): void {
    this.ss = this.routePar.params.subscribe(par => {
      this.id = parseInt(par["comi"]);
     });
  }
  ngOnDestroy(): void {
    this.ss.unsubscribe();
  }
```
