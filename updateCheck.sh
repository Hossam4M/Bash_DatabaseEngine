#! /usr/bin/Bash

shopt -s extglob

. ../../functions.sh

qExit="true"
dataType=`awk -F: '{ if (NR == "'$1'") print $2 }' .metaData_$3`

while [ "$qExit" == "true" ]; do

    echo -n "enter the new value of $2 ( $dataType ) : "
    read entry

    if [ "$1" -eq 1 ]; then
        isNull $entry

        if [ $check -eq 0 ]; then
            updatePrimary $entry $dataType $3 $1 $4

        elif [ $check -eq 1 ]; then
            echo "this is PrimaryKey Field !!! it can not be null"
        fi

    else
        updateNonPrimary $entry $dataType $3 $1 $4
    fi
done
