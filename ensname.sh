#!/bin/sh

ethaddress="$(jq -r '.eth' /1/config/user.json)"
ensname="$(ethereal ens domain get --address=$ethaddress)"

if [ "$(jq -r '.ens' /1/config/user.json)" = "null" ]; then
   echo "Its your first time using ensname.sh!"
   echo "Initializing..."
   tmp="$(mktemp)"; cat /1/config/user.json | jq '. + {ens: ""}' >"$tmp" && mv "$tmp" /1/config/user.json
fi

contents="$(jq ".ens = \"$ensname\"" /1/config/user.json)" && \
echo "${contents}" > /1/config/user.json
