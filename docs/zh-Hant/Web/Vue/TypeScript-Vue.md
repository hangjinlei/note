# TypeScript with Vue

## 定义 Component

```typescript
import { defineComponent } from "vue";

export default defineComponent({
  name: "App",
});
```

## 定义 Props

```typescript
export default defineComponent({
  name: "PersonList",
  props: {
    persons: { type: Array as PropType<Person[]> },
  },
});
```
