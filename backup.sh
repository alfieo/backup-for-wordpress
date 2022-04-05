#!/bin/bash
#make sure you are on the home directory of the website for example /home/user where WEBROOT of your website is on.

BKPDIR=/mnt/backup/
WEBROOT=public_html
ACCNAME=test.com

DBUSER=$(grep DB_USER $WEBROOT/wp-config.php | awk -F\' '{print$4}')
DBNAME=$(grep DB_NAME $WEBROOT/wp-config.php | awk -F\' '{print$4}')
DBHOST=$(grep DB_HOST $WEBROOT/wp-config.php | awk -F\' '{print$4}')
DBPASSWORD=$(grep DB_PASSWORD $WEBROOT/wp-config.php | awk -F\' '{print$4}')
DBDUMP="$DBNAME"_$(date +"%Y-%m-%d-%H-%M").sql
FILENAME="$ACCNAME"_$(date +"%Y-%m-%d_%H-%M").tar.gz

#In case you want to rsync backups to remote server
#RUSER=remoteuser
#RHOST=remoteserver
#RDIR=/remote/backup/directory/
#RSSHPORT=22
#rsync -az $BKPDIR -e "ssh -p $RSSHPORT" $RUSER@$RHOST:$RDIR

mysqldump -h $DBHOST -u $DBUSER -p$DBPASSWORD $DBNAME > $DBDUMP

tar -czf $FILENAME $WEBROOT $DBDUMP



mv $FILENAME $BKPDIR
