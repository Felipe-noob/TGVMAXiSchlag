#!/usr/bin/env zsh

# set -e

# prepare data base
cut -d ";" -f 2,8,9,14,15 liste-des-gares.csv \
  | recode -f utf8..flat \
  | tr "[:lower:]" "[:upper:]" \
  | tr " ;" "-," \
  | sed 's/-TGV//' \
  | sed 's/ST-/SAINT-/' \
  > sncf.csv

# generate final database
echo "Address,Long,Lat" > gares-geo.csv

while IFS= read -r line; do
  line_filtered=$( \
    echo $line \
    | tr "[:lower:]" "[:upper:]" \
    | sed 's/ VILLE//' \
    | tr " " "-" \
    | sed 's/-TGV//' \
    | sed 's/ST-/SAINT-/' \
    | sed 's/(INTRAMUROS)//' \
  )

  if [[ $line = "L'ARGENTIERE LES ECRINS   (05)" ]]
    then line_filtered="L'ARGENTIERE-LES-ECRINS"
  elif [[ $line = "MEUSE TGV" ]]
    then line_filtered="LES-TROIS-DOMAINES"
  elif [[ $line = "RENNES" ]]
    then line_filtered=",RENNES,"
  elif [[ $line = "MOUTIERS SALINS BRIDES L BAINS" ]]
    then line_filtered="MOUTIERS-SALINS-BRIDES-LES-BAINS"
  elif [[ $line = "VITRY LE FRANCOIS GARE" ]]
    then line_filtered="VITRY-LE-FRANCOIS"
  elif [[ $line = "MONTELIMAR GARE SNCF" ]]
    then line_filtered="MONTELIMAR"
  elif [[ $line = "ST MAIXENT DEUX SEVRES" ]]
    then line_filtered="MAIXENT"
  elif [[ $line = "CAUSSADE TARN ET GARONNE" ]]
    then line_filtered="CAUSSADE"
  elif [[ $line = "MASSIAC BLESLE" ]]
    then line_filtered="MASSIAC"
  elif [[ $line = "BESANCON - F COMTE TGV" ]]
    then line_filtered="BESANCON-FRANCHE"
  elif [[ $line = "VALENCE TGV RHONE-ALPES SUD" ]]
    then line_filtered="VALENCE"
  elif [[ $line = "AEROPORT CDG2 TGV ROISSY" ]]
    then line_filtered="AEROPORT-CHARLES-DE-GAULLE-2"
  fi

  coordinates=$( \
    grep -m 1 -i "$line_filtered" sncf.csv \
    | cut --delimiter "," --fields 4,5 \
  )

  if [[ $line = "MONTAUBAN VILLE BOURBON" ]];
    then coordinates="1.341127241507155,44.014195331668475"
  fi

  if [[ $coordinates == "" ]];
    then echo ERROR: $line	$line_filtered;
  else
    echo $line,$coordinates | tee --append gares-geo.csv
  fi
done < gares.txt
