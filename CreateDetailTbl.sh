#! /usr/bin/bash

select choice in "insert new column" "return" ;
do
    case $REPLY in
        1 ) check=`cat .metaData_$2`
            if [ "$check" = "" ]; then
                echo -n "enter the name of column (PrimaryKey) : " ;
            else
                colList=($(awk -F: '{ print $1 }' .metaData_$2))
                echo -n "enter the name of column except ( ${colList[*]} ) : " ;
            fi

            read colName

            check=`awk -F: '{ print $1 }' .metaData_$2 | grep "^$colName$"`

            if [ "$check" = "" ]; then

                select choice in "string" "number" ;
                do
                    case $REPLY in
                        1 ) dataType="string"
                            break;;
                        2 ) dataType="number"
                            break;;
                    esac
                done

                awk -F: ' { print $0 } END{ print "'$colName:$dataType'" }' .metaData_$2 > temp.tmp && mv temp.tmp .metaData_$2

                check=`cat $2`
                if [ "$check" = "" ]; then
                    awk -F: ' BEGIN{ print "'$colName'" } ' $2 > temp.tmp && mv temp.tmp $2
                else
                    awk -F: ' { if (NR == 1) sub(/$/,"':$colName'") ; print $0 } ' $2 > temp.tmp && mv temp.tmp $2
                fi


            else
                echo "this column already exists";
            fi
                . ../../CreateDetailTbl.sh
            ;;

        2 ) cd ..;
            . ../OptionDb.sh $1
            ;;

    esac
done
