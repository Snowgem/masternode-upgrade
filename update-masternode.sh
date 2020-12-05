#!/bin/bash

#apt-get install wget unzip curl libgomp1 -y

BLOCK_DIR=

#setup auto starting
#remove old one
if [ -f /lib/systemd/system/snowgem.service ]; then
  systemctl disable --now snowgem.service
  rm /lib/systemd/system/snowgem.service
fi

if [ -f /lib/systemd/system/tent.service ]; then
  systemctl disable --now tent.service
  rm /lib/systemd/system/tent.service
fi

echo "Creating service file..."

  service="echo '[Unit]
Description=Snowgem daemon
After=network-online.target

[Service]
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/root/snowgemd
WorkingDirectory=/root/.snowgem
User=root
KillMode=mixed
Restart=always
RestartSec=10
TimeoutStopSec=180
Nice=-20
ProtectSystem=full

[Install]
WantedBy=multi-user.target' >> /lib/systemd/system/tent.service"

echo $service
sh -c "$service"


killall -9 snowgemd

wget -N https://github.com/TENTOfficial/TENT/releases/download/3.1.0/snowgem-ubuntu-3.1.0-20201117.zip -O ~/binary.zip
unzip -o ~/binary.zip -d ~

cd ~

chmod +x ~/snowgemd ~/snowgem-cli

#start
systemctl enable --now tent.service
systemctl start tent.service

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

#echo "Go to ModernWallet and start this masternode again"
echo -n "Agree with reporting MN ip+version to AsGard to help providing better stats for the network? [y/n] "; read yn
case $yn in
    y|Y|YES|yes|Yes)
        report=1
        ;;
esac

if [ "$report" -eq 1 ] ; then
        bash ~/masternode-upgrade/report-version.sh
fi
