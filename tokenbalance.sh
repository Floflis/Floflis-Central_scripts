#!/bin/bash -e

flouser=$(logname)
         cat > /1/config/user.json << ENDOFFILE
       {"name":"", "eth":""}
ENDOFFILE
         contents="$(jq ".name = \"$flouser\"" /1/config/user.json)" && \
         echo "${contents}" > /1/config/user.json
         contents="$(jq ".eth = \"0xDDfC2e10702d8A781727A34D83B3bb3CA94a3E91\"" /1/config/user.json)" && \
         echo "${contents}" > /1/config/user.json
         #- TASK: read from JSON after Floflis creates ETH address

ethaddress="$(jq -r '.eth' /1/config/user.json)"
ethuser="$(ethereal ens domain get --address=$ethaddress)"

rpc_polygon="https://rpc-mainnet.maticvigil.com/"
rpc_xdai="https://rpc.xdaichain.com/"

tokenFULLbalancematic="$(ethereal --connection=$rpc_polygon token balance --holder=$ethaddress --token=0xea2746be6cf47f376e9b9d6b78a47707559c3a8e)"
tokenbalancematic="$(printf "%.2f\n" $(echo "$tokenFULLbalancematic" | bc -l))"


tokenFULLbalancexdai="$(ethereal --connection=$rpc_xdai token balance --holder=$ethaddress --token=0x4a59AD9993d763B6125A52dAc5A44f4aE570E793)"
tokenbalancexdai="$(printf "%.2f\n" $(echo "$tokenFULLbalancexdai" | bc -l))"

#tokentotalbalance="$((tokenbalancematic + tokenbalancexdai))"
#tokentotalbalance="$(expr $tokenbalancematic - $tokenbalancexdai)"

#((count = tokenbalancematic - tokenbalancexdai))

tokentotalbalance=$(echo "$tokenbalancematic + $tokenbalancexdai"|bc)

echo "User: $ethuser ($ethaddress)"
echo "----"
if [ "$tokenbalancematic" != "0" ]; then
   echo "FLOF balance @ Polygon: $tokenbalancematic"
fi
if [ "$tokenbalancexdai" != "0" ]; then
   echo "FLOF balance @ XDai: $tokenbalancexdai"
fi
echo "----"
echo "FLOF total balance: $tokentotalbalance"
#echo "FLOF total balance: $count"




cat > /1/config/tokens.json << ENDOFFILE
{
	"flof": {
		"polygon": "",
		"xdai": "",
		"total": ""
	}
}
ENDOFFILE
         contents="$(jq ".flof.polygon = \"$tokenbalancematic\"" /1/config/tokens.json)" && \
         echo "${contents}" > /1/config/tokens.json
         contents="$(jq ".flof.xdai = \"$tokenbalancexdai\"" /1/config/tokens.json)" && \
         echo "${contents}" > /1/config/tokens.json
         contents="$(jq ".flof.total = \"$tokentotalbalance\"" /1/config/tokens.json)" && \
         echo "${contents}" > /1/config/tokens.json
