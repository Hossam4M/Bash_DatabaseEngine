#! /usr/bin/bash

shopt -s extglob
# LC_COLLATE=C

tblList=($(ls))

if [[ ${#tblList[@]} != 0 ]]; then
    echo -n "enter the name of table from ( ${tblList[*]} ) :  "
    read tblName

    check=`ls | grep "^$tblName$"`

    if [ "$check" = "" ]; then

        echo "this table doesn't exist";

    else

        echo -n " enter the value of $colName ( $dataType ) -> PrimaryKey for record to show : "
        read answer

        list=`awk -F: '{ print $1 }' $tblName | grep "^$answer$"`

        if [ "$list" = "" ]; then
            echo " this record does't exist "
        else
            echo
            awk -F: '{ if ($1 == "'$answer'") print $0 }' $tblName ;
            echo
        fi
    fi
else
    echo -e "\n there is no table to show !!!! \n"
fi


cd ..;
. ../OptionDb.sh $1
