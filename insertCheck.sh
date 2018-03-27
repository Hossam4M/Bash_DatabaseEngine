#! /usr/bin/bash

. ../../functions.sh

# set -x

let colsNo=`echo $1 | cut -f4 -d" " | tr -cd ',' | wc -c`+1
let valuesNo=`echo $1 | cut -f6 -d" " | tr -cd ',' | wc -c`+1

# cols=`echo $1 | cut -f4 -d" "`
# values=`echo $1 | cut -f6 -d" "`

primaryCheck=`echo $1 | cut -f4 -d" " | cut -f1 -d,`
primaryValue=`echo $1 | cut -f6 -d" " | cut -f1 -d,`

tblName=`echo $1 | cut -f3 -d" "`

metaData=($(awk -F: '{ print $1 }' .metaData_$tblName))
metaType=($(awk -F: '{ print $2 }' .metaData_$tblName))



if [[ $colsNo > ${#metaData[@]} && ${#metaData[@]} > 0 ]]; then
    echo -e "\n columns must be less than or equal ${#metaData[@]} \n"
else
    
    if [ "$primaryCheck" = ${metaData[0]} ]; then

        checkDataTypePrimary $primaryValue ${metaType[0]} $tblName

        for (( i = 1; i < $colsNo; i++ )); do
            nonPrimaryValue=`echo $1 | cut -f6 -d" " | cut -f$((i+1)) -d,`
            checkDataTypeNonPrimary  $nonPrimaryValue ${metaType[$i]} $tblName
        done

        awk -F: ' { print $0 } END{ print "'$string'" }' $tblName > temp.tmp && mv temp.tmp $tblName ;

        echo -e "\n insertion done successfully \n"


    else
        echo -e "\n primary field must be entered first \n"
    fi
fi
