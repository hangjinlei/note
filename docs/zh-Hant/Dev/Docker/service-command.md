# 服务命令

## 启动 docker 服务

CentOS

```bash
systemctl start docker
```

Ubuntu

```bash
sudo service start docker
```

## 查看 Docker 状态

```bash
systemctl status docker
```

## 设置 Docker 开机自启

```bash
systemctl enable docker
```

## 禁用 Docker 开机自启

```bash
systemctl disable docker
```

## 重新启动 Docker 服务

```bash
systemctl restart docker
```

## 查看 Docker 信息

```bash
docker info
```

## 查看 docker info 中具体 key 的信息

```bash
docker info | grep 'Docker Root Dir:'
```

## 停止 docker 服务

```bash
systemctl stop docker
```
