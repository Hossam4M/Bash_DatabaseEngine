#! /usr/bin/bash

cd repo

echo -n "enter the name of database : "
read dbName

if [ "$dbName" = "" ]; then
    echo " dataBase name can't be null";
    cd ..;
    . ./EntryPoint.sh

elif [[ $dbName =~ " "+ ]]; then
    echo " dataBase name can't have spaces";
    cd ..;
    . ./EntryPoint.sh

elif [[ $dbName =~ ^[-.+0-9] ]]; then
    echo " invalid name for dataBase -> it must start with character";
    cd ..;
    . ./EntryPoint.sh

else
    check=`ls | grep "^$dbName$"`
    if [ "$check" = "" ]; then
        mkdir $dbName;
        echo "database created successfully";
        . ../OptionDb.sh $dbName

    elif [ "$check" = "$dbName" ]; then
        echo "this database is already exists";
        cd ..;
        . ./EntryPoint.sh
    fi
fi
