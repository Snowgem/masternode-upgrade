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
chmod +x setup.sh setup_part2.sh fetch-params.sh
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
