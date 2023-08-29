# ngFor

使用 `*ngFor` 绑定到 TS `*ngFor="let item of cpu"`

使用`*ngFor`、 `*ngIf`和`[(ngModel)]` 编辑表单

```html
<table>
  <tr>
    <td>名称</td>
    <td>价钱</td>
    <td>等级</td>
    <td>编辑</td>
  </tr>
  <tr *ngFor="let item of cpu">
    <td>
      <div *ngIf="!item.edit">{{item.name}}</div>
      <input *ngIf="item.edit" type="text" [(ngModel)]="item.name" />
    </td>
    <td>
      <div *ngIf="!item.edit">{{item.price}}</div>
      <input *ngIf="item.edit" type="text" [(ngModel)]="item.price" />
    </td>
    <td>
      <div *ngIf="!item.edit">{{item.rank}}</div>
      <input *ngIf="item.edit" type="text" [(ngModel)]="item.rank" />
    </td>
    <td>
      <button *ngIf="!item.edit" (click)="item.edit=true">编辑</button>
      <button *ngIf="item.edit" (click)="item.edit=false">完成</button>
    </td>
  </tr>
</table>
```
