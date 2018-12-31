#!/bin/bash

BLOCK_DIR=

cd masternode-upgrade

#setup auto starting
#remove old one
if [ -f /lib/systemd/system/snowgem.service ]; then
	sudo systemctl disable --now snowgem.service
	sudo rm /lib/systemd/system/snowgem.service
else
	echo "File not existed, OK"
fi

#create new one
username=$(whoami)
echo $username

service=
if [ "$username" = "root" ] ; then
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
TimeoutStopSec=10
Nice=-20
ProtectSystem=full

[Install]
WantedBy=multi-user.target' >> /lib/systemd/system/snowgem.service"
else
  service="echo '[Unit]
Description=Snowgem daemon
After=network-online.target

[Service]
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/home/'$username'/snowgemd
WorkingDirectory=/home/'$username'/.snowgem
User='$username'
KillMode=mixed
Restart=always
RestartSec=10
TimeoutStopSec=10
Nice=-20
ProtectSystem=full

[Install]
WantedBy=multi-user.target' >> /lib/systemd/system/snowgem.service"
fi
echo $service
sudo sh -c "$service"

killall -9 snowgemd

#remove old params files
if [ -d ~/.snowgem-params ]; then
  rm ~/.snowgem-params -r
fi

if [ -d ~/snowgem-wallet ]; then
  rm ./snowgem-wallet -r
fi

chmod +x ~/masternode-upgrade/fetch-params.sh

wget -N https://github.com/Snowgem/Snowgem/releases/download/3000450-20181208/snowgem-linux-3000450-20181208.zip -O ~/binary.zip
unzip -o ~/binary.zip -d ~

if [ ! -d ~/.snowgem/blocks ]; then
  wget -N https://cdn1.snowgem.org/blockchain_index.zip -O ~/blockchain.zip
  unzip -o ~/blockchain.zip -d ~/.snowgem
  rm ~/blockchain.zip
fi


cd ~

./masternode-upgrade/fetch-params.sh

chmod +x ~/snowgemd ~/snowgem-cli

#start
./snowgemd -daemon
sudo systemctl enable --now snowgem.service

x=1
echo "wait for starting"
while true ; do
    echo "It's normal, please wait until wallet is loaded, this step will take few minutes ($x)"
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
