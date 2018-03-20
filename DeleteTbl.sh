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

        colName=`awk -F: '{ if (NR == 1) print $1 }' .metaData_$tblName`
        dataType=`awk -F: '{ if (NR == 1) print $2 }' .metaData_$tblName`

        echo -n " enter the value of $colName ( $dataType ) -> PrimaryKey for record to delete : "
        read answer

        list=`awk -F: '{ print $1 }' $tblName | grep "^$answer$"`

        if [ "$list" = "" ]; then
            echo " this record does't exist "
        else
            i=`awk -F: '{ if ($1 == "'$answer'") print NR }' $tblName`;
            sed ''$i'd' $tblName > temp.tmp && mv temp.tmp $tblName
        fi

    fi
else
    echo -e "\n there is no table to delete \n"
fi

cd ..;
. ../OptionDb.sh $1
