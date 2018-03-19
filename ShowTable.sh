#! /usr/bin/bash

shopt -s extglob
# LC_COLLATE=C

echo -n "enter the name of table to show : "
read tblName

check=`ls | grep "^$tblName$"`

if [ "$check" = "" ]; then
    echo "this table doesn't exist";
    cd ..;
    . ../OptionDb.sh $1

elif [ "$check" = "$tblName" ]; then

    echo
    awk -F: '{ print $0 }' $tblName;
    echo

    cd ..;
    . ../OptionDb.sh $1
fi
