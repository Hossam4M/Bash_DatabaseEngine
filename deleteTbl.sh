#! /usr/bin/bash

wordNo=`echo $1 | wc -w`

if [[ $wordNo == 3 ]]; then

    checkType=`echo $1 | cut -f2 -d" "`


    if [ "$checkType" = "table" ]; then
        tblName=`echo $1 | cut -f3 -d" "`
        check=`ls | grep "^$tblName$"`

        if [ "$check" = "" ]; then
            echo -e "\n this table doesn't exist !!! \n"
        else
            rm $tblName
            rm .metaData_$tblName
            echo -e "\n table dropped successfully \n"
        fi
    else
        echo -e "\n Error in syntax !!! \n";
    fi

else
    echo -e "\n Error in syntax !!! \n";
fi

. ../../dbOptions.sh
