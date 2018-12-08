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
git clone https://github.com/Snowgem/masternode-upgrade
cd masternode-upgrade
chmod +x setup.sh fetch-params.sh
```

### Upgrade masternode

You need to run this command:
```
./setup.sh
```

After it's finished, you'll receive this data:
```
{
  "version": 2000455,
  "protocolversion": 170006,
  "walletversion": 60000,
  "balance": 0.00000000,
  "blocks": 10293,
  "timeoffset": 0,
  "connections": 125,
  "proxy": "",
  "difficulty": 626.6895395692187,
  "testnet": false,
  "keypoololdest": 1521271021,
  "keypoolsize": 101,
  "paytxfee": 0.00000000,
  "relayfee": 0.00000100,
  "errors": ""
}
```

In this case, your current syncing is at block: 10293
You need to wait for syncing finish. Check the latest block at: https://insight.snowgem.org/

If your current block is latest block, go to the next step in the guide.
