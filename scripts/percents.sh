#!/bin/bash

# SGE directives
#$ -cwd
#$ -j yes
#$ -l h_data=2G  # Adjust the memory requirement as needed
#$ -l h_rt=2:00:00
#$ -t 1-96
#$ -o /u/project/zaitlenlab/galenheu/kraken/unmapped2/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/unmapped2/logfile.err
######$ -l highp

set -e #exit on error

. /u/project/zaitlenlab/galenheu/conda/etc/profile.d/conda.sh
conda activate kraken

# Define paths to your BAM files
bam1="/u/project/zaitlenlab/galenheu/kraken/unmapped/"
bam2="/u/project/zaitlenlab/galenheu/kraken/unmapped2/"
output="/u/project/zaitlenlab/galenheu/kraken/unmapped2/pairednotpaired.csv"

# Set the current task ID
i=$SGE_TASK_ID

# Set file paths for the current task
unpaired="${bam1}/${i}.unmapped.bam"
paired="${bam2}/${i}.unmapped.bam"

# Get the total number of reads in the first bam
bam1_reads=$(samtools view -c $unpaired)

# Get the total number of reads in the first bam
bam2_reads=$(samtools view -c $paired)

# Calculate the percentage of unmapped reads that are paired
num_unpaired=$(echo "$bam1_reads - $bam2_reads" | bc)

# Output the results to the spreadsheet
echo "$i, $bam1_reads, $bam2_reads, $num_unpaired" >> $output

echo "Task $i completed."

