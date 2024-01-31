#!/bin/bash

#$ -r y
#$ -j y
#S -l highp
#$ -l h_data=8G
#$ -l h_rt=24:00:00
#$ -o /u/project/zaitlenlab/galenheu/kraken/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/logfile.err

set -e  #exit on error

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate base

convert="/u/project/zaitlenlab/galenheu/kraken/convert.py"
path="/u/project/zaitlenlab/galenheu/kraken/kraken_bacteria_with_taxid.csv"
zipped_dir="/u/project/zaitlenlab/galenheu/kraken/zipped"
output_dir="/u/project/zaitlenlab/galenheu/kraken/reformatted"
failed_downloads_file="/u/project/zaitlenlab/galenheu/kraken/failed_downloads.txt"
failed_conversions_file="/u/project/zaitlenlab/galenheu/kraken/failed_conversions.txt"
non_numeric_taxIDs_file="/u/project/zaitlenlab/galenheu/kraken/non_numeric_taxIDs.text"

#ensure the output directories exist
mkdir -p "$zipped_dir"
mkdir -p "$output_dir"

# Check if the failed_downloads_file exists, and create it if it doesn't
if [ ! -e "$failed_downloads_file" ]; then
    touch "$failed_downloads_file"
fi

# Check if the failed_conversions_file exists, and create it if it doesn't
if [ ! -e "$failed_conversions_file" ]; then
    touch "$failed_conversions_file"
fi

# Check in the non_numeric_taxIDs_file exists, and create if it it doesn't
if [ ! -e "$non_numeric_taxIDs_file" ]; then
    touch "$non_numeric_taxIDs_file"
fi

#loop through each line of the CSV
num=1129
tail -n +1130 "$path" | while IFS=',' read -r name taxID url; do

    # Check if taxID is non-numeric
    if ! [[ "$taxID" =~ ^[0-9]+$ ]]; then
        echo "Skipping line $num. Non-numeric taxID found: $taxID"
        echo "$taxID" >> "$non_numeric_taxIDs_file"
        continue
    fi

    # Download and extract the fasta
    if wget -O "$zipped_dir/${taxID}.gz" "$url"; then
        gunzip "$zipped_dir/${taxID}.gz"
        # Convert to Kraken-compatible format
        if python3 "$convert" "$zipped_dir/${taxID}" "$taxID"; then
            rm "$zipped_dir/${taxID}"
            echo "$num : $taxID"
        else
            echo "Conversion failed for $taxID. Adding to $failed_conversions_file."
            echo "$taxID" >> "$failed_conversions_file"
        fi
    else
        echo "Download failed for $taxID. Adding to $failed_downloads_file."
        echo "$taxID" >> "$failed_downloads_file"
    fi
    (( ++num ))
done
