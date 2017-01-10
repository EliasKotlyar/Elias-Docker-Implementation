FROM ubuntu:16.04
MAINTAINER elias.kotlyar@gmail.com

VOLUME ["/var/www"]

RUN echo 'phpmyadmin phpmyadmin/dbconfig-install boolean false' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

RUN apt-get update && \
    apt-get install -y \
      wget \
      curl \
      iputils-ping \
      nano \
      apache2 \
      php7.0 \
      php7.0-cli \
      libapache2-mod-php7.0 \
      php7.0-gd \
      php7.0-json \
      php7.0-ldap \
      php7.0-mbstring \
      php7.0-mysql \
      php7.0-pgsql \
      php7.0-sqlite3 \
      php7.0-xml \
      php7.0-xsl \
      php7.0-zip \
      php7.0-soap \
      php7.0-curl \
      phpmyadmin \
      p7zip \
      composer

RUN rm /etc/apache2/conf-available/phpmyadmin.conf
RUN ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf

COPY scripts/phpmyadminautologin.php /etc/phpmyadmin/conf.d/autologin.php

COPY virtualhost.conf /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

# PHP Settings:

COPY scripts/phpsettings.sh /tmp/phpsettings.sh
RUN chmod +x /tmp/phpsettings.sh
RUN /tmp/phpsettings.sh

# n98-magerun

COPY scripts/n98-magerun.sh /tmp/n98-magerun.sh
RUN chmod +x /tmp/n98-magerun.sh
RUN /tmp/n98-magerun.sh


RUN echo 'cd /var/www' >> /root/.bashrc

ENV TERM xterm

EXPOSE 80
EXPOSE 443
CMD ["/usr/local/bin/run"]
