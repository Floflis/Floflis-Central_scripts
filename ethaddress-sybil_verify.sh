#!/bin/sh

if [ "$(jq -r '.sybiltwitter' /1/config/user.json)" = "null" ]; then
   echo "Its your first time using 'ethaddress-sybil_verify'!"
   echo "Initializing..."
   cat /1/config/user.json | jq '. + {"sybiltwitter": ""}' | tee /1/config/user.json
fi

letsgo () {
ethaddress="$(jq -r '.eth' /1/config/user.json)"

twitterprofile="$(curl -s "https://raw.githubusercontent.com/Uniswap/sybil-list/master/verified.json" | jq -r ".\"$ethaddress\".twitter.handle")"

if [ "$twitterprofile" = "null" ]; then
   contents="$(jq '.sybiltwitter = "no"' /1/config/user.json)" && \
   echo "${contents}" > /1/config/user.json
   echo "⚠ Account $ethaddress have no verified Twitter profile at Sybil.org"
   
else
   contents="$(jq ".sybiltwitter = \"$twitterprofile\"" /1/config/user.json)" && \
   echo "${contents}" > /1/config/user.json
   echo "✅ $ethaddress's verified Twitter profile at Sybil.org is:"
   echo "$twitterprofile"
fi
}

if online -s; then letsgo; else echo "📶❌ Cannot verify Twitter profile. Your device is offline."; fi
