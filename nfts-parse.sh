#!/bin/bash -e

ethaddress="$(jq -r '.eth' /1/config/user.json)"

rpc_polygon="https://rpc-mainnet.maticvigil.com/"
rpc_xdai="https://rpc.gnosischain.com/"

if [ "$(jq -r '.danimesqart' /1/config/nfts.json)" = "null" ] || [ "$(jq -r '.danimesqart' /1/config/nfts.json)" = "" ]; then
   echo "Its your first time using nfts-parse.sh!"
   echo "Initializing..."
   cat > /1/config/nfts.json << ENDOFFILE
{
	"danimesqart": {
	        "balance": "",
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

if [ "$(jq -r '.expansionpunks' /1/config/nfts.json)" = "null" ]; then
   echo "Initializing for ExpansionPunks NFT..."
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + "x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp0="$(mktemp)"; cat /1/config/nfts.json | jq '. + "x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + "x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   #tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"x":{"1":[{"balance":"","metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
   tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"expansionpunks":{"balance":"","1":[{"metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
fi

if [ "$(jq -r '.axiepet' /1/config/nfts.json)" = "null" ]; then
   echo "Initializing for Axie pet NFT..."
   tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"axiepet":{"balance":"","1":[{"metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
fi

if [ "$(jq -r '.rockstarsofepns' /1/config/nfts.json)" = "null" ]; then
   echo "Initializing for Rockstars of EPNS NFT..."
   tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"rockstarsofepns":{"balance":"","1":[{"metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
fi

if [ "$(jq -r '.poap' /1/config/nfts.json)" = "null" ]; then
   echo "Initializing for Proof of Attendance (PoAP) badges NFT..."
   tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"poap":{"balance":"","1":[{"metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
fi

if [ "$(jq -r '.ens' /1/config/nfts.json)" = "null" ]; then
   echo "Initializing for ENS domains NFT..."
   tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"ens":{"balance":"","1":[{"metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
fi

if [ "$(jq -r '.cryptokitties' /1/config/nfts.json)" = "null" ]; then
   echo "Initializing for CryptoKitties NFT..."
   tmp="$(mktemp)"; cat /1/config/nfts.json | jq '. + {"cryptokitties":{"balance":"","1":[{"metadata":"","name":"","description":"","image":""}]}}' >"$tmp" && mv "$tmp" /1/config/nfts.json
fi

processbalances () {
if [ "$currentnft" = "danimesqart" ]; then
   currentnft_ethereum="0x1b6b3026B7F5531086f3B8e6CC31C6564BBE2849"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="universal-abi.json"
   echo "Updating Daniell Mesquita's Arts NFT..."
fi

if [ "$currentnft" = "expansionpunks" ]; then
   currentnft_ethereum="0x0d0167a823c6619d430b1a96ad85b888bcf97c37"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="universal-abi.json"
   echo "Updating ExpansionPunks NFT..."
fi

if [ "$currentnft" = "axiepet" ]; then
   currentnft_ethereum="0xf5b0a3efb8e8e4c201e2a935f110eaaf3ffecb8d"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="abi-axie.json"
   echo "Updating Axie pet NFT..."
fi

if [ "$currentnft" = "rockstarsofepns" ]; then
   currentnft_ethereum="0x3f8C2152b79276b78315CAF66cCF951780580A8a"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="abi-rockstars_of_epns.json"
   echo "Updating Rockstars of EPNS NFT..."
fi

if [ "$currentnft" = "poap" ]; then
   currentnft_ethereum=""
   currentnft_polygon=""
   currentnft_xdai="0x22C1f6050E56d2876009903609a2cC3fEf83B415"
   currentnft_abi="universal-abi.json"
   echo "Updating Proof of Attendance (PoAP) badges NFT..."
fi

if [ "$currentnft" = "ens" ]; then
   currentnft_ethereum="0x57f1887a8bf19b14fc0df6fd9b2acc9af147ea85"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="universal-abi.json"
   echo "Updating ENS domains NFT..."
fi

if [ "$currentnft" = "cryptokitties" ]; then
   currentnft_ethereum="0x06012c8cf97bead5deae237070f9587f8e7a266d"
   currentnft_polygon=""
   currentnft_xdai=""
   currentnft_abi="universal-abi.json"
   echo "Updating CryptoKitties NFT..."
fi

if [ "$currentnft_ethereum" != "" ]; then
   nftFULLbalanceeth="$(ethereal contract call --contract=$currentnft_ethereum --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
   #nftbalanceethprepare="$(printf "%.2f\n" $(echo "$nftFULLbalanceeth" | bc -l))"
   #nftbalanceeth="$(echo "$nftbalanceethprepare" | tr -d "[" | tr -d "]")"
   nftbalanceeth="$(echo "$nftFULLbalanceeth" | tr -d "[" | tr -d "]")"
   echo "Balance: $nftbalanceeth"
else
   if [ "$currentnft_polygon" != "" ]; then
      nftFULLbalancematic="$(ethereal --connection=$rpc_polygon contract call --contract=$currentnft_polygon --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
      #nftbalancematicprepare="$(printf "%.2f\n" $(echo "$nftFULLbalancematic" | bc -l))"
      #nftbalancematic="$(echo "$nftbalancematicprepare" | tr -d "[" | tr -d "]")"
      nftbalancematic="$(echo "$nftFULLbalancematic" | tr -d "[" | tr -d "]")"
      echo "Balance: $nftbalancematic"
fi

   if [ "$currentnft_xdai" != "" ]; then
      nftFULLbalancexdai="$(ethereal --connection=$rpc_xdai contract call --contract=$currentnft_xdai --abi=abis/$currentnft_abi --call="balanceOf($ethaddress)" --from=$ethaddress)"
      #nftbalancexdaiprepare="$(printf "%.2f\n" $(echo "$nftFULLbalancexdai" | bc -l))"
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
#contents="$(jq ".danimesqart.\"1\"[].balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
#echo "${contents}" > /1/config/nfts.json
contents="$(jq ".danimesqart.balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json

currentnft="expansionpunks"
processbalances
contents="$(jq ".expansionpunks.balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json

currentnft="axiepet"
processbalances
contents="$(jq ".axiepet.balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json

currentnft="rockstarsofepns"
processbalances
contents="$(jq ".rockstarsofepns.balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json

currentnft="poap"
processbalances
contents="$(jq ".poap.balance = \"$nftbalancexdai\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json

currentnft="ens"
processbalances
contents="$(jq ".ens.balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json

currentnft="cryptokitties"
processbalances
contents="$(jq ".cryptokitties.balance = \"$nftbalanceeth\"" /1/config/nfts.json)" && \
echo "${contents}" > /1/config/nfts.json
