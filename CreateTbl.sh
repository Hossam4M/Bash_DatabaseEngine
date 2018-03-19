#! /usr/bin/bash

echo -n "enter the name of table : "
read tblName

if [ "$tblName" = "" ]; then

    echo " table name can't be null";
    cd ..;
    . ../OptionDb.sh $1

elif [[ $tblName =~ ^[-.+0-9] ]]; then
    echo " invalid name for table -> it must start with character";
    cd ..;
    . ../OptionDb.sh $1

elif [[ $tblName =~ " "+ ]]; then
    echo " table name can't have spaces";
    cd ..;
    . ../OptionDb.sh $1

else
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
fi
