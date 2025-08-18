#!/usr/bin/env zsh

# set -e

echo "Address,Long,Lat" > gares-geo.csv

while IFS= read -r line; do
  line_filtered=$(echo $line | sed 's/ VILLE//')

  coordinates=$( \
    grep -m 1 -i "$line_filtered" liste-des-gares.simple.csv \
    | cut --delimiter ";" --fields 4,5 | tr ";" "," \
  )

  if [[ $coordinates == "" ]];
    then echo ERROR: $line;
  else
    echo $line,$coordinates | tee --append gares-geo.csv
  fi
done < gares.txt
