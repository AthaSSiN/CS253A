#!/bin/bash

roll="190200"

rm password.txt

for (( i = 0 ; i < 5; ++i))
do
    for ((j = i + 1; j < 6; ++j))
    do
        for k in {a..z}
        do 
            for l in {a..z}
            do
                b="${roll:0:$i}$k${roll:$((i+1)):$((j - i - 1))}$l${roll:$((j+1))}"
                res=$(./secret $roll $b 2> >(grep -i "Wrong password."))
                if [[ $res != "Wrong password." ]]
                then
                    echo "Password is $b"
                    echo $b > password.txt
                    echo "Password stored to password.txt"
                    break 4
                fi
            done
        done
    done
done

