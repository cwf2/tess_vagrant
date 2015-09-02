Tesserae with Vagrant
=====================

Build a Tesserae installation using Vagrant and VirtualBox. Useful for development or adding your own texts without having to deal with a messy install process.

By default, `vagrant up` will install Perseus Latin texts, indexed by word and stem. Also sets up the web interface using Apache; if you want to view the site on your host computer, add the following to your _hosts_ file:
```
master.tesserae.org  128.180.30.10
```
Then point your browser to _master.tesserae.org_. To change the name/IP address, see _Vagrantfile_ line 27, and _setup/tessrc_ line 3.

To interact with Tesserae on the command line, use `vagrant ssh`.

VM specs
--------

Note that the _Vagrantfile_ allocates 2 GB of RAM and 2 CPUs to the guest machine (lines 53-54). You might want to raise/lower those numbers depending on your host.

If you add more CPUs, you can take advantage of them by changing $TESSNCORES in _setup/tessrc_ to some other number, or using the *--parallel* option with scripts at the command line.

Extras
------

The following scripts add to/take away from the installation process. You can modify _setup/bootstrap.sh_ to include them (this is run during provisioning). Or ssh into the VM and run them yourself.

 * _setup.tess.ancillaries.sh_ adds the following for Greek and Latin:
   * LSI search
   * multi-text search
   * translation featuresets
   * batch searches via web interface
   
To do
-----

My plan is to add branches to this repo that correspond to different branches of Tesserae, (like *develop* for example).