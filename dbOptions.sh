#! /usr/bin/bash

echo -n " enter your SQL statement -> "
read -a sqlarr

sql=${sqlarr[*]}

query=`echo $sql | cut -f1 -d" "`
queryCheck=`echo $sql | cut -f2 -d" "`

case $query in
    "use" )
        if [ "$queryCheck" = "database" ]; then
            cd ../.. ; . ./useDb.sh "$sql";
        else
            echo -e "\n Error in syntax !!!! \n" ;
            . ../../dbOptions.sh;
        fi
        ;;
    "create" ) . ../../createTbl.sh "$sql"
        ;;
    "drop" ) . ../../deleteTbl.sh "$sql"
        ;;
    "insert" ) . ../../insertTbl.sh "$sql"
        ;;
    "exit" ) exit
        ;;
    * )
        echo -e "\n Error in syntax !!!! \n" ;
        . ../../dbOptions.sh
        ;;

esac
