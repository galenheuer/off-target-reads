#!/bin/bash

#$ -j yes
#$ -l h_data=20G
#$ -l h_rt=8:00:00
#$ -t 53
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/kraken/runkraken/logfile53.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/runkraken/logfile53.err

set -e  #exit on error

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate kraken

fastq_path="/u/project/zaitlenlab/galenheu/kraken/pairs2/"
out_path="/u/project/zaitlenlab/galenheu/kraken/kroutput3/"
db="/u/project/zaitlenlab/galenheu/kraken/customBisulfiteDB"

kraken2 --threads 10 --db ${db} --output ${out_path}/${SGE_TASK_ID}.output.txt --report ${out_path}/${SGE_TASK_ID}.report.txt --use-names --report-zero-counts --paired ${fastq_path}/${SGE_TASK_ID}.end1.fq ${fastq_path}/${SGE_TASK_ID}.end2.fq
echo ${SGE_TASK_ID} run.
