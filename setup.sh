BLOCK_DIR=

cd masternode-upgrade

#setup auto starting
#remove old one
if [ -f /lib/systemd/system/snowgem.service ]; then
	systemctl disable --now snowgem.service
	sudo rm /lib/systemd/system/snowgem.service
else
	echo "File not existed, OK"
fi

#create new one
sh -c "echo '[Unit]
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

killall -9 snowgemd

#remove old params files
rm ~/.snowgem-params -r
rm ~/snowgem-wallet -r

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
systemctl enable --now snowgem.service

echo "wait for 200 seconds"
x=1
while [ $x -le 200 ]
do
  echo "$x"
  sleep 1
  x=$(( $x + 1 ))
done

./snowgem-cli getinfo
