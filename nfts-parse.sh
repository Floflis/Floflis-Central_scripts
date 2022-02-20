#!/bin/bash -e

ethaddress="$(jq -r '.eth' /1/config/user.json)"

if [ "$(jq -r '.flof' /1/config/nfts.json)" = "null" ] || [ "$(jq -r '.flof' /1/config/nfts.json)" = "" ]; then
   echo "Its your first time using nfts-parse.sh!"
   echo "Initializing..."
   cat > /1/config/nfts.json << ENDOFFILE
{
	"danimesqart": {
		"1": [{
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
   ethereal contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf(\"$ethaddress\")" --from=$ethaddress
else
   
fi
}

currentnft="danimesqart"
processbalances
