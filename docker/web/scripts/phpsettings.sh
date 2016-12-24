sed -i "s/memory_limit = .*/memory_limit = 1024M/" /etc/php/7.0/apache2/php.ini
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini
sed -i "s/upload_max_filesize.*/upload_max_filesize = 100M/" /etc/php/7.0/apache2/php.ini
sed -i "s/post_max_size.*/post_max_size = 100M/" /etc/php/7.0/apache2/php.ini
