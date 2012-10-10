#!/bin/bash
 
### Configure email and vhost dir
email='info@krasimirtsonev.com'  # email address of administrator
vhroot='/etc/apache2/sites-enabled'   # no trailing slash
iserror='no'
hosterror=''
direrror=''
 
# Take inputs host name and root directory
echo -e "Please provide hostname. e.g.dev,staging"
read  hostname
echo -e "Please provide web root directory. e.g. /websites/dev,e.g. /websites/staging"
read rootdir
 
### Check inputs
if [ "$hostname" = "" ]
then
    iserror="yes"
    hosterror="Please provide domain name."
fi
 
if [ "$rootdir" = "" ]
then
    iserror="yes"
    direrror="Please provide web root directory name."
fi
 
### Displaying errors
if [ "$iserror" = "yes" ]
then
    echo "Please correct following errors:"
    if [ "$hosterror" != "" ]
    then
        echo "$hosterror"
    fi
 
    if [ "$direrror" != "" ]
    then
        echo "$direrror"
    fi
    exit;
fi
 
### check whether hostname already exists
if [ -e $vhroot"/"$hostname ]; then
    iserror="yes"
    hosterror="Hostname already exists. Please provide another hostname."
fi
 
### check if directory exists or not
if ! [ -d $rootdir ]; then
    iserror="yes"
    direrror="Directory provided does not exists.";
fi
 
### Displaying errors
if [ "$iserror" = "yes" ]
then
    echo "Please correct following errors:"
    if [ "$hosterror" != "" ]
    then
        echo "$hosterror"
    fi
 
    if [ "$direrror" != "" ]
    then
        echo "$direrror"
    fi
    exit;
fi
 
if ! touch $vhroot/$hostname
then
        echo "ERROR: "$vhroot"/"$hostname" could not be created."
else
        echo "Virtual host document root created in "$vhroot"/"$hostname
fi
 
if ! echo "<VirtualHost *:80>
ServerName $hostname
ServerAlias www.$hostname
DocumentRoot \"$rootdir\"
<Directory \"$rootdir\">
Options Indexes FollowSymLinks
AllowOverride All
Order allow,deny
allow from all
</Directory>
</VirtualHost>" > $vhroot/$hostname
then
        echo "ERROR: the virtual host could not be added."
else
        echo "New virtual host added to the Apache vhosts file"
fi
 
### Add hostname in /etc/hosts
if ! echo "127.0.0.1       $hostname" >> /etc/hosts
then
    echo "ERROR: Not able write in /etc/hosts"
else
    echo "Host added to /etc/hosts file"
fi
 
### give permission to root dir
chmod 755 $rootdir
 
# show the finished message
echo "Complete! The new virtual host has been created."