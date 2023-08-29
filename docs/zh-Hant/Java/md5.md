# MD5

```java
byte[] bytes = user.getPassword().getBytes();
String md5Pass = DigestUtils.md5DigestAsHex(bytes);
```
