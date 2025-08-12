#!/usr/bin/zsh

return_date="2025-08-26"
destination="PARIS (intramuros)"

file_name="$destination-$return_date.txt"

while IFS= read -r line; do
  python main.py -d $line -a a -q -p -t $return_date | grep $destination | tee --append "$file_name"
done < destinaisons.txt
