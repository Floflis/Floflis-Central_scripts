#!/bin/sh

echo "Getting user's ENS name..."

ethaddress="$(jq -r '.eth' /1/config/user.json)"
ensname="$(ethereal ens domain get --address=$ethaddress)"

echo "It is: $ethaddress"

if [ "$(jq -r '.ens' /1/config/user.json)" = "null" ]; then
   echo "Its your first time using ensname.sh!"
   echo "Initializing..."
   tmp="$(mktemp)"; cat /1/config/user.json | jq '. + {ens: ""}' >"$tmp" && mv "$tmp" /1/config/user.json
fi

contents="$(jq ".ens = \"$ensname\"" /1/config/user.json)" && \
echo "${contents}" > /1/config/user.json

if [ "$(jq -r '.ens' /1/config/user.json)" != "null" ]; then
   if [ "$(jq -r '.ens' /1/config/user.json)" = "$ensname" ]; then
      echo "Done!"
fi
fi
