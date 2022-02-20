#!/bin/bash -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

ethaddress="$(jq -r '.eth' /1/config/user.json)"

if [ "$(jq -r '.flof' /1/config/nfts.json)" = "null" ] || [ "$(jq -r '.flof' /1/config/nfts.json)" = "" ]; then
   echo "Its your first time using nfts-parse.sh!"
   echo "Initializing..."
   cat > /1/config/nfts.json << ENDOFFILE
{
	"danimesqart": {
		"1": ""
	}
}
ENDOFFILE
fi



#cd "$SCRIPTPATH"
