#! /usr/bin/bash

cd $1

select choice in "create new table" "insert into" "update" "delete row" "delete table" "show table" "return" ;
do
    case $REPLY in
        1 ) . ../../CreateTbl.sh $1
            ;;
        2 ) . ../../InsertTbl.sh $1
            ;;
        3 ) . ../../UpdateTbl.sh $1
            ;;
        4 ) . ../../DeleteTbl.sh $1
            ;;
        5 ) . ../../DeleteEntireTbl.sh $1
            ;;
        6 ) . ../../ShowTable.sh $1
            ;;
        7 ) cd ../.. ;
            . ./EntryPoint.sh
            ;;
    esac
done
