# 用于 PHP 开发的 Docker 环境

在 mac 上构建 docker 环境用于日常编程开发。

* 系统：macOS Sequoia 15.5
* 设备：MacBook M4 Pro
* 工具：OrbStack

## 重建容器

```text
docker-compose build --no-cache {container-name}
```

## 暴露的端口

| 服务名         | 端口号       |
|-------------|-----------|
| nginx       | 80,443    |
| mysql5.7    | 3307      |
| redis       | 6379      |
| redis-webui | 9987      |
| node22      | 5173,8001 |
| node16      | 8080      |

## 感谢

* [OrbStack](https://orbstack.dev/)
* [garylab/dnmp](https://github.com/garylab/dnmp)
* [laradock/laradock](https://github.com/laradock/laradock)