FROM node:9
MAINTAINER "heyongjia"
COPY portal-login.sh /usr/bin
COPY portal-bake-image.sh /usr/bin
COPY npmrc /root/.npmrc  
RUN chmod 777 /usr/bin/portal-login.sh  
RUN chmod 777 /usr/bin/portal-bake-image.sh

#ADD https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip /sonar-scanner.zip
COPY sonar-scanner-cli-3.0.3.778-linux.zip /sonar-scanner.zip 
RUN apt-get update && apt-get install -y git unzip \
    --no-install-recommends && rm -r /var/lib/apt/lists/
RUN unzip /sonar-scanner.zip -d / && rm -f /sonar-scanner.zip
RUN mv /sonar-scanner-3.0.3.778-linux /sonar-scanner
RUN npm i mocha nyc mocha-junit-reporter istanbul -g
