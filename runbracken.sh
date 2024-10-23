#!/bin/bash

#$ -j yes
#$ -l h_data=20G
#$ -l h_rt=1:00:00
#$ -t 1-96
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/als_cfdna_samples/uq/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/als_cfdna_samples/uq/logfile.err

set -e  #exit on error

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh
conda activate kraken

cohort="uq"

report="/u/project/zaitlenlab/galenheu/als_cfdna_samples/${cohort}/kroutput"
runbracken="/u/project/zaitlenlab/galenheu/kraken/bracken/bracken"
db="/u/project/zaitlenlab/galenheu/kraken/bisulfiteDB"
output="/u/project/zaitlenlab/galenheu/als_cfdna_samples/${cohort}/g_broutput_threshold_1"
threshold=1

#genus level, 151 read length
${runbracken} -d ${db} -i ${report}/${SGE_TASK_ID}.report.txt -o ${output}/${SGE_TASK_ID}.bracken -l G -t ${threshold} -r 151
