#!/bin/bash

#$ -cwd
#$ -j yes
#$ -l h_data=10G
#$ -l h_rt=12:00:00
#$ -t 1-96
######$ -l highp

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate kraken

#arguments
bam="/u/project/zaitlenlab/christac/panel/als_v1/mapped_bsbolt/${SGE_TASK_ID}.sorted.bam" #input bam file
unmappedbam="/u/project/zaitlenlab/galenheu/kraken/unmapped2/${SGE_TASK_ID}.unmapped.bam" #output file

#extract unmapped reads where both mates are unmapped
samtools view -b -f 12 $bam > $unmappedbam

#extract unmapped reads
#samtools view -b -f 4 $bam > $unmappedbam
