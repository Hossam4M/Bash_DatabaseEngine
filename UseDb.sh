#! /usr/bin/bash

dbList=($(ls repo))

if [[ ${#dbList[@]} != 0 ]]; then

    echo "enter the name of database to use from ( ${dbList[*]} ) : "
    read dbName

    check=`ls repo | grep "^$dbName$"`
    if [ "$check" = "" ]; then
        echo "this database doesn't exist";
        . ./EntryPoint.sh

    elif [ "$check" = "$dbName" ]; then
        cd repo
        echo "$dbName in use now";
        . ../OptionDb.sh $dbName
    fi
else
    echo -e "\nthere is no database to use !!!!\n"
    . ./EntryPoint.sh
fi
