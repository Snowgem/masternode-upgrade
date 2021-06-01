#!/bin/bash

apt-get install wget unzip gpw curl libgomp1 -y

# Disable services

systemctl disable --now tent.service \
  snowgem.service > /dev/null 2>&1

rm /lib/systemd/system/snowgem.service > /dev/null 2>&1

# Setup /lib/systemd/system/tent.service

echo "Creating tent service file..."

echo "[Unit]
Description=TENT service
After=network.target

[Service]
User=root
Group=root

Type=simple
Restart=always

ExecStart=/root/snowgemd
WorkingDirectory=/root/.snowgem

TimeoutStopSec=300

[Install]
WantedBy=default.target" > /lib/systemd/system/tent.service


killall -9 snowgemd > /dev/null 2>&1

wget -N https://github.com/TENTOfficial/TENT/releases/download/Node/tent-linux.zip -O ~/binary.zip
unzip -o ~/binary.zip -d ~

cd
chmod +x ~/snowgemd ~/snowgem-cli

#start
systemctl enable --now tent.service

sleep 11s
x=1
counter=1
echo "Wait for starting"
while true ; do
    echo "Wallet is opening, please wait. This step will take few minutes ($x)"
    sleep 1s
    x=$(( $x + 1 ))
    ./snowgem-cli getinfo &> text.txt
    line=$(tail -n 1 text.txt)
    if [[ $line == *"..."* ]]; then
        echo $line
    fi
    if [[ $(tail -n 1 text.txt) == *"sure server is running"* ]]; then
        counter=$(( $counter + 1 ))
        if [[ $counter == 10 ]]; then
            echo "Cannot start wallet, please contact us on Discord(https://discord.gg/78rVJcH) for help"
            break
        fi
    fi
    if [[ $(head -n 20 text.txt) == *"version"*  ]]; then
        sleep 60s
        systemctl restart tent.service
        sleep 11s # 2nd restart - necessary for gettin real activation status
        x=1
        counter=1
        echo "Wait for starting"
        while true ; do
            echo "Wallet is opening, please wait. This step will take few minutes ($x)"
            sleep 1s
            x=$(( $x + 1 ))
            ./snowgem-cli getinfo &> text.txt
            line=$(tail -n 1 text.txt)
            if [[ $line == *"..."* ]]; then
                echo $line
            fi
            if [[ $(tail -n 1 text.txt) == *"sure server is running"* ]]; then
                counter=$(( $counter + 1 ))
                if [[ $counter == 10 ]]; then
                    echo "Cannot start wallet, please contact us on Discord(https://discord.gg/78rVJcH) for help"
                    break
                fi
            fi
            if [[ $(head -n 20 text.txt) == *"version"*  ]]; then
                echo "Checking masternode status"
                while true ; do
                    echo "Please wait ($x)"
                    sleep 1s
                    x=$(( $x + 1 ))
                    ./snowgem-cli masternodedebug &> text.txt
                    line=$(head -n 1 text.txt)
                echo $line
                    if [[ $line == *"Masternode successfully started"* ]]; then
                        ./snowgem-cli masternodedebug
                        break
                    fi
                done
                ./snowgem-cli getinfo
                ./snowgem-cli masternodedebug
            
                break
            fi
        done
        break
    fi
done

#echo "Check if this update require a node restart and if needed go to TENT Core and start this masternode again"
