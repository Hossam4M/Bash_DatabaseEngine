#! /usr/bin/bash

wordNo=`echo $1 | wc -w`

if [[ $wordNo == 2 ]]; then

    checkType=`echo $1 | cut -f2 -d" "`


    if [ "$checkType" = "tables" ]; then
        echo
        ls -1
        echo
    else
        echo -e "\n Error in syntax !!! \n";
    fi

else
    echo -e "\n Error in syntax !!! \n";
fi

. ../../dbOptions.sh
