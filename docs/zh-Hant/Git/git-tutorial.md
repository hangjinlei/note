# Git Tutorial

## config

```shell
git config --global user.name "username"
git config --global user.email "example@outlook.com"
git config --global init.defaultBranch <name>
```

## 仓库

### 初始化

```shell
git init
```

## 工作区

### 查看当前状态

```shell
git status
```

### 添加到暂存区

```shell
git add 文件名
git add 文件名 1 文件名 2 …
git add .
```

### 提交至版本库

```shell
git commit -m "message"
```

## 版本

### 查看版本

```shell
git log
git log --pretty=oneline
```

### 回退操作

```shell
git reset --hard HEAD~
git reset –hard <commit_id>
```

### 回到最新

```shell
git reflog
git reset –hard <commit_id>
```

### 提取 Commit 之间的差分

[参考](https://blog.csdn.net/lxf0613050210/article/details/52104287)

```shell
git diff 608e120 4abe32e --name-only
git archive -o update.zip HEAD $(git diff --name-only 608e120 4abe32e)
git diff 608e120 4abe32e --name-only | xargs zip update.zip
```

### 撤回 push

[参考](https://juejin.cn/post/7136171249809489934)

```shell
git log
git reset –-soft <commit_id>
git push origin main --force
```

## 分支管理

### 查看分支

```shell
git branch
```

### 创建分支

```shell
git branch <branch_name>
```

### 切换分支

```shell
git checkout <branch_name>
```

### 创建并切换到分支

```shell
git checkout -b <branch_name>
```

### 删除分支

```shell
git branch -d <branch_name>
```

### 合并分支

```shell
git merge 被合并的分支名
```

### 从主分支合并

```shell
git checkout main
git pull
git checkout current
git merge main
git push
```

## 代理

### 使用代理

```shell
git config --global https.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080
git config --global http.proxy 'socks5://127.0.0.1:1080'
git config --global https.proxy 'socks5://127.0.0.1:1080'

代理服务器需要鉴权配置
git config --global https.proxy https://username:password@proxy.com:8080
```

### 取消代理

```shell
git config --global --unset http.proxy
git config --global --unset https.proxy
```
