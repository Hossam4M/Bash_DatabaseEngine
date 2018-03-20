#! /usr/bin/bash

dbList=($(ls repo))

if [[ ${#dbList[@]} != 0 ]]; then
    echo "enter the name of database to drop from ( ${dbList[*]} ) : "
    read dbName

    check=`ls repo | grep "^$dbName$"`
    if [ "$check" = "" ]; then
        echo "this database doesn't exist";
        . ./EntryPoint.sh

    elif [ "$check" = "$dbName" ]; then
        rm -R repo/$dbName
        echo "database dropped successfully";
        . ./EntryPoint.sh
    fi
else
    echo -e "\nthere is no database to drop !!!!\n"
    . ./EntryPoint.sh
fi
