#! /usr/bin/bash

cd repo

wordNo=`echo $1 | wc -w`

if [[ $wordNo == 3 ]]; then

    checkType=`echo $1 | cut -f2 -d" "`

    if [ "$checkType" = "table" ]; then
        echo -e "\n You must use a database first  !!! \n"

    elif [ "$checkType" = "database" ]; then
        dbName=`echo $1 | cut -f3 -d" "`
        check=`ls | grep "^$dbName$"`

        if [ "$check" = "" ]; then
            mkdir $dbName
            echo -e "\n database created successfully \n"
            cd $dbName;
            . ../../dbOptions.sh
        else
            echo -e "\n this database is already created !!! \n"
        fi
    else
        echo -e "\n Error in syntax !!! \n";
    fi

else
    echo -e "\n Error in syntax !!! \n";
fi

cd ..;
. ./EntryPoint.sh
