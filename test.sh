#!/bin/bash -e

localcurrency="brl"
#usdlocal_rates="$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=dai&vs_currencies=$localcurrency" | jq -r '.dai.$localcurrency')"
usdlocal_ratestmp="$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=dai&vs_currencies=$localcurrency")"
usdlocal_rates="$(echo "$usdlocal_ratestmp" | jq -r ".dai.$localcurrency")"

totalbalance_usd="1000"
totalbalance_local=$(echo "$totalbalance_usd * $usdlocal_rates"|bc)

echo "Total BRL: $totalbalance_local"
