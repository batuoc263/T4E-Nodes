# Installation
```
wget https://raw.githubusercontent.com/batuoc263/T4E-Nodes/main/Story/Install.sh && chmod +x Install.sh && ./Install.sh
```

Nhập moniker, Enter

# Snapshot
```
wget https://raw.githubusercontent.com/batuoc263/T4E-Nodes/main/Story/snapshot.sh && chmod +x snapshot.sh && ./snapshot.sh
```

# Create Validator
story validator export --export-evm-key
cat /root/.story/story/config/private_key.txt
story validator create --stake 1000000000000000000 --private-key "<private_key>"


# Submit to dev-chat channel
You can submit with this template:
```
Dear Tim, 
My validator created successfully

My validator info:
Moniker: DCValidator
EVM address: 0x7D8623559CC7747c6Ba7477571759e739f59E914
Transaction hash: 0x6681227eabdcfa3ed09cb1f9cc7379ea4afc756db4dccabb2416634f58b7ea71
Explorer URL: https://testnet.storyscan.xyz/tx/0x6681227eabdcfa3ed09cb1f9cc7379ea4afc756db4dccabb2416634f58b7ea71

Thank you, sir
```
