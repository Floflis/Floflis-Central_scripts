#!/bin/bash -e

cat /1/config/tokens.json | jq '. + {"pla":{"polygon":"","xdai":"","total":""}}' | tee /1/config/tokens.json
cat /1/config/tokens.json | jq '. + {"mana":{"ethereum":"","polygon":"","xdai":"","total":""}}' | tee /1/config/tokens.json

#mana ethereum 0x0f5d2fb29fb7d3cfee444a200298f468908cc942
#mana polygon 0xa1c57f48f0deb89f569dfbe6e2b7f46d33606fd4
#mana xdai 0x7838796B6802B18D7Ef58fc8B757705D6c9d12b3
#https://api.coingecko.com/api/v3/simple/price?ids=decentraland&vs_currencies=usd

#pla polygon 0x1b07d1ae73fa0601e15ac6bd71807469d9d650c6
#pla xdai 0x32F13A6585D38e14D4F70c481e58A23767964a07

#cat /1/config/tokens.json | jq '. + {"eth":{"ethereum":"","polygon":"","xdai":"","ronin":"","total":""}}' | tee /1/config/tokens.json
#cat /1/config/tokens.json | jq '. + {"dai":{"ethereum":"","polygon":"","xdai":"","total":""}}' | tee /1/config/tokens.json
#cat /1/config/tokens.json | jq '. + {"matic":{"ethereum":"","polygon":"","total":""}}' | tee /1/config/tokens.json

#cat /1/config/tokens.json | jq '. + {"slp":{"ethereum":"","ronin":"","total":""}}' | tee /1/config/tokens.json
#cat /1/config/tokens.json | jq '. + {"axs":{"ethereum":"","ronin":"","total":""}}' | tee /1/config/tokens.json
#cat /1/config/tokens.json | jq '. + {"usdc":{"ethereum":"","polygon":"","xdai":"","ronin":"","total":""}}' | tee /1/config/tokens.json
