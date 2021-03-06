#! /usr/bin/bash

shopt -s extglob
# LC_COLLATE=C

tblList=($(ls))

if [[ ${#tblList[@]} != 0 ]]; then

    echo -n "enter the name of table to drop from ( ${tblList[*]} ) :  "
    read tblName

    check=`ls | grep "^$tblName$"`
    if [ "$check" = "" ]; then
        echo "this table doesn't exist";
        cd ..;
        . ../OptionDb.sh $1

    elif [ "$check" = "$tblName" ]; then
        rm $tblName;
        rm .metaData_$tblName;
        echo "table dropped successfully";
        cd ..;
        . ../OptionDb.sh $1
    fi
else
    echo -e "\n there is no table to delete \n";
    cd ..;
    . ../OptionDb.sh $1
fi
