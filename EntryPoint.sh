#! /usr/bin/bash


check=`ls | grep "^repo$"`
if [ "$check" = "" ]; then
    mkdir repo
fi

select choice in "create new database" "use database" "delete database" "exit" ;
do
    case $REPLY in
        1 ) . ./CreateDb.sh
            ;;
        2 ) . ./UseDb.sh
            ;;
        3 ) . ./DeleteDb.sh
            ;;
        4 ) exit
            ;;
    esac
done
