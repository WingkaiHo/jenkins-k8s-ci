FROM maven:3.3.9-jdk-8-alpine
MAINTAINER "heyongjia"

COPY settings.xml /usr/share/maven/conf/settings.xml
COPY portal-login.sh /usr/bin
COPY portal-bake-image.sh /usr/bin

RUN chmod 777 /usr/bin/portal-login.sh  
RUN chmod 777 /usr/bin/portal-bake-image.sh
RUN apk add --no-cache bash git 
