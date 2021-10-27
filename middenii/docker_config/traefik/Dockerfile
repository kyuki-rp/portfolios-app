FROM wordpress:5.2.2-php7.3-apache

RUN apt-get update
RUN apt-get -y install wget unzip

# テーマのダウンロード
WORKDIR /tmp/wp-themes
RUN wget https://wp-cocoon.com/download/791/cocoon-master-2.1.9.1.zip

# テーマを配置
RUN unzip './*.zip' -d /usr/src/wordpress/wp-content/themes

# 不要ファイル削除
RUN apt-get clean
RUN rm -rf /tmp/*

# 所有者の変更
RUN chown -R www-data:www-data /usr/src/wordpress/wp-content/themes

WORKDIR /var/www/html