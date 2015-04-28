#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

# configure web server

# Add host-only net on new interface
cp /etc/hosts ~/hosts.backup
sudo bash -c "cat >> /etc/hosts" <<END
# Tesserae Virtual Host
127.0.0.1 $TESSDOMAIN
END

# add vhost to nginx, bring up site
sudo cp /vagrant/tesserae.org /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/tesserae.org /etc/nginx/sites-enabled
sudo service nginx restart

