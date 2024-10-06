# Getting Started

- [GitHub](https://github.com/typicode/json-server)
- [MS Learn](https://docs.microsoft.com/zh-cn/learn/modules/build-web-api-minimal-spa/4-design-api)

## 安装

```shell
npm install -g json-server
```

## 准备 json 档案

```json
{
  "api": [
    {
      "uid": 1,
      "shareId": "6b949586242f37",
      "headImgUrl": "http://shp.qlogo.cn/ttsing/9983120/9983120/100?ts=0",
      "nickName": "朝朝",
      "singerName": "",
      "songs": []
    },
    {
      "uid": 2,
      "shareId": "669f9b8c2d2d3489",
      "headImgUrl": "http://shp.qlogo.cn/ttsing/42698032/42698032/100?ts=0",
      "nickName": "Amiao",
      "singerName": "",
      "songs": []
    }
  ]
}
```

## 启动

```shell
json-server --watch db.json --id shareId --delay 1000
```

## [CLI usage](https://github.com/typicode/json-server#cli-usage) 举例

- `watch` 指定 db 文件
- `id` 指定 实体 ID
- `delay` 指定 延迟时间
