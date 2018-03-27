#! /usr/bin/bash

. ../../functions.sh

# set -x

let colsNo=`echo $1 | cut -f2 -d" " | tr -cd ',' | wc -c`+1

fields="`echo $1 | cut -f2 -d' '`"

tblName=`echo $1 | cut -f4 -d" "`

metaData=($(awk -F: '{ print $1 }' .metaData_$tblName))
metaType=($(awk -F: '{ print $2 }' .metaData_$tblName))

if [[ $colsNo > 1 && ${#metaData[@]} > 0 ]]; then
    # echo -e "\n columns must be less than or equal ${#metaData[@]} \n"
    echo -e "\n this version comes with just selecting one column \n"
else

    if [ "$fields" = "all" ]; then
        awk -F: '{ print $0 }' $tblName
    else
        printFlag="false"
        for (( i = 1; i <= $colsNo; i++ )); do
        field=`echo $1 | cut -f2 -d" " | cut -f$i -d,`
            for (( j = 0; j < ${#metaData[@]}; j++ )); do
                if [ "$field" = "${metaData[$j]}" ]; then
                    let toPrint=$j+1
                    printFlag="true"
                fi
            done
        done
        if [ "$printFlag" = "true" ]; then
            awk -F: '{ print $'$toPrint' }' $tblName
        else
            echo -e "\n these columns don't exist \n"
        fi
    fi
fi
