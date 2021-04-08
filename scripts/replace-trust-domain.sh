#!/usr/bin/env bash

if [ -z "$1" ]; then 
    echo 'Please pass a trust domain'
    exit 1
fi

sed -i "s/example.com/$1/g" *.conf
sed -i "s/example.com/$1/g" *.md
sed -i "s/example.com/$1/g" scripts/*.sh
