#!/bin/bash
# vagrant up
# vagrant ssh
sudo su -
apt-get install -y build-essential g++ swig autotools-dev blt-dev bzip2 dpkg-dev g++-multilib gcc-multilib libbluetooth-dev libbz2-dev libexpat1-dev libffi-dev libffi6 libffi6-dbg libgdbm-dev libgpm2 libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libtinfo-dev mime-support net-tools netbase python-crypto python-mox3 python-pil python-ply quilt tk-dev zlib1g-dev unzip wget
apt-get update -y
mkdir -p /app/.heroku
cd /app/.heroku
wget https://s3-us-west-2.amazonaws.com/georemedy-files/cf/ext-vendor-libs.zip
unzip ext-vendor-libs.zip
cd ~

wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
tar xfz Python-2.7.11.tgz
cd Python-2.7.11
./configure --prefix /app/.heroku/python --enable-ipv6
make && make install

wget http://download.osgeo.org/geos/geos-3.5.0.tar.bz2
tar xvf geos-3.5.0.tar.bz2
cd geos-3.5.0/
./configure --enable-python --prefix=/app/.heroku/vendor/
make && make install
cd ../ && rm -fr geos-3.5.0

wget http://download.osgeo.org/proj/proj-4.9.2.tar.gz
tar xvf proj-4.9.2.tar.gz
cd proj-4.9.2/
./configure --prefix=/app/.heroku/vendor/
make && make install
cd ../ && rm -fr proj-4.9.2

wget http://download.osgeo.org/gdal/2.0.1/gdal-2.0.1.tar.gz
tar xf gdal-2.0.1.tar.gz
cd gdal-2.0.1/
./configure --prefix=/app/.heroku/vendor/ \
    --with-jpeg \
    --with-png=internal \
    --with-geotiff=internal \
    --with-libtiff=internal \
    --with-libz=internal \
    --with-curl \
    --with-gif=internal \
    --with-geos=/app/.heroku/vendor/bin/geos-config \
    --with-proj-share=/app/.heroku/vendor/share \
    --without-expat \
    --with-threads \
    --with-ecw=/app/.heroku/vendor \
    -—with-mrsid=/app/.heroku/vendor \
    -—with-mrsid-lidar=/app/.heroku/vendor \
    --with-libkml=/app/.heroku/vendor \

make && make install
cd ../ && rm -fr gdal-2.0.1/

cd /app/.heroku/ && rm -f vendor.tar.gz
tar -zcvf vendor.tar.gz vendor/ && mv vendor.tar.gz /vagrant/