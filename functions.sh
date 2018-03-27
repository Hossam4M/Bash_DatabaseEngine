#! /usr/bin/bash

shopt -s extglob
LC_COLLATE=C


function isNull() {
    if [ "$1" = "" ]; then
        check=1
    else
        check=0
    fi
}


function checkDataTypePrimary() {

    # 1 - value
    # 2 - data type
    # 3 - table Name


    list=`awk -F: '{ print $1 }' $3 | grep "^$1$"`

    if [ "$list" = "" ]; then

        if [ "$2" = "string" ]; then

            if [[ $1 =~ ^[a-zA-Z]([a-zA-Z./?0-9])* ]] ; then

                string="$1"
                # qflag="false"

            else
                echo " $1 field must be string "
                . ../../dbOptions.sh
            fi

        elif [ "$2" = "number" ]; then

            if [[ $1 =~ ^[0-9]([0-9])* ]] ; then

                string="$1"
                # qflag="false"

            else
                echo " $1 field must be number "
                . ../../dbOptions.sh
            fi

        fi

    else
        echo " Dublication Error ! This is primary key and must be unique "
        . ../../dbOptions.sh
    fi

}

function checkDataTypeNonPrimary() {
    if [ $1 = "" ]; then
        string="$string:null"
        # qflag="false"
    else

        if [ "$2" = "string" ]; then

            if [[ $1 =~ ^[a-zA-Z]([a-zA-Z./?0-9])* ]] ; then
                string="$string:$1"
                # qflag="false"
            else
                echo " $1 field must be string "
                . ../../dbOptions.sh
            fi

        elif [ "$2" = "number" ]; then

            if [[ $1 =~ ^[0-9]([0-9])* ]] ; then

                string="$string:$1"
                # qflag="false"

            else
                echo " $1 field must be number "
                . ../../dbOptions.sh
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


    fi

}
