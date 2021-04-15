### This script is for root user on VPS only

### Install dependencies

On Ubuntu/Debian-based systems:
```
sudo apt-get update
```
```
sudo apt-get install unzip wget curl
```

### Download setup file
```
rm -r ~/masternode-upgrade
git clone https://github.com/TENTOfficial/masternode-upgrade
chmod +x masternode-upgrade/update-masternode.sh masternode-upgrade/update-masternode_arm64.sh masternode-upgrade/fetch-params.sh
```

### Upgrade masternode
**For amd64 processors run update-masternode.sh:**
```
bash masternode-upgrade/update-masternode.sh
```
**For arm64 processors run update-masternode_arm64.sh:**
```
bash masternode-upgrade/update-masternode_arm64.sh
```

After it's finished, you'll receive this data:
```
{
  "balance": 0.00000000,
  "blocks": 1724480,
  "buildinfo": "v3.1.2",
  "connections": 19,
  "difficulty": 216.9279947763039,
  "errors": "",
  "keypoololdest": 1519585211,
  "keypoolsize": 101,
  "networksolps": 26983,
  "paytxfee": 0,
  "protocolversion": 170010,
  "proxy": "",
  "relayfee": 0.000001,
  "testnet": false,
  "timeoffset": 0,
  "version": 3010250,
  "walletversion": 60000
}
```

In this case, your current syncing is at block: 1724480
You need to wait for syncing finish. Check the latest block at: https://explorer.tent.app/

Go to home
```
cd ~
```

Then run 
```
./snowgem-cli masternodedebug
```

to check current masternode status.
If it says: ``Masternode successfully started``, your upgrading process is finished.

