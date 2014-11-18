#!/bin/bash

while getopts ":p:j:a:t:u:" opt; do
  case $opt in
    p) prog_args="$OPTARG"
    ;;
    a) java_args="$OPTARG"
    ;;
    j) jar_file="$OPTARG"
    ;;
    t) jar_source="$OPTARG"
    ;; 
    u) nexus_url="$OPTARG"
    ;; 
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

printf "Argument prog_args is %s\n" "$prog_args"
printf "Argument jar_file is %s\n" "$jar_file"
printf "Argument java_args is %s\n" "$java_args"
printf "Argument jar_source is %s\n" "$jar_source"
printf "Argument nexus_url is %s\n" "$nexus_url"

# jar_source can be nexus or artifact_service

cd /opt/serviceapp

if [ $jar_source = "artifact_service" ]; then

  echo getting from artifact service  
  
  base_name=${jar_file//\.jar/}

  echo http://192.168.59.103:8080/artifact/file/$base_name/jar
  echo
  
  wget http://192.168.59.103:8080/artifact/file/$base_name/jar
  
  ls
  
  mv jar $jar_file

  ls
  
else

  echo getting from nexus
  
  wget $nexus_url
  
fi

ls

echo JAVA COMMAND: $java_args -jar $jar_file $prog_args

java $java_args -jar $jar_file $prog_args
# && tail -f /opt/tomcat/logs/catalina.out 

