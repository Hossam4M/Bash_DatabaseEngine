#! /usr/bin/bash

wordNo=`echo $1 | wc -w`

checkType=`echo $1 | cut -f2 -d" "`

if [[ $wordNo == 3 ]]; then

    if [ "$checkType" = "database" ]; then
        cd ../.. ;
        . ./createDb.sh
    else
        echo -e "\n Error in syntax !!! \n";
    fi

elif [[ $wordNo == 4 ]]; then

    if [ "$checkType" = "table" ]; then

        typeset -i coma
        typeset -i semi

        tblName=`echo $1 | cut -f3 -d" "`
        check=`ls | grep "^$tblName$"`
        cols=`echo $1 | cut -f4 -d" "`
        coma=`echo $cols | tr -cd ',' | wc -c`+1
        semi=`echo $cols | tr -cd ':' | wc -c`

        if [ "$check" = "" ]; then
            if [[ $semi == $coma ]]; then
                touch $tblName
                touch .metaData_$tblName
                awk -F, '{ for(i=1;i<=NF;i++) print $i }' <<< "`echo $cols`" > temp.tmp && mv temp.tmp .metaData_$tblName
                echo -e "\n table created successfully \n"
            else
                echo -e "\n Error in syntax !!! \n"
            fi


        else
            echo -e "\n this table is already created !!! \n"
        fi
    else
        echo -e "\n Error in syntax !!! \n";
    fi

else
    echo -e "\n Error in syntax !!! \n";
fi

. ../../dbOptions.sh
