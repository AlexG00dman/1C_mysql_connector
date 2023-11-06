#!/bin/bash
#EXPORT DAYLY STUD_DB
#for using Make initial deploy by Ansible script dayly_stud_db

#vars:
null_=/dev/null
mnt_dir=/mnt/1c_univer
#dir for temp files for loading in student base
tmp_dir=/temp
cdate=$(date +"%d%m%y")
#actual base date
#base_date=$(date +"%d%m%y" -d "1 day ago")
base_date=$cdate
mnt_log=/var/log/daily_stud_db/export$cdate.log
#mysql_home
mysql_dir=/home/mysql/mysql_pass
#mysql /var/lib/mysql-files/ docker files
df=/var/lib/mysql-files/

pass_=$(grep MYSQL_PASSWORD: $mysql_dir | sed 's/^.*: //')
echo $pass_


smb_check_=$(smbclient -N -L my_domain | grep NT_STATUS_ACCESS_DENIED)
if [ $? -eq 0 ]; then
        echo "1c_univer available" >> "$mnt_log"
else
        echo "1c_univer not available" >> "$mnt_log"
        exit 1
fi


#sys_net_=$(curl -Is my_domain | head -1 | grep 403)
#if [ $? -eq 0 ]; then
#        echo "1c_univer available" >> "$mnt_log"
#else
#        echo "1c_univer not available" >> "$mnt_log"
#        exit
#fi


erase()
{
docker exec daily_stud_db /bin/rm -f $df/op_students.csv $df/op_stud_info_ad.csv $2 > $null_
}

u_mount()
{
        umount -f $mnt_dir
}

delimiter()
{
        echo "-------------" >> $mnt_log
}

rm -f $mnt_log $2 > $null_


erase
#export files from current_db
docker exec daily_stud_db /bin/mysql -u mysql --password=$pass_ current$base_date --execute "SELECT 'usename', 'lastname', 'firstname', 'email', 'description', 'cohort1', 'auth', 'idnumer', 'lang', 'password' UNION ALL SELECT * FROM op_students INTO OUTFILE '/var/lib/mysql-files/op_students.csv' FIELDS TERMINATED BY ';' ;"

docker exec daily_stud_db /bin/mysql -u mysql --password=$pass_ current$base_date  --execute "SELECT number, full_name, replace(description, '\r', '') as description, bdate FROM op_students_info_ad INTO OUTFILE '/var/lib/mysql-files/op_stud_info_ad.csv' FIELDS TERMINATED BY ';';"


echo "$cdate" >> "$mnt_log"
delimiter
echo "mount and prepare some files for export" >> $mnt_log
delimiter

u_mount $2 > /dev/null

mount -t cifs --rw -o credentials=/root/credential //my_domain/uit/ois/Temp $mnt_dir

#get exit by mount error
mnt_err_code=$?
if [ $mnt_err_code -ne 0 ]; then
        echo "mount with error $mnt_err_code" >> $mnt_log
        exit 1
else
        echo "mount has success" >> $mnt_log
fi


delimiter
cp $tmp_dir/op_stud_info_ad.csv $tmp_dir/op_students.csv $mnt_dir/moodle/
erase
u_mount
echo "op_students.csv op_stud_info_ad.csv...were copied" >> $mnt_log

