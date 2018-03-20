#! /usr/bin/bash

cd repo

wordNo=`echo $1 | wc -w`

if [[ $wordNo == 2 ]]; then

    dbName=`echo $1 | cut -f2 -d" "`
    check=`ls | grep "^$dbName$"`

    if [ "$check" = "" ]; then
        echo -e "\n this database doesn't exist !!! \n";
        cd ..;
        . ./EntryPoint.sh
    else
        echo -e "\n $dbName is in use \n";
        cd $dbName;
        . ../../dbOptions.sh
    fi

else
    echo -e "\n Error in syntax !!! \n";
    cd ..;
    . ./EntryPoint.sh
fi
