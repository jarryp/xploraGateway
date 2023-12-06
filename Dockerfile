FROM amazoncorretto:17-alpine
RUN apk add --no-cache tzdata && apk add curl
ENV TZ='America/Bogota'
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG USER=default
# install sudo as root
RUN apk add --update sudo
# add new user
RUN adduser -D $USER \ && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \ && chmod 0440 /etc/sudoers.d/$USER
USER $USER
VOLUME /tmp

EXPOSE 8080
ADD ./target/xploraGateway-0.0.1-SNAPSHOT.jar xploraGateway.jar
ENTRYPOINT ["java","-jar","/xploraGateway.jar"]

#construir la imagen a partir del Dockerfile
#docker build -t jarryp83/xplora-gateway-api:v1.0.0 .
#subir la imagen en el container registry
#docker push jarryp83/xplora-gateway-api:v1.0.0