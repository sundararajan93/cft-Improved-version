#!/bin/bash

echo -e "Installing media wiki with Default DB Values...."
echo -e "Default Values"
echo -e "=============="


DBServer=$1 
DBUser=$2
DBpass=$3
Password=$4
IPAddr='13.235.241.147'

echo -e "Installing MediaWiki...\n"

cd /var/lib/wiki
php maintenance/install.php --dbserver=$DBServer --dbname='wikidb' --dbuser=$DBUser --dbpass=$DBpass --pass=$Password MediaWiki wiki && \
echo -e "Installed Mediawiki successfully"

echo -e "Configuring Public IP for Gridwiki" && \
sed -i 's/localhost/13.235.241.147/g' /var/www/html/wiki/LocalSettings.php && \
echo -e "Configured successfully!!!"
