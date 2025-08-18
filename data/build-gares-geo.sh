#!/usr/bin/env zsh

# set -e

echo "Address,Long,Lat" > gares-geo.csv

while IFS= read -r line; do
  line_filtered=$( \
    echo $line \
    | sed 's/ VILLE//' \
    | tr " " "-" \
    | sed 's/-TGV//' \
    | sed 's/ST-/SAINT-/' \
    | sed 's/(intramuros)//' \
  )

  coordinates=$( \
    cat liste-des-gares.simple.csv \
    | tr " " "-" \
    | sed 's/-TGV//' \
    | sed 's/ST-/SAINT-/' \
    | tr ";" "," \
    | grep -m 1 -i "$line_filtered" \
    | cut --delimiter "," --fields 4,5 \
  )

  if [[ $line = "MONTAUBAN VILLE BOURBON" ]];
    then coordinates="1.341127241507155,44.014195331668475"
  elif [[ -n $(echo $line | grep -i HBF) ]];
    then continue
  fi

  if [[ $coordinates == "" ]];
    then echo ERROR: $line	$line_filtered;
  else
    echo $line,$coordinates | tee --append gares-geo.csv
  fi
done < gares.txt
