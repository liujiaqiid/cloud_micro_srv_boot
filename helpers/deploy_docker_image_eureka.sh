#!/bin/bash
help()
{
  cat << HELP
NAME
    cmd -- used to operate docker image
DESCRIPTION
    This tool is for build docker image, push to repo server, and run on docker engine.
HISTORY
    2018-12-27 Init
AUTHORS
    Jacky.L <liujiaqiid@gmail.com>    
PROJECT
    tools.lulucky.cn 
Usage
    sh deploy_docker_image.sh HostName ENV ProjectName Port VERSION
    sh deploy_docker_image.sh localhost test general_srv_config_server 18888 1.0.0
Copyright (c) 2018 lulucky.cn.
HELP
  exit 0
}
###################
while [[ -n "$1" ]]; do
case "$1" in
   -h) help;shift 1;; # function help is called
   --) shift;break;; # end of options
   -*) echo "error: no such option $1. -h for help";exit 1;;
   *) break;;
esac
done

###################

# 目标主机
hostname='localhost'
# 构建环境
env='test'
# 构建项目
projname='general_srv_eureka'
# 暴露端口号
port=18761
# 镜像标签
tag=$1
#
#uname=$6
#pwd=$7



# Push local docker image to remote repo
function step_1_push_image {
    # docker login --username=$uname --password=$pwd registry.cn-beijing.aliyuncs.com
    # echo "-------------------1.1 after login"
    # Docker tag image
    docker tag lulucky/$projname:$tag registry.cn-beijing.aliyuncs.com/lulucky/$projname:$tag
    echo "-------------------1.2 after tag"
    # Docker push image to remote
    # docker push registry-vpc.cn-beijing.aliyuncs.com/micro-srv/$projname:$tag
    docker push registry.cn-beijing.aliyuncs.com/lulucky/$projname:$tag
    echo "-------------------1.3 after push"
    # Remove local images which tag is none
    docker images |grep none
    if [ $? -eq 0 ];then
      docker images |grep none |awk '{print $3}'|xargs docker rmi -f
    else
      echo "no none images"
    fi
    echo "-------------------1.4 after rmi"
}

# Stop and remove local docker image
function step_2_stop_container {
    # Stop and Remove Container
    # ansible $hostname -u lulucky --sudo -m shell -a "docker ps -a|grep $projname|awk '{print \$1}'|xargs docker rm -f"
    docker ps -a|grep $projname
    if [ $? -eq 0 ];then
        docker ps -a|grep $projname|awk '{print $1}'|xargs docker rm -f
    else
        echo "no container running"
    fi
    echo "-------------------2.1 after rm container"
    # Pull the new image
    # ansible $hostname -u lulucky --sudo -m shell -a "docker pull registry-vpc.cn-beijing.aliyuncs.com/micro-srv:$projname:$tag"
    docker pull registry.cn-beijing.aliyuncs.com/lulucky/$projname:$tag
    echo "-------------------2.2 after pull image"
}

# Launch remote docker image
function step_3_start_container {
    # Stop and Remove Docker Image
    # ansible $hostname -u lulucky --sudo -m shell -a "docker images |grep none |awk '{print \$3}'|xargs docker rmi -f"
    docker images |grep none
    if [ $? -eq 0 ];
    then
        docker images |grep none |awk '{print $3}'|xargs docker rmi -f
    else
        echo "no none images"
    fi
    echo "-------------------3.1 after rm image"
    # Make sure the log directory exists 
    # ansible $hostname -u lulucky --sudo -m file -a "path=/data/logs/$projname state=directory "
    if [ ! -d  "/data/logs/$projname" ];
    then
        mkdir -p /data/logs/$projname
    fi
    echo "-------------------3.2 after mk dir"
    # Run docker image
    # ansible $hostname -u lulucky --sudo -m shell -a "docker run -d -p $port1:$port1  -v /etc/hosts:/etc/hosts  -v /etc/timezone:/etc/timezone -v /etc/localtime:/etc/localtime -v /data/logs/$projname:/data/logs/$projname -e "SPRING_PROFILES_ACTIVE=$env"  --name $projname registry-vpc.cn-beijing.aliyuncs.com/micro-srv/$projname:$tag "
    docker run -d -p $port:$port\
        -v /etc/localtime:/etc/localtime\
        -v /data/logs/$projname:/data/logs/$projname\
        -e "SPRING_PROFILES_ACTIVE=$env"\
        --restart always\
        --name $projname registry.cn-beijing.aliyuncs.com/lulucky/$projname:$tag
    echo "-------------------3.3 after docker run"
}

echo "-------------------1. before push image"
step_1_push_image
echo "-------------------2. before stop container"
step_2_stop_container
echo "-------------------3. before start container"
step_3_start_container
