#!/bin/bash
#DAYLY STUD_DB

#set actual_name with current date
sed -i 's/daily_stud_db\([0-9]\{6\}\)/'daily_stud_db$base_date'/g' /home/mysql/daily_stud_db.sql
#run mysql section scripts
mysql -u mysql  -p "$MYSQL_ROOT_PASSWORD" < /docker-entrypoint-initdb.d/daily_stud_db.sql

