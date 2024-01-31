#!/bin/bash

#$ -r y
#$ -j y
#S -l highp
#$ -l h_data=18G
#$ -l h_rt=8:00:00
#$ -o /u/project/zaitlenlab/galenheu/kraken/builddb/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/builddb/logfile.err

set -e  #exit on error

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate kraken

#build1: 3228 files (1-14)
#build2: 3233 files (15-25)
#build3: 3194 files (26-30)
#build4: 3947 files (31-9)
#total: 13602 files

#source_dir="/u/project/zaitlenlab/galenheu/kraken/builddb/build4"
db="/u/project/zaitlenlab/galenheu/kraken/customBisulfiteDB"

#for file in "$source_dir"/*; do
#
#        #add to library
#        kraken2-build --add-to-library "$file" --db "$db" --threads 4

#done

#echo END OF BUILD 4

#kraken2-build --download-taxonomy --db "$db"
#echo Downloaded taxonomy
kraken2-build --build --db "$db"
#echo Built custom db
kraken2-build --clean --db "$db"
#echo Cleaned db
