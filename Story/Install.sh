#!/bin/bash

sudo apt update && apt upgrade -y

wget https://story-geth-binaries.s3.us-west-1.amazonaws.com/geth-public/geth-linux-amd64-0.9.2-ea9f0d2.tar.gz
tar -xzvf geth-linux-amd64-0.9.2-ea9f0d2.tar.gz
sudo cp geth-linux-amd64-0.9.2-ea9f0d2/geth /usr/local/bin/story-geth

wget https://story-geth-binaries.s3.us-west-1.amazonaws.com/story-public/story-linux-amd64-0.9.11-2a25df1.tar.gz
tar -xzvf story-linux-amd64-0.9.11-2a25df1.tar.gz
sudo cp story-linux-amd64-0.9.11-2a25df1/story /usr/local/bin/story

echo "export PATH=$PATH:/usr/local/bin" >> .bash_profile
source $HOME/.bash_profile
story-geth version
story version

read -p "Nhap ten MONIKER: " moniker

story init --network iliad --moniker $moniker

sudo tee /etc/systemd/system/story-geth.service > /dev/null <<EOF
[Unit]
Description=Story Geth Client
After=network.target

[Service]
User=root
ExecStart=/usr/local/bin/story-geth --iliad --syncmode full
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF

sudo tee /etc/systemd/system/story.service > /dev/null <<EOF
[Unit]
Description=Story Consensus Client
After=network.target

[Service]
User=root
ExecStart=/usr/local/bin/story run
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF



PEERS="7655b88b80c01a4b62d3308f5780ec90ea6b9e77@57.129.52.151:26656,b9517f052f1027d98799c1155b8d64c4012c0997@77.237.242.87:26656,b7d0546f53b3913f6efcec8a78009c773442e3f5@62.171.187.179:26656,eeb7d2096a887f8ff8fdde2695c394fcf5a19273@194.238.30.192:36656,17d69e7e7f6b43ef414ee6a4b2585bd9ee0446ce@135.181.139.249:46656,6394a7913ffe2cf0e97cdaccc69760a420887ffe@150.136.92.197:26656,b7bead382ecc5a4367fa2fe627d7841ba359bf7f@45.159.220.151:26656,c42c3b69c529ca0410e26366a68258fe454a1866@188.245.99.158:26656,8960b0b407c5b965292d2542fa2e246e63002dfa@45.135.180.101:26656,cf7804bd1ec369215d7ece864962e3787810074b@62.169.21.31:26656,7ed2e34f5e80948e862ba96d3051c08e4fb3b696@194.48.168.43:26656,6d63636af2f3a2f971fc4598a9162c2b678f0d54@157.173.197.113:26656,401b104059ce4f8d5bf4897a16229d650d01c35e@157.173.197.112:26656,ce98a69ccee50a67810514a5a1e8705678806361@45.8.148.180:26656,f99c8ed3d8a6d89ad98f691c09a9354bc8e4609f@207.121.63.164:26656,320d6b964a0fd7a61299bd66dadd89e78107bc0d@35.206.216.224:26656,7af6ffb7b85695dec024163cf2140769bf17c1ec@65.21.210.147:26656,ec7db891e19810c6fb95360dd23b91a1c8ab2b0c@65.109.122.163:26656,636ed1083a477fada829345d59af7f078b814501@89.23.123.178:26656,2a77804d55ec9e05b411759c70bc29b5e9d0cce0@165.232.184.59:26656,a2fe3dfd6396212e8b4210708e878de99307843c@54.209.160.71:26656,004883a2f901bac654cec7e789e8fdf16c5e5856@46.105.55.149:26656,748739306ea958d6220e7bfcf39d2ff87d8b7fa9@51.159.235.58:26656,4f0f02b7d4efc8e42db3945fa7bcd8b85c8746e8@62.169.22.138:26656,b596baa2785a49e995322c7f781de1ca1df1e51c@45.13.226.108:26656,55d52cae30253f957e9b35e73b6765b36112291b@38.46.221.37:26656,f5ca75340a76a199c41d76dbeec412cc8b979441@15.235.87.22:26656,b80e130d71a1adfafa1ce31c703548fa58e1e493@135.181.57.232:26656,b7a253c86eaa544b27dae9a4954a6747acf5174f@213.199.43.14:26656,09089d77e872d2d8dfe15d7b8bb519a8f0c2a139@157.173.197.117:26656,5e4f9ce2d20f2d3ef7f5c92796b1b954384cbfe1@34.234.176.168:26656,c2ae488ed7c74f7139d927e7518a9485fa5e0623@213.239.198.181:35656,1cceccb08bae25a0f91fe85b0ca562fa791f47aa@184.169.154.204:26656,f1ec81f4963e78d06cf54f103cb6ca75e19ea831@217.76.159.104:26656,b1674fa7a80214280beef04ff98f8f890a7bc7b1@5.252.53.37:26656,d4acae33cde20795a599e98e7c259b7bd220023c@138.201.248.154:21656,8aa160aa30dd61a66230411f7bd9a5538d73023d@38.242.155.150:26656,9836b0a610132d8c8898457c7a312727b54b2e4a@144.126.159.151:11056,79c29cac5433199d68f74feadea71f8277df6f90@38.207.159.35:26656,ae2d5116b30e5d0c61894b2f643005f71a4aa313@75.119.129.76:26656,502768c5256728123626411bcd85a5633af5a1bc@95.217.193.182:46656,ee5ecaf1364cb3238113ba9a29813c17fab97694@157.173.197.110:26656,ba7a053ab29149aa5ffcdae0248428ce49c53bc0@185.119.116.250:26656,fe5b39d2bd701ed12a953894cc1449d4c5c6d699@135.125.189.91:26656,15c7e2b630c04ee11b2c3cfbfb1ede0379df9407@52.74.117.64:26656,c42b7df9fe243759573cb1ce948d7580423690fa@213.199.43.17:26656"

sed -i "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" /root/.story/story/config/config.toml

sudo systemctl daemon-reload && \
sudo systemctl start story-geth && \
sudo systemctl enable story-geth && \
sudo systemctl status story-geth

sudo systemctl daemon-reload && \
sudo systemctl start story && \
sudo systemctl enable story && \
sudo systemctl status story
