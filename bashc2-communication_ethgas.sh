#!/bin/bash -e

if [ ! -f /tmp/bashc2-communication_ethgas.json ]; then
   echo "Starting bashc2-communication_ethgas.sh..."
   cat > /tmp/bashc2-communication_ethgas.json << ENDOFFILE
{
	"ethgas_gasno": "",
	"ethgas_icon": "",
	"ethgas_oneline": ""
}
ENDOFFILE
fi

ethgas_gasno="$(ethgas gasno)"
contents="$(jq ".ethgas_gasno = \"$ethgas_gasno\"" /tmp/bashc2-communication_ethgas.json)" && \
echo "${contents}" > /tmp/bashc2-communication_ethgas.json

ethgas_icon="$(ethgas icon)"
contents="$(jq ".ethgas_icon = \"$ethgas_icon\"" /tmp/bashc2-communication_ethgas.json)" && \
echo "${contents}" > /tmp/bashc2-communication_ethgas.json

ethgas_oneline="$(ethgas oneline)"
contents="$(jq ".ethgas_oneline = \"$ethgas_oneline\"" /tmp/bashc2-communication_ethgas.json)" && \
echo "${contents}" > /tmp/bashc2-communication_ethgas.json
