#! /usr/bin/Bash

shopt -s extglob

. ../../functions.sh

qflag=$3

while [ "$qflag" == 'true' ]; do

    echo -n "enter the value of $1 ( $2 ) : ";
    read value;


    isNull $value

    if [ $check -eq 0 ]; then
        checkDataTypePrimary $value $2 $4

    elif [ $check -eq 1 ]; then
        echo "this is PrimaryKey Field !!! it can not be null"
    fi

done
