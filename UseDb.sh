#! /usr/bin/bash

echo "enter the name of database to use from ( `ls repo` ) : "
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
