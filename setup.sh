#startup script
#disable the old one
systemctl disable --now snowgem.service

#remove old one
sudo rm /lib/systemd/system/snowgem.service

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


chmod +x ~/masternode-upgrade/fetch-params.sh

wget -N https://github.com/Snowgem/Snowgem/releases/download/200458-20181006/snowgem-linux-2000458-20181006.zip -O ~/binary.zip
unzip -o ~/binary.zip -d ~

cd ~

killall -9 snowgemd

./masternode-upgrade/fetch-params.sh

chmod +x ~/snowgemd ~/snowgem-cli

#start
systemctl enable --now snowgem.service

echo "wait for 15 seconds"
sleep 15

./snowgem-cli getinfo