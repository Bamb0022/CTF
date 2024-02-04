# FROM ctftraining/base_image_nginx_mysql_php_56
FROM ctftraining/base_image_nginx_mysql_php_73
COPY ./files /tmp/
RUN cp -rf /tmp/html /var/www/ \
    && cp -f /tmp/flag.sh /flag.sh \
    && chown -R www-data:www-data /var/www/html 

# 自定义 flag 方式
# COPY flag.sh /flag.sh
