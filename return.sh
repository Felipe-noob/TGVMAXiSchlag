#!/usr/bin/env bash

return_date=$1
destination="PARIS (intramuros)"

destination_sed=$(echo $destination | sed 's/ /_/g')
file_name="output/$destination_sed-$return_date.txt"

while IFS= read -r line; do
  python main.py \
    -d "$line" -a "$destination" \
    -s 1 -q -t $return_date \
      | tee "$file_name";
done < destinaisons.txt

return
tmp_file=$(mktemp)
grep Depart "$file_name" > "$tmp_file"
mv "$tmp_file" "$file_name"

