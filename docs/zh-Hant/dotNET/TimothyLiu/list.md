# List

- 底层为数组, 有顺序.

- 初始化 Capacity 为 4, 随后翻倍增长.

- 初始化器底层为调用`Add()` 方法.

构造器 (3 个)

- `public List()`
- `public List(IEnumerable<T> collection)`
- `public List(int capacity)`

方法

- `public void Add(T item)`
- `public void AddRange(IEnumerable<T> collection)`
- `public void Insert(int index, T item)`
  > 当使用 Insert 时, 底层会将 index 后的数据向右平移 1 位, 使用时需要考虑性能.
