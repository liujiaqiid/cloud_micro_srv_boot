FROM openjdk:8-jdk-alpine
MAINTAINER lulucky.cn

ARG JAR_FILE
ARG LOG_DIR
ADD ${JAR_FILE} app.jar
# ENV github_username xxxxx
# ENV github_password xxxxx
EXPOSE 18888
RUN java -version

ENTRYPOINT ["java", "-jar", "app.jar"]
