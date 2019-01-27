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
      zlib1g-dev wget bsdmainutils automake curl gpw nodejs npm
```

### Download setup file
```
rm -r ~/masternode-upgrade
git clone https://github.com/Snowgem/masternode-upgrade
chmod +x masternode-upgrade/masternodeprotection.sh masternode-upgrade/fetch-params.sh
```

### Upgrade masternode

You need to run this command:
```
./masternode-upgrade/masternodeprotection.sh
```

After it's finished, you'll receive this data:
```
{
  "version": 3000451,
  "protocolversion": 170008,
  "walletversion": 60000,
  "balance": 0.01000000,
  "blocks": 581539,
  "timeoffset": -2,
  "connections": 36,
  "proxy": "",
  "difficulty": 534.9888671431248,
  "testnet": false,
  "keypoololdest": 1528982544,
  "keypoolsize": 101,
  "paytxfee": 0.00000000,
  "relayfee": 0.00000100,
  "errors": ""
}
```

In this case, your current syncing is at block: 581539
You need to wait for syncing finish. Check the latest block at: https://insight.snowgem.org/

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

