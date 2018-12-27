FROM openjdk:8-jdk-alpine
MAINTAINER lulucky.cn

ARG JAR_FILE
ARG LOG_DIR
ADD ${JAR_FILE} app.jar
EXPOSE 18080
EXPOSE 18081

RUN java -version

ENTRYPOINT ["java", "-jar", "app.jar"]
