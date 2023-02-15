# Docker Alpine XunSearch

## 版本

* [1.4.17 , latest](https://github.com/seffeng/docker-xunsearch)

## 常用命令：

```sh
# 拉取镜像
$ docker pull seffeng/xunsearch

# 运行
$ docker run --name xunsearch-test -d -p <port>:8383 -p <port>:8384 -v <data-dir>:/opt/websrv/data/xunsearch -v <tmp-dir>:/opt/websrv/tmp -v <log-dir>:/opt/websrv/logs seffeng/xunsearch

# 例子：
$ docker run --name xunsearch-test -d -p 8383:8383 -p 8384:8384 -v /opt/websrv/data/xunsearch:/opt/websrv/data/xunsearch -v /opt/websrv/tmp:/opt/websrv/tmp -v /opt/websrv/logs/xunsearch:/opt/websrv/logs seffeng/xunsearch

# 查看正在运行的容器
$ docker ps

# 停止
$ docker stop [CONTAINER ID | NAMES]

# 启动
$ docker start [CONTAINER ID | NAMES]

# 进入终端
$ docker exec -it [CONTAINER ID | NAMES] sh

# 删除容器
$ docker rm [CONTAINER ID | NAMES]

# 镜像列表查看
$ docker images

# 删除镜像
$ docker rmi [IMAGE ID]

# 复制本机文件到容器
$ docker cp /root/file [CONTAINER ID]:/root/file

# 复制容器文件到本机
$ docker cp [CONTAINER ID]:/root/file /root/file
```
#### 备注

```shell
# 建议容器之间使用网络互通
## 1、添加网络[已存在则跳过此步骤]
$ docker network create network-01

## 运行容器增加 --network network-01 --network-alias [name-net-alias]
$ docker run --name xunsearch-alias1 --network network-01 --network-alias xunsearch-net1 -d -p 8383:8383 -p 8384:8384 -v /opt/websrv/data/xunsearch:/opt/websrv/data/xunsearch -v /opt/websrv/tmp:/opt/websrv/tmp -v /opt/websrv/logs/xunsearch:/opt/websrv/logs seffeng/xunsearch
```