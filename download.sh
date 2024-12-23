#! /bin/sh
#
# Download any missing input to input/YYYY/dayN.txt
# Assumes w3m is already logged into adventofcode.com

set -e

cd "$(dirname "$(realpath "$0")")"

export TZ=US/Eastern

this_year=$(date '+%Y')
today=$(date '+%Y%m%d')

for year in $(seq 2015 "$this_year"); do
    for day in $(seq 25); do
        if [ "$(printf "%4d%02d%02d" "$year" 12 "$day")" -le "$today" ]; then
            fn="input/$year/day$day.txt"
            if [ ! -e "$fn" ]; then
                mkdir -p "input/$year"
                url="https://adventofcode.com/$year/day/$day/input"
                echo "Downloading $url -> $fn"
                w3m "$url" > "$fn"
            fi
        fi
    done
done
