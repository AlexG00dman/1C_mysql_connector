#!/bin/sh
#vars contant section
log_file="/tmp/log/mysql_agent.log"
mysql_agent_dir=/tmp/mysql_agent
c_okpm_list="$mysql_agent_dir/c_okpm_list.csv"
skey=$(cat /run/secrets/skey)


#log string function
log_message() {
     local timestamp=$(date +"%d.%m.%Y %H:%M:%S")
     echo "[$timestamp] [$status] '$result'"]
}


get_stud_raw() {
mysql -h "$host" -u "$dbuser" --password="$skey" --database "$database" -e 'SELECT username, lastname, firstname, email,description, auth, username as idnumber, lang, password, deleted FROM mdl_user where username REGEXP "[0-9]" and description != " " and deleted !=1;' | sed 's/\t/;/g' > "$mysql_agent_dir/std_out.csv"
}


#get err status
result=$(mysql -h "$host" -u "$dbuser" --password="$skey" --database "$database" -e 'SELECT username, lastname, firstname, email,description, auth, username as idnumber, lang, password, deleted FROM mdl_user where username REGEXP "[0-9]" and description != " " and deleted !=1;' 2>&1)



#checking status and write logs
if [ $? !=  0 ]; then
    status="ERROR"
    log_message "$result" >> "$log_file"
    exit 1
else
    status="INFO"
    result="csv file was obtained succesfully"
    log_message "$result"  >> "$log_file"
    get_stud_raw
fi


append_to_list() {
  # Get the current number
  curr_num=$(wc -l < "$c_okpm_list")
  curr_num=$((curr_num + 1))
  l_date=$(date -r "$c_okpm_list" '+%d.%m.%Y %T')
  # Format the number as a two-digit number with leading zeros
  # formatted_number=$(printf "%02d" $current_number)
  # # Get the current date
  ##curr_date=$(date +"%d:%m:%y")
  # Append the data to the CSV file
  echo "$curr_num;$l_date" >> "$c_okpm_list"
}


#check csv control list
if [ -f "$c_okpm_list" ]; then
  append_to_list
else
  touch "$c_okpm_list"
  append_to_list
fi

