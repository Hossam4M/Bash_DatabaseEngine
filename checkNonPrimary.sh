#! /usr/bin/Bash

shopt -s extglob

. ../../functions.sh

qflag=$3

while [ "$qflag" == 'true' ]; do
    echo -n "enter the value of $1 ( $2 ) : ";
    read value;

    checkDataTypeNonPrimary $value $2 $4 $5

done
