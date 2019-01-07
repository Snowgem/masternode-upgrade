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
    line=$(head -n 1 text.txt)
    if [[ $line == *"connect to server: unknown"* ]]; then
        echo "Cannot start wallet, please contact us on Discord(https://discord.gg/7a7XRZr) for help"
        break
    elif [[ $line != *"error code"*  ]] && [[ $line == *"{"*  ]]; then
        ./snowgem-cli getinfo
        echo "Checking masternode status"
        while true ; do
            echo "Please wait ($x)"
            sleep 1
            x=$(( $x + 1 ))
            if ! ./snowgem-cli masternodedebug | grep -q 'not yet activated'; then
                ./snowgem-cli masternodedebug
                break
            fi
        done
        ./snowgem-cli getinfo
        ./snowgem-cli masternodedebug
        break
    fi
done
