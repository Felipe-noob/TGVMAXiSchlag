#!/usr/bin/env sh

return_date=$1
destination="PARIS (intramuros)"

destination_sed=$(echo $destination | sed 's/ /_/g')
file_name="output/$destination_sed-$return_date.txt"

while IFS= read -r line; do
  python main.py -d "$line" -a a -q -p -t $return_date | grep "$destination" | tee --append "$file_name"
done < destinaisons.txt
