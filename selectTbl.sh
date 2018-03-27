#! /usr/bin/bash

wordNo=`echo $1 | wc -w`

checkType0=`echo $1 | cut -f3 -d" "`
# checkType1=`echo $1 | cut -f4 -d" "`


if [[ $wordNo == 4 ]]; then

    if [ "$checkType0" = "from" ]; then

        typeset -i cols
        typeset -i values

        tblName=`echo $1 | cut -f4 -d" "`
        check=`ls | grep "^$tblName$"`
        let cols=`echo $1 | cut -f2 -d" " | tr -cd ',' | wc -c`+1
        # let values=`echo $1 | cut -f6 -d" " | tr -cd ',' | wc -c`+1

        if [ "$check" != "" ]; then
            . ../../selectCheck.sh "$1"
        else
            echo -e "\n this table doesn't exist !!! \n"
        fi
    else
        echo -e "\n Error in syntax !!! \n";
    fi

else
    echo -e "\n Error in syntax !!! \n";
fi

. ../../dbOptions.sh
