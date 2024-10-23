#!/bin/bash

#$ -cwd
#$ -j yes
#$ -l h_data=50G
#$ -l h_rt=20:00:00
#$ -t 1-96
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/als_cfdna_samples/ucsf/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/als_cfdna_samples/ucsf/logfile.err

# Galen Heuer, 2024
# Complete mapping pipeline for cfDNA bisulfite converted reads.
# Dependencies: bsbolt, samtools, bedtools

set -e  #exit on error

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh
conda activate bsbolt

cohort="ucsf"

#input bam directory (trimmed, but not deduplicated because we need unmapped reads)
bam="/u/project/zaitlenlab/christac/panel/als_v1/mapped_bsbolt/redone/${SGE_TASK_ID}_trimmed.bam" #ucsf
#bam="/u/project/zaitlenlab/christac/panel/redone_fleur/mapped_bsbolt/${SGE_TASK_ID}.trimmed.sorted.bam"  #uq
#bam="/u/project/zaitlenlab/christac/panel/test_version/demultiplexed/NZ_2pools_S-21-0737-0738_GBP299/mapped_bsbolt/${SGE_TASK_ID}.umi_dedup.bam" #ctrl

#bsbolt database
bsb_db="/u/project/zaitlenlab/christac/methylation_mapping/t2t/"

#intermediate file directory
output="/u/project/zaitlenlab/galenheu/als_cfdna_samples/${cohort}"

#1a. extract paired unmapped reads (both mates are unmapped)
#echo "extracting unmapped reads for sample ${SGE_TASK_ID}"
samtools view -b -f 12 ${bam} > ${output}/bam1/${SGE_TASK_ID}.unmapped.bam

#1b. convert unmapped bams to paired fastqs for realignment
#echo "converting sample ${SGE_TASK_ID}"
bedtools bamtofastq -i ${output}/bam1/${SGE_TASK_ID}.unmapped.bam -fq ${output}/fq1/${SGE_TASK_ID}.end1.fq -fq2 ${output}/fq1/${SGE_TASK_ID}.end2.fq

#2. remap to T2T genome with intention of eliminating remaining human reads (takes 4-8 hours per sample)
#echo "aligning sample ${SGE_TASK_ID}"
python3 -m bsbolt Align -DB ${bsb_db} -F1 ${output}/fq1/${SGE_TASK_ID}.end1.fq -F2 ${output}/fq1/${SGE_TASK_ID}.end2.fq -O ${output}/remapped/${SGE_TASK_ID}

#3a. re-extract paired unmapped reads
#echo "re-extracting unmapped reads for sample ${SGE_TASK_ID}"
samtools view -b -f 12 ${output}/remapped/${SGE_TASK_ID}.bam > ${output}/bam2/${SGE_TASK_ID}.re.unmapped.bam

#3b. convert to paired fastqs
#echo "converting sample ${SGE_TASK_ID}"
bedtools bamtofastq -i ${output}/bam2/${SGE_TASK_ID}.re.unmapped.bam -fq ${output}/fq2/${SGE_TASK_ID}.end1.fq -fq2 ${output}/fq2/${SGE_TASK_ID}.end2.fq


