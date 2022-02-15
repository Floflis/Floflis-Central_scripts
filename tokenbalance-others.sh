#!/bin/bash -e

ethaddress="$(jq -r '.eth' /1/config/user.json)"

#rpc_ethereum="https://main-light.eth.linkpool.io/"
rpc_polygon="https://rpc-mainnet.maticvigil.com/"
rpc_xdai="https://rpc.xdaichain.com/"
#rpc_ronin=""

#cat /1/config/tokens.json | jq '. + {"eth":{"ethereum":"","polygon":"","xdai":"","ronin":"","total":""}}' | tee /1/config/tokens.json
if [ "$(jq -r '.eth' /1/config/tokens.json)" = "null" ]; then
   echo "Its your first time using tokenbalance-others.sh!"
   echo "Initializing for ETH token..."
   tmp="$(mktemp)"; cat /1/config/tokens.json | jq '. + {"eth":{"ethereum":"","polygon":"","xdai":"","ronin":"","total":"","totalusd":""}}' >"$tmp" && mv "$tmp" /1/config/tokens.json
fi

#cat /1/config/tokens.json | jq '. + {"pla":{"polygon":"","xdai":"","total":""}}' | tee /1/config/tokens.json
if [ "$(jq -r '.pla' /1/config/tokens.json)" = "null" ]; then
   echo "Initializing for PLA token..."
   tmp="$(mktemp)"; cat /1/config/tokens.json | jq '. + {"pla":{"polygon":"","xdai":"","total":"","totalusd":""}}' >"$tmp" && mv "$tmp" /1/config/tokens.json
fi

#game polygon 

if [ "$(jq -r '.game' /1/config/tokens.json)" = "null" ]; then
   echo "Initializing for GAME token..."
   tmp="$(mktemp)"; cat /1/config/tokens.json | jq '. + {"game":{"polygon":"","xdai":"","total":"","totalusd":""}}' >"$tmp" && mv "$tmp" /1/config/tokens.json
fi

#cat /1/config/tokens.json | jq '. + {"mana":{"ethereum":"","polygon":"","xdai":"","total":""}}' | tee /1/config/tokens.json
if [ "$(jq -r '.mana' /1/config/tokens.json)" = "null" ]; then
   echo "Initializing for MANA token..."
   tmp="$(mktemp)"; cat /1/config/tokens.json | jq '. + {"mana":{"ethereum":"","polygon":"","xdai":"","total":"","totalusd":""}}' >"$tmp" && mv "$tmp" /1/config/tokens.json
fi

if [ "$(jq -r '.sand' /1/config/tokens.json)" = "null" ]; then
   echo "Initializing for SAND token..."
   tmp="$(mktemp)"; cat /1/config/tokens.json | jq '. + {"sand":{"ethereum":"","polygon":"","total":"","totalusd":""}}' >"$tmp" && mv "$tmp" /1/config/tokens.json
fi

if [ "$(jq -r '.dai' /1/config/tokens.json)" = "null" ]; then
   echo "Initializing for DAI token..."
   tmp="$(mktemp)"; cat /1/config/tokens.json | jq '. + {"dai":{"ethereum":"","polygon":"","xdai":"","total":"","totalusd":""}}' >"$tmp" && mv "$tmp" /1/config/tokens.json
fi

#cat /1/config/tokens.json | jq '. + {"dai":{"ethereum":"","polygon":"","xdai":"","total":""}}' | tee /1/config/tokens.json
#cat /1/config/tokens.json | jq '. + {"matic":{"ethereum":"","polygon":"","total":""}}' | tee /1/config/tokens.json

#cat /1/config/tokens.json | jq '. + {"slp":{"ethereum":"","ronin":"","total":""}}' | tee /1/config/tokens.json

#slp ethereum 0xCC8Fa225D80b9c7D42F96e9570156c65D6cAAa25
#slp ronin 0xa8754b9fa15fc18bb59458815510e40a12cd2014

#cat /1/config/tokens.json | jq '. + {"axs":{"ethereum":"","ronin":"","total":""}}' | tee /1/config/tokens.json

#axs ethereum 
#axs ronin 

#cat /1/config/tokens.json | jq '. + {"usdc":{"ethereum":"","polygon":"","xdai":"","ronin":"","total":""}}' | tee /1/config/tokens.json

#usdc ethereum 
#usdc polygon 
#usdc xdai 
#usdc ronin 

if [ "$(jq -r '.usd' /1/config/tokens.json)" = "null" ]; then
   echo "Initializing for USD..."
   tmp="$(mktemp)"; cat /1/config/tokens.json | jq '. + {"usd":{"total":""}}' >"$tmp" && mv "$tmp" /1/config/tokens.json
fi

processtoken () {
if [ "$currenttoken" = "eth" ]; then
   currenttoken_ethereum=""
   currenttoken_polygon="0x7ceb23fd6bc0add59e62ac25578270cff1b9f619"
   currenttoken_xdai="0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1"
   currenttoken_coingeckoname="ethereum"
   echo "Updating ETH token..."
fi

if [ "$currenttoken" = "pla" ]; then
   currenttoken_ethereum=""
   currenttoken_polygon="0x1b07d1ae73fa0601e15ac6bd71807469d9d650c6"
   currenttoken_xdai="0x32F13A6585D38e14D4F70c481e58A23767964a07"
   currenttoken_coingeckoname=""
   echo "Updating PLA token..."
fi

if [ "$currenttoken" = "game" ]; then
   currenttoken_ethereum=""
   currenttoken_polygon=""
   currenttoken_xdai="0x4a1901b120e777a2c3d0A19ef41B264cdBCdEe69"
   currenttoken_coingeckoname=""
   echo "Updating GAME token..."
fi

if [ "$currenttoken" = "mana" ]; then
   currenttoken_ethereum="0x0f5d2fb29fb7d3cfee444a200298f468908cc942"
   currenttoken_polygon="0xa1c57f48f0deb89f569dfbe6e2b7f46d33606fd4"
   currenttoken_xdai="0x7838796B6802B18D7Ef58fc8B757705D6c9d12b3"
   currenttoken_coingeckoname="decentraland"
   echo "Updating MANA token..."
fi

if [ "$currenttoken" = "sand" ]; then
   currenttoken_ethereum="0x3845badade8e6dff049820680d1f14bd3903a5d0"
   currenttoken_polygon="0xbbba073c31bf03b8acf7c28ef0738decf3695683"
   currenttoken_xdai=""
   currenttoken_coingeckoname="the-sandbox"
   echo "Updating SAND token..."
fi

if [ "$currenttoken" = "dai" ]; then
   currenttoken_ethereum="0x6b175474e89094c44da98b954eedeac495271d0f"
   currenttoken_polygon="0x8f3cf7ad23cd3cadbd9735aff958023239c6a063"
   currenttoken_xdai=""
   currenttoken_coingeckoname="dai"
   echo "Updating DAI token..."
fi

#if [ "$currenttoken_ethereum" != "" ]; then
#   tokenFULLbalanceeth="$(ethereal token balance --holder=$ethaddress --token=$currenttoken_ethereum)"
#   tokenbalanceeth="$(printf "%.2f\n" $(echo "$tokenFULLbalanceeth" | bc -l))"
#fi

tokenFULLbalanceeth="$(ethereal token balance --holder=$ethaddress --token=$currenttoken_ethereum)"
tokenbalanceeth="$(printf "%.2f\n" $(echo "$tokenFULLbalanceeth" | bc -l))"

tokenFULLbalancematic="$(ethereal --connection=$rpc_polygon token balance --holder=$ethaddress --token=$currenttoken_polygon)"
tokenbalancematic="$(printf "%.2f\n" $(echo "$tokenFULLbalancematic" | bc -l))"

tokenFULLbalancexdai="$(ethereal --connection=$rpc_xdai token balance --holder=$ethaddress --token=$currenttoken_xdai)"
tokenbalancexdai="$(printf "%.2f\n" $(echo "$tokenFULLbalancexdai" | bc -l))"

#tokenFULLbalanceron="$(ethereal --connection=$rpc_ronin token balance --holder=$ethaddress --token=$currenttoken_ronin)"
#tokenbalanceron="$(printf "%.2f\n" $(echo "$tokenFULLbalanceron" | bc -l))"

tokentotalbalance=$(echo "$tokenbalanceeth + $tokenbalancematic + $tokenbalancexdai"|bc)

tokenUSDtotalbalanceget="$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=$currenttoken_coingeckoname&vs_currencies=usd" | jq -r ".\"$currenttoken_coingeckoname\".usd")"
tokenUSDtotalbalance=$(echo "$tokentotalbalance * $tokenUSDtotalbalanceget"|bc)

#echo "USD: $tokenUSDtotalbalance. Used: $tokentotalbalance and $tokenUSDtotalbalanceget"
}

currenttoken="eth"
processtoken
#-
ethbalanceprepare="$(ethereal ether balance --address=$ethaddress)"
ethbalance="$(echo "$ethbalanceprepare" | sed 's/ Ether//g')"
# https://askubuntu.com/a/1007368/1255788
contents="$(jq ".eth.ethereum = \"$ethbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
#-
contents="$(jq ".eth.polygon = \"$tokenbalancematic\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".eth.xdai = \"$tokenbalancexdai\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
#-
tokentotalbalance=$(echo "$ethbalance + $tokenbalancematic + $tokenbalancexdai"|bc)
tokenUSDtotalbalance=$(echo "$tokentotalbalance * $tokenUSDtotalbalanceget"|bc)
#-
contents="$(jq ".eth.total = \"$tokentotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".eth.totalusd = \"$tokenUSDtotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json

currenttoken="pla"
processtoken
contents="$(jq ".pla.polygon = \"$tokenbalancematic\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".pla.xdai = \"$tokenbalancexdai\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".pla.total = \"$tokentotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".pla.totalusd = \"$tokenUSDtotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json

currenttoken="game"
processtoken
contents="$(jq ".game.polygon = \"$tokenbalancematic\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".game.xdai = \"$tokenbalancexdai\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".game.total = \"$tokentotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".game.totalusd = \"$tokenUSDtotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json

currenttoken="mana"
processtoken
contents="$(jq ".mana.ethereum = \"$tokenbalanceeth\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".mana.polygon = \"$tokenbalancematic\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".mana.xdai = \"$tokenbalancexdai\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".mana.total = \"$tokentotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".mana.totalusd = \"$tokenUSDtotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json

currenttoken="sand"
processtoken
contents="$(jq ".sand.ethereum = \"$tokenbalanceeth\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".sand.polygon = \"$tokenbalancematic\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".sand.total = \"$tokentotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".sand.totalusd = \"$tokenUSDtotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json

currenttoken="dai"
processtoken
contents="$(jq ".dai.ethereum = \"$tokenbalanceeth\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".dai.polygon = \"$tokenbalancematic\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
#-
daibalanceprepare="$(ethereal --connection=$rpc_xdai ether balance --address=$ethaddress)"
daibalance="$(echo "$daibalanceprepare" | sed 's/ Ether//g')"
contents="$(jq ".dai.xdai = \"$daibalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
tokentotalbalance=$(echo "$tokenbalanceeth + $tokenbalancematic + $daibalance"|bc)
tokenUSDtotalbalance=$(echo "$tokentotalbalance * $tokenUSDtotalbalanceget"|bc)
#-
contents="$(jq ".dai.total = \"$tokentotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
contents="$(jq ".dai.totalusd = \"$tokenUSDtotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json

tmp1="$(jq -r '.flof.totalusd' /1/config/tokens.json)"
tmp2="$(jq -r '.eth.totalusd' /1/config/tokens.json)"
tmp3="$(jq -r '.pla.totalusd' /1/config/tokens.json)"
tmp4="$(jq -r '.game.totalusd' /1/config/tokens.json)"
tmp5="$(jq -r '.mana.totalusd' /1/config/tokens.json)"
tmp6="$(jq -r '.sand.totalusd' /1/config/tokens.json)"
tmp7="$(jq -r '.dai.totalusd' /1/config/tokens.json)"
alltokensUSDtotalbalance=$(echo "$tmp1 + $tmp2 + $tmp3 + $tmp4 + $tmp5 + $tmp6 + $tmp7"|bc)
contents="$(jq ".usd.total = \"$alltokensUSDtotalbalance\"" /1/config/tokens.json)" && \
echo "${contents}" > /1/config/tokens.json
