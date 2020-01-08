#! /bin/bash

#To run properly, a functiopn needs to be added to your .bashrc
#clmns() { columns.sh $COLUMNS; }
#So to run the command use clmns

columns() {
    a=$1
    b=1
    while [[ $a -gt 0 ]]
    do
        if [[ $b -eq 10  ]]
        then
            b=0
        fi
        echo -n $b
        ((a--))
        ((b++))
    done
}

columns2() {
    a=$1
    b=1
    c=1
    while [[ $a -gt 0  ]]
    do 
        if [[ $b -eq 10  ]]
        then
            b=0
            if [[ $c -eq 10 ]]
            then
                c=0
            fi
            echo -n $c
            ((c++))
        else
            echo -n " "
        fi
        ((a--))
        ((b++))
    done
    echo ""
}
columns $1
columns2 $1

exit 0
