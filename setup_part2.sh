#!/bin/bash

cd ~

./snowgem-cli stop
./snowgemd -daemon

x=1
echo "Wait for starting"
while true ; do
    echo "Wallet is opening, please wait. This step will take few minutes ($x)"
    sleep 1
    x=$(( $x + 1 ))
    ./snowgem-cli getinfo &> text.txt
    line=$(tail -n 1 text.txt)
    if [[ $line == *"..."* ]]; then
        echo $line
    fi
    if [[ $(tail -n 1 text.txt) == *"sure server is running"* ]]; then
        echo "Cannot start wallet, please contact us on Discord(https://discord.gg/7a7XRZr) for help"
        break
    elif [[ $(head -n 20 text.txt) == *"version"*  ]]; then
        echo "Checking masternode status"
        while true ; do
            echo "Please wait ($x)"
            sleep 1
            x=$(( $x + 1 ))
            ./snowgem-cli masternodedebug &> text.txt
            line=$(head -n 1 text.txt)
            if [[ $line == *"not yet activated"* ]]; then
                ./snowgem-cli masternodedebug
                break
            fi
        done
        ./snowgem-cli getinfo
        ./snowgem-cli masternodedebug
        break

    fi
done
