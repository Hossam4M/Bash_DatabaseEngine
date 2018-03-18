#! /usr/bin/bash

echo "enter the name of database to drop from ( `ls repo` ) : "
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