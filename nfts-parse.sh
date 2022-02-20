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

if [ "$(jq -r '.x' /1/config/nfts.json)" = "null" ]; then
   echo "Initializing for ExpansionPunks NFT..."
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + "x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp0="$(mktemp)"; cat /1/config/nfts.json | jq '. + "x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + "x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"expansionpunks":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
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

if [ "$currentnft" = "expansionpunks" ]; then
   currentnft_ethereum="0x0d0167a823c6619d430b1a96ad85b888bcf97c37"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="universal-abi.json"
#   currentnft_coingeckoname="ethereum"
   echo "Updating ExpansionPunks NFT..."
fi

if [ "$currentnft_ethereum" != "" ]; then
   nftFULLbalanceeth="$(ethereal contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
   #nftbalanceethprepare="$(printf "%.2f\n" $(echo "$nftFULLbalanceeth" | bc -l))"
   #nftbalanceeth="$(echo "$nftbalanceethprepare" | tr -d "[" | tr -d "]")"
   nftbalanceeth="$(echo "$nftFULLbalanceeth" | tr -d "[" | tr -d "]")"
   echo "Balance: $nftbalanceeth"
else
   if [ "$currentnft_polygon" != "" ]; then
      nftFULLbalancematic="$(ethereal --connection=$rpc_polygon contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
      #nftbalancematic="$(printf "%.2f\n" $(echo "$nftFULLbalancematic" | bc -l))"
      #nftbalancematic="$(echo "$nftbalancematicprepare" | tr -d "[" | tr -d "]")"
      nftbalancematic="$(echo "$nftFULLbalancematic" | tr -d "[" | tr -d "]")"
      echo "Balance: $nftbalancematic"
fi

   if [ "$currentnft_xdai" != "" ]; then
      nftFULLbalancexdai="$(ethereal --connection=$rpc_xdai contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
      #nftbalancexdai="$(printf "%.2f\n" $(echo "$nftFULLbalancexdai" | bc -l))"
      #nftbalancexdai="$(echo "$nftbalancexdaiprepare" | tr -d "[" | tr -d "]")"
      nftbalancexdai="$(echo "$nftFULLbalancexdai" | tr -d "[" | tr -d "]")"
      echo "Balance: $nftbalancexdai"
fi
fi

#nfttotalbalance=$(echo "$nftbalanceeth + $nftbalancematic + $nftbalancexdai"|bc)
#echo "total bal: $nfttotalbalance"
}

currentnft="danimesqart"
processbalances
contents="$(jq ".danimesqart.\"1\"[].balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json

currentnft="expansionpunks"
processbalances
contents="$(jq ".expansionpunks.\"1\"[].balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json
