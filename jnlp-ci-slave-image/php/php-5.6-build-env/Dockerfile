FROM php:5.6-apache
MAINTAINER "heyongjia"
COPY portal-login.sh /usr/bin
COPY portal-bake-image.sh /usr/bin

RUN chmod 777 /usr/bin/portal-login.sh  
RUN chmod 777 /usr/bin/portal-bake-image.sh

#ADD https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip /sonar-scanner.zip
COPY sonar-scanner-cli-3.0.3.778-linux.zip /sonar-scanner.zip 
RUN curl https://phar.phpunit.de/phpunit-5.7.9.phar -o /usr/bin/phpunit
RUN chmod 777 /usr/bin/phpunit
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin 
RUN apt-get update && apt-get install -y git unzip \
    --no-install-recommends && rm -r /var/lib/apt/lists/ 

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN unzip /sonar-scanner.zip -d / && rm -f /sonar-scanner.zip
RUN mv /sonar-scanner-3.0.3.778-linux /sonar-scanner
RUN mv /usr/bin/composer.phar /usr/bin/composer 
