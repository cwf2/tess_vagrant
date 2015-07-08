#!/usr/bin/env bash
. /vagrant/setup/tessrc
set -x

# configure web server

perl $TESSROOT/scripts/apache2/vhost-gen.pl > /tmp/tesserae
sudo mv /tmp/tesserae /etc/apache2/sites-available/
sudo a2dissite default
sudo a2ensite tesserae
sudo a2dismod deflate # stops buffering of the progress bars
sudo service apache2 restart

sudo chgrp -R www-data $TESSTMP
sudo chmod g+w $TESSTMP

# build dropdown lists
perl $TESSROOT/scripts/v3/textlist.pl la grc en
