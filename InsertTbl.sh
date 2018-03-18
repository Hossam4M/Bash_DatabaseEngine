#! /usr/bin/bash

shopt -s extglob
# LC_COLLATE=C

echo -n "enter the name of table : "
read tblName

check=`ls | grep "^$tblName$"`

if [ "$check" = "" ]; then
    echo "this table doesn't exist";
    cd ..;
    . ../OptionDb.sh $1

elif [ "$check" = "$tblName" ]; then
    lineNo=`wc -l metaData_$tblName | cut -f1 -d" "`
    recordNo=`wc -l $tblName | cut -f1 -d" "`
    let recordNo=recordNo+1

    for (( i = 1; i <= $lineNo; i++ )); do
        qflag="true"
        colName=`awk -F: '{ if (NR == "'$i'") print $1 }' metaData_$tblName`
        dataType=`awk -F: '{ if (NR == "'$i'") print $2 }' metaData_$tblName`

        if [ $i -eq 1 ]; then
            . ../../checkPrimary.sh $colName $dataType $qflag $tblName
        elif [ $i -ne 1 ]; then
            . ../../checkNonPrimary.sh $colName $dataType $qflag $tblName $recordNo
        fi

    done
    cd ..;
    . ../OptionDb.sh $1
fi
