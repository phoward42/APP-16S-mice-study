#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=6:00:00
#SBATCH --mail-type=END,FAIL
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate qiime2-amplicon-2024.2

# Report
echo "Starting script cut-adapt.sh"
date

qiime cutadapt trim-paired \
--i-demultiplexed-sequences $PWD/results/import/demuxed-dss.qza \
--p-cores 6 \
--p-front-f GTGYCAGCMGCCGCGGTA  \
--p-adapter-f AATGATACGGCGACCACCGAGATCTACACGCT  \
--p-front-r GGACTACNVGGGTWTCTAAT \
--p-adapter-r CAAGCAGAAGACGGCATACGAGAT \
--p-match-read-wildcards \
--p-match-adapter-wildcards \
--p-discard-untrimmed \
--o-trimmed-sequences $PWD/results/cut-adapt/trimmed_remove_primers.qza 

qiime demux summarize \
  --i-data $PWD/results/cut-adapt/trimmed_remove_primers.qza \
  --o-visualization $PWD/results/visualizations/trimmed-seqs.qzv

# Report
echo "Done with script cut-adapt.sh"
date

