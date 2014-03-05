FROM ubuntu:saucy

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list

RUN apt-get -y update
RUN apt-get install -y curl libphp-phpmailer nginx php-crypt-blowfish php-getid3 php-mdb2 php-mdb2-schema php-pear php-xml-parser php5-curl php5-gd php5-json php5-fpm php-mdb2-driver-pgsql supervisor
RUN echo 'daemon off;' >> /etc/nginx/nginx.conf

RUN (curl http://download.owncloud.org/community/owncloud-6.0.1.tar.bz2 | tar jx -C /usr/share)
RUN chown -R www-data /usr/share/owncloud

ADD conf/dbconfig.sh /usr/local/sbin/owncloud-dbconfig.sh
RUN chmod +x /usr/local/sbin/owncloud-dbconfig.sh
ADD conf/nginx-site /etc/nginx/sites-enabled/default
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD conf/autoconfig.php /usr/share/owncloud/config/autoconfig.php

EXPOSE 80
VOLUME ["/var/lib/owncloud/data"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
