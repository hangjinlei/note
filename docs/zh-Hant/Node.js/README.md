# Getting Started

## 内建模块

- OS
- PATH
- FS
- HTTP

## 全局变量

- `__dirname` - path to current directory
- `__filename` - file name
- `require` - function to use modules (CommonJS)
- `module` - info about current module (file)
- `process` - info about evn where the program is being executed

## 使用 Promise

### 定义

```javascript
const getText = (path) => {
  return new Promise((resolve, reject) => {
    readFile(path, "utf8", (err, data) => {
      if (err) {
        reject(err);
      } else {
        resolve(data);
      }
    });
  });
};
```

### 调用

```javascript
getText("../content/first.txt")
  .then((value) => console.log(value))
  .catch((reason) => console.log(reason));
```

## 使用 util

### 定义

```javascript
const util = require("util");

const readFilePromise = util.promisify(readFile);
const writeFilePromise = util.promisify(writeFile);
```

### 调用

```javascript
const start = async () => {
  try {
    const first = await readFilePromise("../content/first.txt", "utf8");
    const second = await readFilePromise("../content/second.txt", "utf8");
    await writeFilePromise(
      "../content/result-mind-grenade.txt",
      `THIS IS AWESOME: ${first} ${second}`
    );
    console.log(first, second);
  } catch (error) {
    console.log(error);
  }
};
```

## 使用 require promises

### 定义

```javascript
const { readFile, writeFile } = require("fs").promises;
```

### 调用

```javascript
const start = async () => {
  try {
    const first = await readFile("../content/first.txt", "utf8");
    const second = await readFile("../content/second.txt", "utf8");
    await writeFile(
      "../content/result-mind-grenade.txt",
      `THIS IS AWESOME: ${first} ${second}`
    );
    console.log(first, second);
  } catch (error) {
    console.log(error);
  }
};
```
