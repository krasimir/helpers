#!/bin/bash

if [ "$1" = "" ]
then
    echo "Missing virtual host. Exiting."
    exit
fi

sudo mv /etc/nginx/sites-enabled/$1 /etc/nginx/sites-available/
