#!/bin/bash
#DAYLY STUD_DB
#for using Make initial deploy by Ansible script daily_stud_db

#ver 0.32 changed and added some functions:
#list CSV data files replaced to  daily_stud_db.sh
#added encrypted key block for secure  mount point key
#all cat $csv_list functions rewrite on for in {csv_list[@]} cycles
#added control list and t_control table in daily_stud_db



#vars:
null_=/dev/null
mnt_dir=/mnt/1c_univer
#dir for archive files
home_dir=/home/moodle
#dir for temp files for loading in student base
tmp_dir=/temp/
#current date
cdate=$(date +"%d%m%y")
#actual base date
#base_date=$(date +"%d%m%y" -d "1 day ago")
base_date=$cdate
mnt_log=/var/log/daily_stud_db/daily$cdate.log
#mysql_home
mysql_dir=/home/mysql/mysql_pass


csv_list=(
"zachetki.csv"
"distsipliny_UchPlana.csv"
"spetsialnosti.csv"
"profili.csv"
"sotrudniki.csv"
"nagruzka.csv"
"studenty.csv"
"uch_plan.csv"
"facultity.csv"
"cafedry.csv"
"distsipliny.csv"
"edudom_users.csv"
"level.csv"
)


#clear old .csv data files
erase()
{
for file in "${csv_list[@]}"; do
  rm -f "/temp/$file"
done
}


erase
#rm -f /temp/$(cat /home/mysql/csv_list)


#delete current log when restart
rm -f $mnt_log $2 > $null_


#add welcome string in log
echo "name: daily_stud_db$cdate" >> "$mnt_log"
echo "daily_stud_base.log" >> "$mnt_log"


#checking pass files and decript them
pass_dir="/root"
key_file="$pass_dir/.pk"
cred_file="$pass_dir/.cred.enc"

if [ -f "$key_file" ]; then
key=$(cat "$key_file")
else
echo "Error: $key_file not found."  >> "$mnt_log"
exit 1
fi

if [ -f "$cred_file" ]; then
decrypted_cred=$(openssl enc -d -aes-256-cbc -pbkdf2 -in /root/.cred.enc -k "$key")
else
echo "Error: $cred_file not found."  >> "$mnt_log"
exit 1
fi


#rm -f $mnt_log $2 > $null_

u_mount() {
        umount -f $mnt_dir
}

delimiter() {
        echo "-------------" >> "$mnt_log"
}



##when you have permitions
#sys_net_=$(curl -Is sstu-deps.sstudepsdom | head -1 | grep 403)
#if [ $? -eq 0 ]; then
#        echo "1c_univer available" >> "$mnt_log"
#else
#        echo "1c_univer not available" >> "$mnt_log"
#        exit
#fi


#check share for availability
smb_check_=$(smbclient -N -L sstu-deps.sstudepsdom | grep NT_STATUS_ACCESS_DENIED)
if [ $? -eq 0 ]; then
      echo "1c_univer available" >> "$mnt_log"
  else
      echo "1c_univer not available" >> "$mnt_log"
  exit 1
fi


u_mount $2 > $null_


delimiter

#mount share
mount.cifs //sstu-deps.sstudepsdom/uit/ois/Temp /mnt/1c_univer ro, -o $(echo "$decrypted_cred") $2 >> "$mnt_log"

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
for csv_file in "${csv_list[@]}"; do
  if [ -z "$(find $mnt_dir -name "$csv_file*" 2> /dev/null)" ]; then
        echo "$csv_file not found" >> "$mnt_log"
    else
        echo "$csv_file found" >> "$mnt_log"
fi
done


#get first not found
for csv_file in "${csv_list[@]}"; do
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

#copy new csv datafile in temp
for csv_file in "${csv_list[@]}"; do cp "$mnt_dir/$csv_file" $tmp_dir; done


delimiter
#check tar.gz archive exists
if [ -z "$(find $home_dir -name "daily_stud_db$base_date.tar.gz" 2> /dev/null)" ]; then
        echo "daily_stud_db$base_date.tar.gz created" >> "$mnt_log"
	tar -czvf "$home_dir/daily_stud_db$base_date.tar.gz" -C "$tmp_dir" "${csv_list[@]}" >> "$mnt_log"

else
        echo "file daily_stud_db$base_date.tar.gz exists" >> "$mnt_log"
fi

u_mount


csv_list="/temp/list.csv"

#add control string in csv file
append_to_list_(){
# Get the current number
    current_number=$(wc -l < $csv_list)
    current_number=$((current_number + 1))
# Get the current date
   current_date=$(date +"%d:%m:%y")
# Append the data to the CSV file
   echo "$current_number;$current_date" >> $csv_list
}


append_to_list() {
  # Get the current number
  current_number=$(wc -l < "$csv_list")
  current_number=$((current_number + 1))
  # Format the number as a two-digit number with leading zeros
  formatted_number=$(printf "%02d" $current_number)
  # Get the current date
  current_date=$(date +"%d:%m:%y")
  # Append the data to the CSV file
  echo "$current_number;$current_date" >> "$csv_list"
}



#check csv control list
if [ -f "$csv_list" ]; then
  append_to_list
else
  touch /temp/list.csv
  append_to_list
fi

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


#podman restart mysql container test string
podman restart mysql-agent
echo "container mysql-agent restarted"

#podman restart mysql container test string
podman restart daily_stud_db
echo "container daily_stud_db restarted"

delimiter































