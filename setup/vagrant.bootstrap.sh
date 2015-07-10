#!/usr/bin/env bash

set -x

. /vagrant/setup/tessrc

# get necessary packages
yum install -y \
    git \
    vim \
    screen \
    httpd \
    mod_perl \
    php \
    php-cli \
    perl-YAML \
    perl-CPAN \
    perl-CGI \
    perl-CGI-Session \
    perl-JSON \
    perl-XML-LibXML \
    perl-DBD-SQLite \
    perl-Term-UI \
    perl-File-Copy-Recursive \
    perl-Archive-Zip \
    gcc \
    python-devel \
    scipy

curl -# -L http://cpanmin.us | perl - --sudo App::cpanminus

/usr/local/bin/cpanm Parallel::ForkManager
/usr/local/bin/cpanm Lingua::Stem

easy_install gensim


# setup tesserae

sudo -u vagrant git clone -b 3_1 https://github.com/cwf2/tesserae $TESSROOT
# comment out the line below to install the full corpus
sudo -u vagrant /vagrant/setup/setup.cut-texts.sh
sudo -u vagrant /vagrant/setup/setup.tess.core.sh

sudo -u vagrant /vagrant/setup/setup.apache.sh
