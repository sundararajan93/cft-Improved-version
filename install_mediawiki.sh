#!/bin/bash

echo -e "Installing media wiki with Default DB Values...."
echo -e "Default Values"
echo -e "=============="


DBServer=$(aws secretsmanager get-secret-value --secret-id rdsdbpassword | grep SecretString | awk '{print $2}' | sed 's/\\//g' | cut -d "\"" -f 19)
DBUser=$(aws secretsmanager get-secret-value --secret-id rdsdbpassword | grep SecretString | awk '{print $2}' | sed 's/\\//g' | cut -d "\"" -f 23)
DBpass=$(aws secretsmanager get-secret-value --secret-id rdsdbpassword | grep SecretString | awk '{print $2}' | sed 's/\\//g' | cut -d "\"" -f 5)
Password=$(aws secretsmanager get-secret-value --secret-id rdsdbpassword | grep SecretString | awk '{print $2}' | sed 's/\\//g' | cut -d "\"" -f 5)
IPAddr='15.206.80.42'

echo -e "Installing MediaWiki...\n"

cd /var/lib/wiki
php maintenance/install.php --dbserver=$DBServer --dbname='wikidb' --dbuser=$DBUser --dbpass=$DBpass --pass=$Password MediaWiki wiki && \
echo -e "Installed Mediawiki successfully"

echo -e "Configuring Public IP for Gridwiki" && \
sed -i 's/localhost/15.206.80.42/g' /var/www/html/wiki/LocalSettings.php && \
echo -e "Configured successfully!!!"