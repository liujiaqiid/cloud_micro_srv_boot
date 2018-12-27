#!/bin/bash

# 构建方式 1
# 1
mvn -B -DskipTests clean package
# 2
java -jar target/*.jar

# 构建方式 2  docker
# mvn clean package -DskipTests dockerfile:build
# docker tag xxx  xxx
# docker push xxxx
# docker run -d -p 18888:18888 -e "github_username=xxx" -e "github_password=xxx" -e "SPRING_PROFILES_ACTIVE=test" -t lulucky/general_srv_config_server:1.0.0