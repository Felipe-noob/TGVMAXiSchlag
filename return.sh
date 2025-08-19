#!/usr/bin/env bash

set -e

return_date=$1
destination="PARIS (intramuros)"

destination_sed=$(echo $destination | sed 's/ /_/g')
file_name="output/$destination_sed-$return_date.txt"
rm -v -f "$file_name"

while IFS= read -r line; do
  python main.py \
    -d "$line" -a "$destination" \
    -s 1 -q -t $return_date \
      | tee --append "$file_name";
done < destinaisons.txt

# create a more readable file only with the names
tmp_file=$(mktemp)
grep Départ "$file_name" > "$tmp_file"
mv "$tmp_file" "$file_name"

cat "$file_name" \
  | cut -f 3 \
  | uniq -c \
  | sed 's/.* depuis//' \
  > "$file_name.simple"

# create a file with coordinates
