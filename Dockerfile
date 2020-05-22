####
# This Dockerfile is used in order to build a container that runs the Quarkus application in native (no JVM) mode
#
#
# Then, build the image with:
#
# docker build -f src/main/docker/Dockerfile.native.multistage -t quarkus/first .
#
# Then run the container using:
#
# docker run -i --rm -p 8080:8080 quarkus/first
#
###
FROM quay.io/quarkus/centos-quarkus-maven:19.3.1-java11 AS build
ADD src /usr/src/app/src
COPY pom.xml /usr/src/app
USER root
RUN chown -R quarkus /usr/src/app
USER quarkus
RUN mvn -f /usr/src/app/pom.xml -Pnative clean package

FROM cescoffier/native-base:latest
COPY --from=build /usr/src/app/target/*-runner /application
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
