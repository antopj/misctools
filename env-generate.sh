#!/usr/bin/bash

#considering current working directory name as site name /var/www/example.com/
SITENAME=${PWD##*/}

echo "WP_ENV=production" >>htdocs/.env
echo "WP_HOME=https://$SITENAME" >>htdocs/.env
echo "WP_SITEURL=https://$SITENAME/wp" >>htdocs/.env

echo "###">>htdocs/.env

echo "DB_NAME=`cat wp-config.php | grep DB_NAME | cut -d \' -f 4`">> htdocs/.env
echo "DB_USER=`cat wp-config.php | grep DB_USER | cut -d \' -f 4`">> htdocs/.env
echo "DB_PASSWORD=`cat wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`">> htdocs/.env
echo "DB_HOST=`cat wp-config.php | grep DB_HOST | cut -d \' -f 4`">> htdocs/.env

#Download salts and save to file
wget -O /tmp/wp.keys https://api.wordpress.org/secret-key/1.1/salt/

#parse the key-values into variables

echo "AUTH_KEY=$(cat /tmp/wp.keys |grep -w AUTH_KEY | cut -d \' -f 4)" >> htdocs/.env
echo "SECURE_AUTH_KEY=$(cat /tmp/wp.keys |grep -w SECURE_AUTH_KEY | cut -d \' -f 4)" >> htdocs/.env
echo "LOGGED_IN_KEY=$(cat /tmp/wp.keys |grep -w LOGGED_IN_KEY | cut -d \' -f 4)" >> htdocs/.env
echo "NONCE_KEY=$(cat /tmp/wp.keys |grep -w NONCE_KEY | cut -d \' -f 4)" >> htdocs/.env
echo "AUTH_SALT=$(cat /tmp/wp.keys |grep -w AUTH_SALT | cut -d \' -f 4)" >> htdocs/.env
echo "SECURE_AUTH_SALT=$(cat /tmp/wp.keys |grep -w SECURE_AUTH_SALT | cut -d \' -f 4)" >> htdocs/.env
echo "LOGGED_IN_SALT=$(cat /tmp/wp.keys |grep -w LOGGED_IN_SALT | cut -d \' -f 4)" >> htdocs/.env
echo "NONCE_SALT=$(cat /tmp/wp.keys |grep -w NONCE_SALT | cut -d \' -f 4)" >> htdocs/.env


#2nd Method for Salts

# echo "AUTH_KEY=\"`cat /tmp/wp.keys |grep -w AUTH_KEY | cut -d \' -f 4`\"" >> htdocs/.env
# echo "SECURE_AUTH_KEY=\"`cat /tmp/wp.keys |grep -w SECURE_AUTH_KEY | cut -d \' -f 4`\"" >> htdocs/.env
# echo "LOGGED_IN_KEY=\"`cat /tmp/wp.keys |grep -w LOGGED_IN_KEY | cut -d \' -f 4`\"" >> htdocs/.env
# echo "NONCE_KEY=\"`cat /tmp/wp.keys |grep -w NONCE_KEY | cut -d \' -f 4`\"" >> htdocs/.env
# echo "AUTH_SALT=\"`cat /tmp/wp.keys |grep -w AUTH_SALT | cut -d \' -f 4`\"" >> htdocs/.env
# echo "SECURE_AUTH_SALT=\"`cat /tmp/wp.keys |grep -w SECURE_AUTH_SALT | cut -d \' -f 4`\"" >> htdocs/.env
# echo "LOGGED_IN_SALT=\"`cat /tmp/wp.keys |grep -w LOGGED_IN_SALT | cut -d \' -f 4`\"" >> htdocs/.env
# echo "NONCE_SALT=\"`cat /tmp/wp.keys |grep -w NONCE_SALT | cut -d \' -f 4`\"" >> htdocs/.env

#remove key file
rm /tmp/wp.keys

echo "DISABLE_WP_CRON=true" >> htdocs/.env
echo "WP_CACHE_KEY_SALT=$SITENAME:" >> htdocs/.env

echo "###" >> htdocs/.env


echo "\n\n.env Generated, using https as scheme in WP_HOME and WP_SITEURL...\n\n"
