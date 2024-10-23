#!/bin/bash

#$ -l h_data=10G
#$ -l h_rt=12:00:00
#$ -l highp
#$ -o /u/project/zaitlenlab/galenheu/kraken/logfile.out
#$ -e /u/project/zaitlenlab/galenheu/kraken/logfile.err

set -e  #exit on error

. /u/home/g/galenheu/mambaforge/etc/profile.d/conda.sh

#wget https://data.qiime2.org/distro/amplicon/qiime2-amplicon-2024.2-py38-osx-conda.yml
#CONDA_SUBDIR=osx-64 conda env create -n qiime --file qiime2-amplicon-2024.2-py38-osx-conda.yml
#conda activate qiime
#conda config --env --set subdir osx-64

wget https://data.qiime2.org/distro/amplicon/qiime2-amplicon-2024.2-py38-linux-conda.yml
conda env create -n qiime2 --file qiime2-amplicon-2024.2-py38-linux-conda.yml
