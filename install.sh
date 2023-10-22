#!/bin/bash
sudo apt-get update

sudo apt-get -y upgrade

sudo apt-get install -y build-essential

sudo apt install -y curl git jq lz4 build-essential unzip

bash <(curl -s "https://raw.githubusercontent.com/nodejumper-org/cosmos-scripts/master/utils/go_install.sh")
source .bash_profile

git clone https://github.com/Fantom-foundation/go-opera.git
cd go-opera/
git checkout release/1.1.3-rc.5
make

cd build/
wget https://download.fantom.network/mainnet-171200-pruned-mpt.g

sudo tee <<EOF >/dev/null /etc/systemd/system/fantom.service
[Unit]
Description=Fantom Node
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=/root/go-opera/build/opera --genesis /root/go-opera/build/mainnet-171200-pruned-mpt.g --identity ERN --cache 8096 --http --http.addr 0.0.0.0 --http.corsdomain '*' --http.vhosts "*" --http.api "eth,net,web3" 
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable fantom

sudo systemctl daemon-reload

sudo systemctl start fantom
