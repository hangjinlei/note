# AWS SAM Deploy Guide

## Prerequisites

-   Docker
-   Python

## Build

```bash
sam build [--use-container]
```

## Deploy

```bash
sam deploy [--config-env dev] [--guided]
```

## samconfig.toml

```
version = 0.1

[default]
region = "us-west-2"
stack_name = "my-stack"
s3_bucket = "my-sam-deployments"
s3_prefix = "my-app/"

[dev]
region = "us-west-2"
stack_name = "dev-stack"
s3_bucket = "dev-sam-deployments"
s3_prefix = "dev-app/"

[prod]
region = "us-west-2"
stack_name = "prod-stack"
s3_bucket = "prod-sam-deployments"
s3_prefix = "prod-app/"
```

## CLI Parameters

在使用 SAM CLI 部署时，您可以使用以下命令行参数来传递这些值：

-   `--stack-name`：指定要创建或更新的 CloudFormation 栈的名称。
-   `--s3-bucket`：指定用于存储部署文件的 S3 存储桶名称。
-   `--s3-prefix`：指定部署文件在 S3 存储桶中的前缀（可选）。
-   `--region`：指定部署的 AWS 区域。
-   `--capabilities`：指定要添加到 CloudFormation 栈的能力，如 `CAPABILITY_IAM` 或 `CAPABILITY_AUTO_EXPAND`。
-   `--parameter-overrides`：传递参数覆盖值。参数覆盖值采用 `ParameterKey=ParameterValue` 的形式，多个参数之间用空格分隔。
-   `--image-repositories`：指定 Docker 镜像仓库的名称和 URL，用于构建和部署函数的容器映像。
-   `--confirm-changeset`：在部署之前，确认对 CloudFormation 更改集的批准。
-   `--disable-rollback`：禁用部署失败时的 CloudFormation 回滚。

请注意，这些参数是 SAM CLI 的一部分，可以与 `sam deploy` 命令一起使用。根据您的需求，将相应的值替换为实际的值，并将其包含在部署命令中。
