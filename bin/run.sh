#!/bin/bash

# 1. How to build : For Local Test
mvn -B -DskipTests clean package
java -jar target/*.jar

# 2. How to build :  For Docker Env
# mvn clean package -DskipTests dockerfile:build
# docker tag xxx  xxx
# docker push xxxx
# docker run -d -p 18888:18888 -e "github_username=xxx" -e "github_password=xxx" -e "SPRING_PROFILES_ACTIVE=test" -t lulucky/general_srv_config_server:1.0.0
