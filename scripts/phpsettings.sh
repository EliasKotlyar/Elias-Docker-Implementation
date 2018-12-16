sed -i "s/memory_limit = .*/memory_limit = 1024M/" /etc/php/7.2/apache2/php.ini
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/apache2/php.ini
sed -i "s/upload_max_filesize.*/upload_max_filesize = 100M/" /etc/php/7.2/apache2/php.ini
sed -i "s/post_max_size.*/post_max_size = 100M/" /etc/php/7.2/apache2/php.ini



XDEBUG=$(cat <<EOF
zend_extension=xdebug.so
xdebug.remote_host = localhost
xdebug.remote_connect_back=On
xdebug.remote_enable = 1
xdebug.remote_port = 9000
xdebug.remote_handler = dbgp
xdebug.remote_mode = req
xdebug.remote_autostart=0
xdebug.profiler_enable = 0;
xdebug.profiler_enable_trigger = 1;
xdebug.max_nesting_level = 400
EOF
)

echo "$XDEBUG" > /etc/php/7.2/apache2/conf.d/20-xdebug.ini
