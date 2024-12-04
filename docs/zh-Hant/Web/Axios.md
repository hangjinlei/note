# Axios

- [GitHub](https://github.com/axios/axios)
- [Vue 3 Typescript example with Axios: Build CRUD App](https://www.bezkoder.com/vue-3-typescript-axios/)

## 安装

```bash
npm install axios
```

## 示例

src/http-common.ts

```typescript
import axios, { AxiosInstance } from "axios";
const apiClient: AxiosInstance = axios.create({
  baseURL: "http://localhost:8000/api",
  headers: {
    "content-type": "application/json",
  },
});

export default apiClient;
```

src/services/TutorialDataService.ts

```typescript
import http from "@/http-common";
class TutorialDataService {
  getAll(): Promise<any> {
    return http.get("/tutorials");
  }
  get(id: any): Promise<any> {
    return http.get(`/tutorials/${id}`);
  }
  create(data: any): Promise<any> {
    return http.post("/tutorials", data);
  }
  update(id: any, data: any): Promise<any> {
    return http.put(`/tutorials/${id}`, data);
  }
  delete(id: any): Promise<any> {
    return http.delete(`/tutorials/${id}`);
  }
  deleteAll(): Promise<any> {
    return http.delete(`/tutorials`);
  }
  findByTitle(title: string): Promise<any> {
    return http.get(`/tutorials?title=${title}`);
  }
}

export default new TutorialDataService();
```
