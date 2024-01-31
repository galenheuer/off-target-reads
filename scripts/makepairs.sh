#!/bin/bash

#$ -j yes
#$ -l h_data=2G  # Adjust the memory requirement as needed
#$ -l h_rt=2:00:00
#$ -t 1-96
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/kraken/pairs2/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/pairs2/logfile.err

set -e  #exit on error

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate kraken

bam_path="/u/project/zaitlenlab/galenheu/kraken/unmapped2/"
fastq_path="/u/project/zaitlenlab/galenheu/kraken/pairs2/"

bedtools bamtofastq -i ${bam_path}/${SGE_TASK_ID}.unmapped.bam -fq ${fastq_path}/${SGE_TASK_ID}.end1.fq -fq2 ${fastq_path}/${SGE_TASK_ID}.end2.fq
echo ${SGE_TASK_ID}.end1.fq and ${SGE_TASK_ID}.end2.fq created
