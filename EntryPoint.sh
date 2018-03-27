#! /usr/bin/bash

check=`ls | grep "^repo$"`
if [ "$check" = "" ]; then
    mkdir repo
fi

echo -n " enter your SQL statement -> "
read -a sqlarr

sql=${sqlarr[*]}
query=`echo $sql | cut -f1 -d" "`

case $query in
    "use" ) . ./useDb.sh "$sql"
        ;;
    "create" ) . ./createDb.sh "$sql"
        ;;
    "drop" ) . ./deleteDb.sh "$sql"
        ;;
    "show" ) . ./showDb.sh "$sql"
        ;;
    "exit" ) exit
        ;;
    * ) echo -e "\n Error in syntax !!!! \n" ;
        . ./EntryPoint.sh
        ;;

esac
