#! /usr/bin/bash

shopt -s extglob
LC_COLLATE=C

function welcome {
    clear
    echo -e "=================================\n"
    echo -e " Welcome to Bash Database Engine \n"
    echo -e "=================================\n"

}

function isNull() {
    if [ "$1" = "" ]; then
        check=1
    else
        check=0
    fi
}


function checkDataTypePrimary() {

    list=`awk -F: '{ print $1 }' $3 | grep "^$1$"`

    if [ "$list" = "" ]; then

        if [ "$2" = "string" ]; then

            if [[ $1 =~ ^[a-zA-Z]([a-zA-Z./?0-9])* ]] ; then

                awk -F: ' { print $0 } END{ print "'$1'" }' $3 > temp.tmp && mv temp.tmp $3 ;
                qflag="false"

            else
                echo " this field must be string "
            fi

        elif [ "$2" = "number" ]; then

            if [[ $1 =~ ^[0-9]([0-9])* ]] ; then

                awk -F: ' { print $0 } END{ print "'$1'" }' $3 > temp.tmp && mv temp.tmp $3 ;
                qflag="false"

            else
                echo " this field must be number "
            fi

        fi

    else
        echo " Dublication Error ! This is primary key and must be unique "
    fi

}

function checkDataTypeNonPrimary() {
    if [ $1 = "" ]; then
        awk -F: ' { if (NR == "'$4'") sub(/$/,":null") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
        qflag="false"
    else

        if [ "$2" = "string" ]; then

            if [[ $1 =~ ^[a-zA-Z]([a-zA-Z./?0-9])* ]] ; then
                awk -F: ' { if (NR == "'$4'") sub(/$/,"':$1'") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
                qflag="false"
            else
                echo " this field must be string "
            fi

        elif [ "$2" = "number" ]; then

            if [[ $1 =~ ^[0-9]([0-9])* ]] ; then

                awk -F: ' { if (NR == "'$4'") sub(/$/,"':$1'") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
                qflag="false"

            else
                echo " this field must be number "
            fi

        fi

    fi


}

function updatePrimary() {

    list=`awk -F: '{ print $1 }' $3 | grep "^$1$"`

    if [ "$list" = "" ]; then

        if [ "$2" = "string" ]; then
            
            if [[ $1 =~ ^[a-zA-Z]([a-zA-Z./?0-9])* ]] ; then

                awk -F: ' { if (NR == "'$5'") sub($1,"'$1'") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
                qExit="false"

            else
                echo " this field must be string "
            fi

        elif [ "$2" = "number" ]; then
            echo "number"
            if [[ $1 =~ ^[0-9]([0-9])* ]] ; then

                awk -F: ' { if (NR == "'$5'") sub($1,"'$1'") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
                qExit="false"

            else
                echo " this field must be number "
            fi

        fi

    else
        echo " Dublication Error ! This is primary key and must be unique "
    fi

}

function updateNonPrimary() {

    if [ $1 = "" ]; then

        awk -F: ' { if (NR == "'$5'") sub($"'$4'","null") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
        qExit="false"

    else

        list=`awk -F: '{ print $1 }' $3 | grep "^$1$"`

        if [ "$list" = "" ]; then

            if [ "$2" = "string" ]; then

                if [[ $1 =~ ^[a-zA-Z]([a-zA-Z./?0-9])* ]] ; then

                    awk -F: ' { if (NR == "'$5'") sub($"'$4'","'$1'") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
                    qExit="false"

                else
                    echo " this field must be string "
                fi

            elif [ "$2" = "number" ]; then

                if [[ $1 =~ ^[0-9]([0-9])* ]] ; then

                    awk -F: ' { if (NR == "'$5'") sub($"'$4'","'$1'") ; print $0 } ' $3 > temp.tmp && mv temp.tmp $3 ;
                    qExit="false"

                else
                    echo " this field must be number "
                fi

            fi

        else
            echo " Dublication Error ! This is primary key and must be unique "
        fi

    fi

}
