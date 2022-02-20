#!/bin/bash -e

ethaddress="$(jq -r '.eth' /1/config/user.json)"

if [ "$(jq -r '.danimesqart' /1/config/nfts.json)" = "null" ] || [ "$(jq -r '.danimesqart' /1/config/nfts.json)" = "" ]; then
   echo "Its your first time using nfts-parse.sh!"
   echo "Initializing..."
   cat > /1/config/nfts.json << ENDOFFILE
{
	"danimesqart": {
		"1": [{
		        "balance": "",
			"metadata": "",
			"name": "",
			"description": "",
			"image": ""
		}]
	}
}
ENDOFFILE
fi

processbalances () {
if [ "$currentnft" = "danimesqart" ]; then
   currentnft_ethereum="0x1b6b3026B7F5531086f3B8e6CC31C6564BBE2849"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="universal-abi.json"
#   currentnft_coingeckoname="ethereum"
   echo "Updating Daniell Mesquita's Arts NFT..."
fi

if [ "$currentnft_ethereum" != "" ]; then
   nftFULLbalanceeth="$(ethereal contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
   echo "Balance: $nftFULLbalanceeth"
#   nftbalanceeth="$(printf "%.2f\n" $(echo "$nftFULLbalanceeth" | bc -l))"
else
   if [ "$currentnft_polygon" != "" ]; then
      nftFULLbalancematic="$(ethereal --connection=$rpc_polygon contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
#      nftbalancematic="$(printf "%.2f\n" $(echo "$nftFULLbalancematic" | bc -l))"
fi

   if [ "$currentnft_xdai" != "" ]; then
      nftFULLbalancexdai="$(ethereal --connection=$rpc_xdai contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
#      nftbalancexdai="$(printf "%.2f\n" $(echo "$nftFULLbalancexdai" | bc -l))"
fi
fi

#nfttotalbalance=$(echo "$tokenbalanceeth + $tokenbalancematic + $tokenbalancexdai"|bc)

#nfttotalbalance=$(echo "$nftFULLbalanceeth + $nftFULLbalancematic + $nftFULLbalancexdai"|bc)
#echo "total bal: $nfttotalbalance"
}

currentnft="danimesqart"
processbalances
