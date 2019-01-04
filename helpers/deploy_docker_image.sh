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
while [ -n "$1" ]; do
case "$1" in
   -h) help;shift 1;; # function help is called
   --) shift;break;; # end of options
   -*) echo "error: no such option $1. -h for help";exit 1;;
   *) break;;
esac
done

###################

hostname=$1
env=$2
dirname=$3
port1=$4
tag=$5
uname=$6
pwd=$7

# Push local docker image to remote repo
function step_1_push_image {
    docker login --username=$uname --password=$pwd registry.cn-beijing.aliyuncs.com
    echo "-------------------1.1 after login"
    # Docker tag image
    docker tag lulucky/$dirname:$tag registry.cn-beijing.aliyuncs.com/lulucky/$dirname:$tag
    echo "-------------------1.2 after tag"
    # Docker push image to remote
    # docker push registry-vpc.cn-beijing.aliyuncs.com/micro-srv/$dirname:$tag
    docker push registry.cn-beijing.aliyuncs.com/lulucky/$dirname:$tag
    echo "-------------------1.3 after push"
    # Remove local images which tag is none
    docker images |grep none |awk '{print $3}'|xargs docker rmi -f
    echo "-------------------1.4 after rmi"
}

# Stop and remove local docker image
function stop_container {
    # Stop and Remove Container
    ansible $hostname -u lulucky --sudo -m shell -a "docker ps -a|grep $dirname|awk '{print \$1}'|xargs docker rm -f"
    echo "after rm container"
    # Pull the new image
    ansible $hostname -u lulucky --sudo -m shell -a "docker pull registry-vpc.cn-beijing.aliyuncs.com/micro-srv:$dirname:$tag"
    echo "after pull image"
}

# Launch remote docker image
function start_container {
    # Stop and Remove Docker Image
    ansible $hostname -u lulucky --sudo -m shell -a "docker images |grep none |awk '{print \$3}'|xargs docker rmi -f"
    echo "after rm image"
    # Make sure the log directory exists 
    ansible $hostname -u lulucky --sudo -m file -a "path=/data/logs/$dirname state=directory "
    echo "after dir"
    # Run docker image
    ansible $hostname -u lulucky --sudo -m shell -a "docker run -d -p $port1:$port1  -v /etc/hosts:/etc/hosts  -v /etc/timezone:/etc/timezone -v /etc/localtime:/etc/localtime -v /data/logs/$dirname:/data/logs/$dirname -e "SPRING_PROFILES_ACTIVE=$env"  --name $dirname registry-vpc.cn-beijing.aliyuncs.com/micro-srv/$dirname:$tag "
    echo "after docker run"
}

echo "before push image"
step_1_push_image
echo "before stop container"
#stop_container
#echo "before start container"
#start_container
