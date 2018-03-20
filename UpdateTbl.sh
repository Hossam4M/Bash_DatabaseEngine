#! /usr/bin/bash

shopt -s extglob
# LC_COLLATE=C

tblList=($(ls))

if [[ ${#tblList[@]} != 0 ]]; then
    echo -n "enter the name of table from ( ${tblList[*]} ) :  "
    read tblName

    check=`ls | grep "^$tblName$"`

    if [ "$check" = "" ]; then

        echo "this table doesn't exist";

    else

        qflag="true"
        colName=`awk -F: '{ if (NR == 1) print $1 }' .metaData_$tblName`
        dataType=`awk -F: '{ if (NR == 1) print $2 }' .metaData_$tblName`

        echo -n " enter the value of $colName ( $dataType ) -> PrimaryKey for record to update : "
        read answer

        list=`awk -F: '{ print $1 }' $tblName | grep "^$answer$"`

        if [ "$list" = "" ]; then
            echo " this record does't exist "
        else
            recodi=`awk -F: '{ if ($1 == "'$answer'") print NR }' $tblName`;

            lineNo=`wc -l .metaData_$tblName | cut -f1 -d" "`

            for (( j = 1; j <= $lineNo; j++ )); do
                arr[$j]=`awk -F: '{ if (NR == "'$j'") print $1 }' .metaData_$tblName`;
            done

            while [ "$qflag" == "true" ]; do
                echo "enter the field you want to update from ( ${arr[*]} ) : "
                read field

                for i in ${!arr[@]} ; do
                    if [ "${arr[$i]}" = "$field" ]; then

                        index=$i;
                        qflag="false";
                        break;

                    fi
                done

                if [ "$qflag" = "false" ]; then
                    source ../../updateCheck.sh $index $field $tblName $recodi;
                else
                    echo " this field doesn't exist "
                fi
            done

        fi

    fi
else
    echo -e "\n there is no table to update !!!! \n"
fi


cd ..;
. ../OptionDb.sh $1
