FROM openjdk:8-jdk-alpine
MAINTAINER lulucky.cn

ARG JAR_FILE
ARG LOG_DIR

ADD ${JAR_FILE} app.jar

EXPOSE 11101

RUN java -version

ENTRYPOINT ["java", "-jar", "app.jar"]
