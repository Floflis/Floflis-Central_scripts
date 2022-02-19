#!/bin/sh

echo "Getting user's full name..."

user_name="$(logname)"
user_record="$(getent passwd $user_name)"
user_gecos_field="$(echo "$user_record" | cut -d ':' -f 5)"
user_full_name="$(echo "$user_gecos_field" | cut -d ',' -f 1)"
#echo "$user_full_name"
# https://stackoverflow.com/a/833256/5623661 (sorry for crediting the answer from someone who say "hysterical")

echo "It is: $user_full_name"

if [ "$(jq -r '.fullname' /1/config/user.json)" = "null" ]; then
   echo "Its your first time using fullname.sh!"
   echo "Initializing..."
   tmp="$(mktemp)"; cat /1/config/user.json | jq '. + {fullname: ""}' >"$tmp" && mv "$tmp" /1/config/user.json
fi

contents="$(jq ".fullname = \"$user_full_name\"" /1/config/user.json)" && \
echo "${contents}" > /1/config/user.json

if [ "$(jq -r '.fullname' /1/config/user.json)" != "null" ]; then
   if [ "$(jq -r '.fullname' /1/config/user.json)" = "$user_full_name" ]; then
      echo "Done!"
fi
fi
