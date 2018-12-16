#!/bin/bash

cd ~

./snowgem-cli stop
./snowgemd -daemon

x=1
echo "wait for starting"
while true ; do
    echo "It's normal, please wait until wallet info is displayed ($x)"
    sleep 1
    x=$(( $x + 1 ))
    if ./snowgem-cli getinfo | grep '"difficulty"' ; then
        ./snowgem-cli getinfo
        echo "checking masternode status"
        while true ; do
            echo "Please wait ($x)"
            sleep 1
            x=$(( $x + 1 ))
            if ! ./snowgem-cli masternodedebug | grep -q 'not yet activated'; then
                ./snowgem-cli masternodedebug
                break
            fi
        done
        break
    fi
done

./snowgem-cli getinfo
./snowgem-cli masternodedebug
