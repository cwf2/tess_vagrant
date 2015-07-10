#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

# configure web server

perl $TESSROOT/scripts/apache2/vhost-gen.pl > /tmp/tesserae.conf
sudo mv /tmp/tesserae.conf /etc/httpd/conf.d/tesserae.conf
sudo mv /etc/httpd/conf.d/welcome.conf /home/vagrant/old.welcome.conf
sudo service httpd restart

sudo chown -R apache:apache $TESSTMP
sudo chmod g+w $TESSTMP

# build dropdown lists
perl $TESSROOT/scripts/textlist.pl la grc
