### This script is for root user on VPS only

### Install dependencies

On Ubuntu/Debian-based systems:
```
sudo apt-get update
```
```
sudo apt-get install \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python python-zmq \
      zlib1g-dev wget bsdmainutils automake curl gpw
```

### Download setup file
```
rm -r ~/masternode-upgrade
git clone https://github.com/Snowgem/masternode-upgrade
chmod +x masternode-upgrade/update-masternode.sh masternode-upgrade/fetch-params.sh
```

### Upgrade masternode

You need to run this command:
```
bash masternode-upgrade/update-masternode.sh
```

After it's finished, you'll receive this data:
```
{
  "version": 3000458,
  "buildinfo": "v3.0.4-8-db64ecb-dirty",
  "protocolversion": 170009,
  "walletversion": 60000,
  "balance": 0.00000000,
  "blocks": 1379050,
  "timeoffset": 0,
  "connections": 30,
  "proxy": "",
  "difficulty": 355.8068819256667,
  "networksolps": 46443,
  "testnet": false,
  "keypoololdest": 1569485922,
  "keypoolsize": 101,
  "paytxfee": 0.00000000,
  "relayfee": 0.00000100,
  "errors": ""
}
```

In this case, your current syncing is at block: 1379050
You need to wait for syncing finish. Check the latest block at: https://explorer.snowgem.org/

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

