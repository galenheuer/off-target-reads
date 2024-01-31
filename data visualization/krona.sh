#!/bin/bash
#$ -j yes
#$ -l h_data=10G
#$ -l h_rt=2:00:00
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/kraken/explore/kronalogfile.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/explore/kronalogfile.err

set -e  #exit on error

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate krona

output="/u/project/zaitlenlab/galenheu/kraken/explore/kronaoutput/"
reports="/u/project/zaitlenlab/galenheu/kraken/explore/kreports/"

ktImportTaxonomy -n Bacteria -t 5 -m 3 -o ${output}/multi-krona.html ${reports}/*
