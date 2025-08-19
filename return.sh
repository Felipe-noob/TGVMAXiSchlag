#!/usr/bin/env bash

set -e

return_date=$1
destination=$2

destination_sed=$(echo $destination | sed 's/ /_/g')
file_name="output/$destination_sed-$return_date.txt"
rm -v -f "$file_name"

max_jobs=24
jobs=0

while IFS= read -r line; do
  if [[ $jobs -eq $max_jobs ]]; then
    wait
  fi

  jobs=$(( jobs + 1 ))
  python main.py \
    -d "$line" -a "$destination" \
    -s 1 -q -t $return_date \
      | tee --append "$file_name" && jobs=$(( jobs - 1 )) &

done < destinaisons.txt

wait

echo
echo Finished fetching
echo

# create a more readable file only with the names
tmp_file=$(mktemp)
grep Départ "$file_name" > "$tmp_file"
mv "$tmp_file" "$file_name"

cat "$file_name" \
  | cut -f 3 \
  | uniq -c \
  | sed 's/.* depuis //' \
  > "$file_name.simple"

# create a file with coordinates
./prepareplot.sh "$file_name.simple"
python plot.py "$file_name.simple.csv"
