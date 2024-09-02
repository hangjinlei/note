# HttpClient

## 导入

1. app.module.ts 中导入

    ```typescript
    import { HttpClientModule } from "@angular/common/http";

    @NgModule({
        imports: [
            // ...
            // import HttpClientModule after BrowserModule.
            HttpClientModule,
        ],
        // ...
    })
    export class AppModule {}
    ```

2. 在需要使用的类中注入

    ```typescript
    @Component({})
    export class Component {
        constructor(private http: HttpClient) {}
    }
    ```

## HttpGet

```typescript
data: Song[] = [];

GetData(){
    this.http.get<Song[]>("url").subscribe(data => {
        this.data = data;
    });
}
```

## HttpPost

```typescript
const todo: Todo = {
    // ...
};

this.http.post<Todo>("url", todo).subscribe((data) => {
    this.TodoDataList.push(data);
});
```

## HttpPut

```typescript
this.http.put<Todo>("url" + TodoId, todo).subscribe();
```
