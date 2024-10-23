#!/bin/bash

#$ -j yes
#$ -l h_data=20G
#$ -l h_rt=8:00:00
#$ -t 1-96
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/als_cfdna_samples/uq/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/als_cfdna_samples/uq/logfile.err

set -e  #exit on error

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh
conda activate kraken

cohort="uq"

fastq_path="/u/project/zaitlenlab/galenheu/als_cfdna_samples/${cohort}/fq2"
out_path="/u/project/zaitlenlab/galenheu/als_cfdna_samples/${cohort}/kroutput"
db="/u/project/zaitlenlab/galenheu/kraken/bisulfiteDB"

kraken2 --threads 10 --db ${db} --output ${out_path}/${SGE_TASK_ID}.output.txt --report ${out_path}/${SGE_TASK_ID}.report.txt --use-names --report-zero-counts --paired ${fastq_path}/${SGE_TASK_ID}.end1.fq ${fastq_path}/${SGE_TASK_ID}.end2.fq
echo "${SGE_TASK_ID} run."
