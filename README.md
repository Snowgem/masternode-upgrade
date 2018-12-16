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
git clone https://github.com/Snowgem/masternode-upgrade
chmod +x masternode-upgrade/setup.sh masternode-upgrade/setup_part2.sh masternode-upgrade/fetch-params.sh
```

### Upgrade masternode

You need to run this command:
```
./masternode-upgrade/setup.sh
```

After it's finished, you'll receive this data:
```
{
  "version": 3000450,
  "protocolversion": 170008,
  "walletversion": 60000,
  "balance": 0.01000000,
  "blocks": 501539,
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

In this case, your current syncing is at block: 501539
You need to wait for syncing finish. Check the latest block at: https://insight.snowgem.org/

Go to home
```
cd ~
```

To check current syncing process, run following command
```
./snowgem-cli getinfo
```

Once it's synced, ``GO TO YOUR LOCAL PC``, select the corresponding masternode and start it.


Wait for 1 min, go to VPS, run
```
./masternode-upgrade/setup_part2.sh
```

Then run 
```
./snowgem-cli masternodedebug
```

to check current masternode status.
If it says: ``Masternode successfully started``, your upgrading process is finished.

If your masternode is still not activated, run the following steps until it's activated
```
cd ~
./snowgem-cli stop
```
wait for 1-2 mins then run
```
./snowgem-cli masternodedebug
```
