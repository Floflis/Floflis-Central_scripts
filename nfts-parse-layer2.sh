#!/bin/bash -e

ethaddress="$(jq -r '.eth' /1/config/user.json)"

rpc_polygon="https://rpc-mainnet.maticvigil.com/"
rpc_xdai="https://rpc.gnosischain.com/"

#https://blockscout.com/xdai/mainnet/address/0x22C1f6050E56d2876009903609a2cC3fEf83B415/transactions
#ethereal contract call --connection=https://rpc.gnosischain.com/ --contract=0x22C1f6050E56d2876009903609a2cC3fEf83B415 --abi=universal-abi.json --call='balanceOf(0xDDfC2e10702d8A781727A34D83B3bb3CA94a3E91)' --from=0xDDfC2e10702d8A781727A34D83B3bb3CA94a3E91
#ethereal contract call --connection=https://rpc.gnosischain.com/ --contract=0x22C1f6050E56d2876009903609a2cC3fEf83B415 --abi=universal-abi.json --call='tokenOfOwnerByIndex(0xDDfC2e10702d8A781727A34D83B3bb3CA94a3E91,0)' --from=0xDDfC2e10702d8A781727A34D83B3bb3CA94a3E91
