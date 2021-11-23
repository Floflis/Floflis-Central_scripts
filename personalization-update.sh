#!/bin/bash -e

background=$(gsettings get org.cinnamon.desktop.background picture-uri | tr -d "'")

cat > /1/config/personalization.json << ENDOFFILE
{
	"background": ""
}
ENDOFFILE
contents="$(jq ".background = \"$background\"" /1/config/personalization.json)" && \
echo "${contents}" > /1/config/personalization.json
