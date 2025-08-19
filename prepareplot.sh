#!/usr/bin/env bash

outfile="$1.csv"

echo "Address,Long,Lat" | tee "$outfile"

while IFS= read -r line; do
  # echo searching $line
  grep -m 1 "$line" data/gares-geo.csv \
    | tee --append "$outfile"
done < $1
