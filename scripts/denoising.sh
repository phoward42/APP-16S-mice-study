#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH -N 1
#SBATCH -n 10
#SBATCH --mem=64G
#SBATCH -t 24:00:00
#SBATCH --mail-type=END,FAIL
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate qiime2-amplicon-2024.2

# Report
echo "Starting script denoising.sh"
date

qiime dada2 denoise-paired \
--i-demultiplexed-seqs $PWD/results/import/demuxed-dss.qza \
--p-trim-left-f 5 \
--p-trim-left-r 5 \
--p-trunc-len-f 300 \
--p-trunc-len-r 226 \
--o-table $PWD/results/denoising/tableNoFilt.qza \
--o-representative-sequences $PWD/results/denoising/repseqsNoFilt.qza \
--o-denoising-stats $PWD/results/denoising/denoising-statsNoFilt.qza \
--p-n-threads 10                                            

qiime feature-table summarize \
--i-table $PWD/results/denoising/tableNoFilt.qza \
--m-sample-metadata-file $PWD/data/meta/metadataArranged-subset.tsv \
--o-visualization $PWD/results/visualizations/tableNoFilt.qzv

qiime feature-table tabulate-seqs \
--i-data $PWD/results/denoising/repseqsNoFilt.qza \
--o-visualization $PWD/results/visualizations/repseqsNoFilt.qzv

qiime metadata tabulate \
--m-input-file $PWD/results/denoising/denoising-statsNoFilt.qza \
--o-visualization $PWD/results/visualizations/denoising-statsNoFilt.qzv


# Report
echo "Done with script denoising.sh"
date