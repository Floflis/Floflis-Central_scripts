#!/bin/sh

if [ "$(jq -r '.sybil' /1/config/user.json)" = "null" ]; then
   echo "Its your first time using 'ethaddress-sybil_verify'!"
   echo "Initializing..."
   cat /1/config/user.json | jq '. + {"sybil": ""}' | tee /1/config/user.json
fi

letsgo () {
ethaddress="$(jq -r '.eth' /1/config/user.json)"

twitterprofile="$(curl -s "https://raw.githubusercontent.com/Uniswap/sybil-list/master/verified.json" | jq -r ".\"$ethaddress\".twitter.handle")"

if [ "$twitterprofile" = "null" ]; then
   echo "Account $ethaddress have no verified Twitter profile at Sybil.org"
   
else
   echo "$ethaddress's verified Twitter profile at Sybil.org is:"
   echo "$twitterprofile"
fi
}

if online -s; then letsgo; else echo "Cannot verify Twitter profile. Your device is offline."; fi
