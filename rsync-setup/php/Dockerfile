FROM php:7.2-fpm-alpine

RUN docker-php-ext-install pdo_mysql
RUN apk --update --no-cache add autoconf g++ make && \
    pecl install -f xdebug && \
    docker-php-ext-enable xdebug && \
    apk del --purge autoconf g++ make

RUN apk add busybox-extras 
RUN apk add rsync 

ADD ./rsyncd.conf /etc
ADD ./inetd.conf /etc
#RUN /usr/sbin/inetd

#RUN sed -i 's/disable[[:space:]]*=[[:space:]]*yes/disable = no/g' /etc/xinetd.d/rsync # enable r sync
#RUN cp /root/rsyncd.conf /etc/rsyncd.conf # setup git folder for sync and allow all clients
#
#RUN /etc/rc.d/init.d/xinetd start
#RUN chkconfig xinetd on
#
## create the dir that will be synced
#RUN mkdir /home/share
#
## just to keep the container running
#CMD /etc/rc.d/init.d/xinetd start && tail -f /dev/null





EXPOSE 9000
EXPOSE 873

CMD /usr/sbin/inetd &&php-fpm
