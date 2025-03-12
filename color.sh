#!/bin/bash

address_north=192.168.86.64
address_south=192.168.86.55

declare -A palettes
palettes=(
  ["ireland"]="[[0,255,0],[255,255,255],[255,160,0]]"
  ["thanksgiving"]="[[204,85,0],[102,51,0],[255,215,0]]"
  ["xmas"]="[[128,0,0],[0,100,0],[192,192,192]]"
  ["winter"]="[[173,216,230],[255,250,250],[229,228,226]]"
  ["easter"]="[[230,230,250],[255,255,224],[152,251,152]]"
)

if [ -z "$1" ]; then
  echo "Usage: $0 <palette_name>"
  echo "Available palettes:"
  for palette in "${!palettes[@]}"; do
    echo "  $palette"
  done
  exit 1
fi

palette_name="$1"

if [[ "${palettes[$palette_name]}" != "" ]]; then
  colors="${palettes[$palette_name]}"
else
  echo "Palette '$palette_name' not found."
  echo "Available palettes:"
  for palette in "${!palettes[@]}"; do
    echo "  $palette"
  done
  exit 1
fi

json=$(jq -c -n --argjson colors "$colors" '{seg:[{col:$colors}]}')

curl -H "Content-Type: application/json" -d "$json" http://$address_north/json/state
curl -H "Content-Type: application/json" -d "$json" http://$address_south/json/state
