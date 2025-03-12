#!/bin/bash

address_north=192.168.86.64
address_south=192.168.86.55

brightness="$1"

json=$(jq -c -n --argjson brightness "$brightness" '{seg:[{bri:$brightness}]}')

curl -H "Content-Type: application/json" -d "$json" http://$address_north/json/state
curl -H "Content-Type: application/json" -d "$json" http://$address_south/json/state
