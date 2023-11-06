#!/bin/bash
#DAYLY STUD_DB
#for using Make initial deploy by Ansible script dayly_stud_db

#vars:
null_=/dev/null
mnt_dir=/mnt/1c_univer
#dir for archive files
home_dir=/home/moodle
#dir for temp files for loading in student base
tmp_dir=/temp/
#daily_stud_db date
cdate=$(date +"%d%m%y")
#actual base date
#base_date=$(date +"%d%m%y" -d "1 day ago")
bdate=$cdate
mnt_log=/var/log/daily_stud_db/daily$cdate.log
csv_list=/home/mysql/csv_list
#mysql_home
mysql_dir=/home/mysql/mysql_pass


rm -f $mnt_log $2 > $null_
#rm -f /temp/$(cat /home/mysql/csv_list)

u_mount()
{
        umount -f $mnt_dir
}

delimiter()
{
        echo "-------------" >> "$mnt_log"
}


erase()
{
        rm -f /temp/$(cat $csv_list)
}


erase
delimiter
echo "name: daily_stud_db$cdate" >> "$mnt_log"
echo "daily_stud_base.log" >> "$mnt_log"


##when you have permitions
#sys_net_=$(curl -Is my_domain | head -1 | grep 403)
#if [ $? -eq 0 ]; then
#        echo "1c_univer available" >> "$mnt_log"
#else
#        echo "1c_univer not available" >> "$mnt_log"
#        exit
#fi


smb_check_=$(smbclient -N -L my_domain | grep NT_STATUS_ACCESS_DENIED)
if [ $? -eq 0 ]; then
        echo "1c_univer available" >> "$mnt_log"
else
        echo "1c_univer not available" >> "$mnt_log"
        exit 1
fi


u_mount $2 > $null_

delimiter

mount -t cifs -o credentials=/root/credential //my_domain $mnt_dir -o ro $2 >> "$mnt_log"

#get exit by mount error
mnt_err_code=$?
if [ $mnt_err_code -ne 0 ]; then
        echo "mount with error $mnt_err_code" >> "$mnt_log"
        exit 1
else
        echo "mount has success" >> "$mnt_log"
fi

delimiter


#check files in mountdir
if [ -z "`ls $mnt_dir`" ]; then
	echo "mount dir is empty" >> "$mnt_log"
        u_mount
	exit 1
else

	echo "mount dir is not empty" >> "$mnt_log"
fi


delimiter
#make not found list
cat $csv_list |
while read csv_file; do
if [ -z "$(find $mnt_dir -name "$csv_file*" 2> /dev/null)" ]; then
        echo "$csv_file not found" >> "$mnt_log"
else
        echo "$csv_file found" >> "$mnt_log"
fi
done


#get first not found
cat $csv_list |
while read csv_file; do
if [ -z "$(find $mnt_dir -name "$csv_file*" 2> $null_)" ]; then
        echo "$csv_file not found"
        exit 1
else
        echo "$csv_file found" $2 > $null_
fi
done

#exit by first not found

if ! [ $? -eq 0 ]; then
        echo "exit on first 'not found'" > $null_;
        exit 1
fi


cat $csv_list | while read csv_file; do cp "$mnt_dir/$csv_file" $tmp_dir; done

delimiter

#check zip archive exists
if [ -z "$(find $home_dir -name "daily_stud_db$base_date.zip" 2> /dev/null)" ]; then
        echo "daily_stud_db$base_date.zip created"  >>  "$mnt_log"
        cat $csv_list | while read csv_file; do zip -j "$home_dir/daily_stud_db$base_date.zip" "$tmp_dir/$csv_file" -x $home_dir >> "$mnt_log"; done
else
        echo "file daily_stud_db$base_date.zip exists" >> "$mnt_log"
fi

u_mount

#set actual name with daily_stud_db day
sed -i 's/daily_stud_db\([0-9]\{6\}\)/'daily_stud_db$base_date'/g' /home/mysql/init.sql


#Error response from daemon: No such container: mysql
#mysql

#get docker status
#docker_status_code=$?
#echo $docker_status_code
#if [ $docker_status_code -ne 0 ]; then
#        echo "docker is down $docker_status_code" >> "$mnt_log"
#        exit 1
#else
#        echo "docker is up" >> "$mnt_log"
#fi



#docker restart mysql container
docker restart daily_stud_db
