#!/bin/sh

letsgo () {
ethaddress="$(jq -r '.eth' /1/config/user.json)"

twitterprofile="$(curl -s "https://raw.githubusercontent.com/Uniswap/sybil-list/master/verified.json" | jq -r ".\"$ethaddress\".twitter.handle")"

if [ "$twitterprofile" = "null" ]; then
   echo "Account $ethaddress have no verified Twitter profile at Sybil.org"
fi
}

if online -s; then letsgo; else echo "Cannot verify Twitter profile. Your device is offline."; fi
