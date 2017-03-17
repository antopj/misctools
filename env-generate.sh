#!/usr/bin/bash
                              #########  created by Anto  ##########

#!IMPORTANT
#execute this script from same directory where wp-config.php exists

#considering current working directory name as site name /var/www/example.com/

SITENAME=${PWD##*/}

echo "WP_ENV=dev" > .env
echo "WP_HOME=http://$SITENAME" >> .env
echo "WP_SITEURL=http://$SITENAME/wp" >> .env

echo "#-----------\n">> .env

echo "DB_NAME=`cat wp-config.php | grep DB_NAME | cut -d \' -f 4`">>  .env
echo "DB_USER=`cat wp-config.php | grep DB_USER | cut -d \' -f 4`">>  .env
echo "DB_PASSWORD=`cat wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`">>  .env
echo "DB_HOST=`cat wp-config.php | grep DB_HOST | cut -d \' -f 4`">>  .env

echo "#-----------\n">> .env

#Download salts and save to file
wget -qO /tmp/wp.keys https://api.wordpress.org/secret-key/1.1/salt/

#parse the key-values into variables

echo "AUTH_KEY=$(cat /tmp/wp.keys |grep -w AUTH_KEY | cut -d \' -f 4)" >>  .env
echo "SECURE_AUTH_KEY=$(cat /tmp/wp.keys |grep -w SECURE_AUTH_KEY | cut -d \' -f 4)" >>  .env
echo "LOGGED_IN_KEY=$(cat /tmp/wp.keys |grep -w LOGGED_IN_KEY | cut -d \' -f 4)" >>  .env
echo "NONCE_KEY=$(cat /tmp/wp.keys |grep -w NONCE_KEY | cut -d \' -f 4)" >>  .env
echo "AUTH_SALT=$(cat /tmp/wp.keys |grep -w AUTH_SALT | cut -d \' -f 4)" >>  .env
echo "SECURE_AUTH_SALT=$(cat /tmp/wp.keys |grep -w SECURE_AUTH_SALT | cut -d \' -f 4)" >>  .env
echo "LOGGED_IN_SALT=$(cat /tmp/wp.keys |grep -w LOGGED_IN_SALT | cut -d \' -f 4)" >>  .env
echo "NONCE_SALT=$(cat /tmp/wp.keys |grep -w NONCE_SALT | cut -d \' -f 4)" >>  .env


#2nd Method for Salts

# echo "AUTH_KEY=\"`cat /tmp/wp.keys |grep -w AUTH_KEY | cut -d \' -f 4`\"" >>  .env
# echo "SECURE_AUTH_KEY=\"`cat /tmp/wp.keys |grep -w SECURE_AUTH_KEY | cut -d \' -f 4`\"" >>  .env
# echo "LOGGED_IN_KEY=\"`cat /tmp/wp.keys |grep -w LOGGED_IN_KEY | cut -d \' -f 4`\"" >>  .env
# echo "NONCE_KEY=\"`cat /tmp/wp.keys |grep -w NONCE_KEY | cut -d \' -f 4`\"" >>  .env
# echo "AUTH_SALT=\"`cat /tmp/wp.keys |grep -w AUTH_SALT | cut -d \' -f 4`\"" >>  .env
# echo "SECURE_AUTH_SALT=\"`cat /tmp/wp.keys |grep -w SECURE_AUTH_SALT | cut -d \' -f 4`\"" >>  .env
# echo "LOGGED_IN_SALT=\"`cat /tmp/wp.keys |grep -w LOGGED_IN_SALT | cut -d \' -f 4`\"" >>  .env
# echo "NONCE_SALT=\"`cat /tmp/wp.keys |grep -w NONCE_SALT | cut -d \' -f 4`\"" >>  .env

#remove key file
rm /tmp/wp.keys

echo "DISABLE_WP_CRON=true" >>  .env
echo "WP_CACHE_KEY_SALT=$SITENAME:" >>  .env

echo "#-----------\n">> .env

echo "\n\n.env Generated, using http a scheme in WP_HOME and WP_SITEURL...\n\n"
