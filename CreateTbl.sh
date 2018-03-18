#! /usr/bin/bash

echo -n "enter the name of table : "
read tblName

if [ "$tblName" = "" ]; then
    echo " table name can't be null";
    cd ..;
    . ../OptionDb.sh $1

check=`ls | grep "^$tblName$"`

if [ "$check" = "" ]; then
    touch $tblName;
    touch metaData_$tblName
    echo "table created successfully";
    . ../../CreateDetailTbl.sh $1 $tblName

elif [ "$check" = "$tblName" ]; then
    echo "this table is already exists";
    cd ..;
    . ../OptionDb.sh $1
fi
