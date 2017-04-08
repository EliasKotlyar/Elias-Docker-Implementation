# MailCatcher: https://serversforhackers.com/setting-up-mailcatcher
# --------------------

# Install Mailcatcher Dependencies (sqlite, ruby)
apt-get update
apt-get install -y build-essential software-properties-common vim curl wget tmux
apt-add-repository -y ppa:brightbox/ruby-ng
apt-get update

apt-get install -y libsqlite3-dev ruby2.2-dev ruby2.2
gem install -V mailcatcher

# Add config to mods-available for PHP
# -f flag sets "from" header for us
touch /etc/php/7.0/mods-available/mailcatcher.ini
echo "sendmail_path = /usr/bin/env $(which catchmail) -f test@local.dev" | tee /etc/php/7.0/mods-available/mailcatcher.ini
# Enable sendmail config for all php SAPIs (apache2, fpm, cli)
phpenmod mailcatcher

# Apache Configuration:
a2enmod proxy
a2enmod proxy_http


MAILCATCHERCONFIG=$(cat <<EOF
ProxyRequests Off
ProxyPass /mailcatcher http://127.0.0.1:1080/
ProxyPass /assets http://127.0.0.1:1080/assets
ProxyPass /messages http://127.0.0.1:1080/messages

#SetEnv force-proxy-request-1.0 1
#SetEnv proxy-nokeepalive 1



EOF
)
echo "$MAILCATCHERCONFIG" > /etc/apache2/conf-available/mailcatcher.conf
a2enconf mailcatcher
mailcatcher
