#/bin/bash
apt update
apt -y install php php-fpm php-xml php-curl php-mysql php-mbstring unzip zip ffmpeg
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/bin/composer
cd /config
composer require aws/aws-sdk-php