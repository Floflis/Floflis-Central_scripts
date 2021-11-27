#!/bin/bash

ethaddress="0x535b3ddD9939056cB6d74D1253Ae1A4Adf5d723A" # example

curl -s "https://raw.githubusercontent.com/Uniswap/sybil-list/master/verified.json" | jq -r ".\"$ethaddress\".twitter.handle"
