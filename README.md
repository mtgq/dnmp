## Docker Compose 管理

```shell
docker-compose up --no-deps -d redis      # 启动新服务，不会影响到其所依赖的服务
docker-compose rm php                     # 删除并且停止php容器
docker-compose down                       # 停止并删除容器，网络，图像和挂载卷
```

## PHP 管理

### 进入容器

```shell
docker exec -it dnmp-php /bin/bash
```

## Nginx 管理

### 重启

```shell
docker exec -it nginx nginx -s reload
```

## MySQL 管理

### 进入容器

```shell
docker exec -it dnmp-mysql /bin/bash
```

### 重启容器

```shell
docker-compose restart mysql
```

### 连接容器:

- 容器内: `mysql -uroot -p123456`

- 容器外: `mysql -h 127.0.0.1 -P 3308 -uroot -p123456`

## Redis 管理

### 连接

- 通过 ip: `docker exec -it dnmp-redis redis-cli -h 127.0.0.1 -p 6379`

- 通过容器名字: `docker exec -it dnmp-redis redis-cli -h dnmp-redis -p 6379`

### 重启

```shell
docker-compose up --no-deps -d redis
```

### 外部宿主机连接

`redis-cli -h 127.0.0.1 -p 6379`

## 容器导出和导入

### 导出镜像

```shell
docker save -o composer-1.10.16.tar composer:1.10.16
```

注：composer:1.10.16 是本地已经存在的镜像。完成后会在本地生成一个 composer-1.10.16.tar 压缩包文件

### 导入镜像

```shell
docker load -i composer-1.10.16.tar
```