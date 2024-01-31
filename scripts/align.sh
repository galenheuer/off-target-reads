#!/bin/bash

#$ -j yes
#$ -l h_data=8G
#$ -l h_rt=2:00:00
#$ -t 1-96
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/kraken/realigned/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/realigned/logfile.err

set -e  #exit on error

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate bsbolt

bsb_db="/u/project/zaitlenlab/galenheu/t2t/bsbDB/"
fastq="/u/project/zaitlenlab/galenheu/kraken/pairs2/"
output="/u/project/zaitlenlab/galenheu/kraken/realigned/"

python3 -m bsbolt Align -DB ${bsb_db} -F1 ${fastq}/${SGE_TASK_ID}.end1.fq -F2 ${fastq}/${SGE_TASK_ID}.end2.fq -O ${output}
