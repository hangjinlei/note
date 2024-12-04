# Getting Started

## Mock Date

```typescript
jest.mock("crypto", () => ({
  randomUUID() {
    return "a";
  },
}));

const mockDate = new Date(0);
jest
  .spyOn(global, "Date")
  .mockImplementation(() => mockDate as unknown as string);
```
