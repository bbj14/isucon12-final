#!/bin/bash

set -xe
now=$(date +%Y%m%d-%H%M%S)
cd go && GOOS=linux GOARCH=amd64 go build -o isuconquest && cd -

for h in 1
do
   rsync -av  --exclude '.git' ./ isucon:/home/isucon/isucon12-final/webapp/
   ssh isucon mv /home/isucon/isucon12-final/webapp/go/isuconquest /home/isucon/webapp/go/isuconquest
   ssh isucon sudo systemctl restart isuconquest.go
   ssh isucon sudo cp /home/isucon/isucon12-final/webapp/nginx.conf /etc/nginx/nginx.conf
   ssh isucon sudo cp /home/isucon/isucon12-final/webapp/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
done

# nginx
for h in 1
do
   ssh isucon sudo touch /var/log/nginx/access.log
   ssh isucon sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
   ssh isucon sudo systemctl restart nginx
done

# mysql
for h in 1
do
   ssh isucon sudo touch /var/log/mysql/mysql-slow.log
   ssh isucon sudo mv /var/log/mysql/mysql-slow.log /var/log/mysql/mysql-slow.log.$now
   ssh isucon sudo mysqladmin flush-logs
   ssh isucon sudo systemctl restart mysql
done