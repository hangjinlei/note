# 镜像

## NuGet

```plaintext
https://nuget.cdn.azure.cn/v3/index.json
```

## NPM

```powershell
npm config set registry https://registry.npm.taobao.org
```

## Maven Tencent

```xml
<mirror>
	<id>nexus-tencentyun</id>
	<mirrorOf>*</mirrorOf>
	<name>Nexus tencentyun</name>
	<url>http://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
</mirror>
```

## Docker 镜像加速

### 配置文件路径

```plaintext
/etc/docker/daemon.json
```

### 执行以下命令

```bash
cat <<EOF > /etc/docker/daemon.json
{
    "registry-mirrors": [
        "https://docker.mirrors.ustc.edu.cn",
        "http://hub-mirror.c.163.com"
    ],
    "max-concurrent-downloads": 10,
    "log-driver": "json-file",
    "log-level": "warn",
    "log-opts": {
        "max-size": "10m",
        "max-file": "3"
    },
    "data-root": "/var/lib/docker"
}
EOF
```

### 重新加载配置，重新启动服务

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```
