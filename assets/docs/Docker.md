#### Docker 安装
1. 脚本安装
```
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun
```

2. 启动
```
# 开机启动
sudo systemctl enable docker
# 启动docker服务
sudo systemctl start docker
```

3. 账户
```
// 建立 docker 组：
sudo groupadd docker
// 将当前用户加入 docker 组：
sudo usermod -aG docker $USER
```

4. 测试
```
docker run hello-world
```

#### Docker 运维
- `docker images`  查看本地镜像
- `docker ps -a`   查看容器进程
- `docker stop xxx`  停止容器
- `docker rm xxx`  删除容器
    - `docker rm -f`
- `docker rmi xxx`  删除镜像    
- `docker pull xxx`  拉取镜像
- `docker search xxx`  查询镜像
- `docker build -t <YOUR_USERNAME>/myfirstapp .` 本地构建镜像
- `docker run -d -P -e "SPRING_PROFILES_ACTIVE=test" -t juliye_docker/juliye_ms_ad:1.1.1`
- `docker inspect xxx` 查看容器设置详情
- `docker logs -f xxx` 查看容器日志
- docker network
    - `docker network ls`
    - `docker network create -d overlay --subnet=192.168.20.0/24 firenet`
- `docker exec -it xxx bash` 进入镜像的bash交互界面