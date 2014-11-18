#!/bin/bash

while getopts ":a:w:" opt; do
  case $opt in
    a) p_out="$OPTARG"
    ;;
    w) war_file="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

printf "Argument p_out is %s\n" "$p_out"
printf "Argument war_file is %s\n" "$war_file"


echo The war_loc is $war_loc 
mkdir /tmp/wars
chmod 777 /tmp/wars

cd /tmp/wars

wget http://192.168.59.103:8080/artifact/file/$war_file


mv $war_file /opt/tomcat/webapps/$war_file

ls /opt/tomcat/webapps

service tomcat7 start && tail -f /opt/tomcat/logs/catalina.out 

