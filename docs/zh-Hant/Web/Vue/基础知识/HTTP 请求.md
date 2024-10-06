# HTTP 请求

- Get

  ```javascript
  this.$http.get(this.url).then(
    (response) => {
      this.singer = response.body.find((item) => item.shareId == this.shareid);
    },
    (response) => {
      // Error
    }
  );
  ```

- Post

  ```javascript
  this.$http
    .post(this.url, {
      content: "",
    })
    .then(
      (response) => {
        this.singer = response.body.find(
          (item) => item.shareId == this.shareid
        );
      },
      (response) => {
        // Error
      }
    );
  ```
