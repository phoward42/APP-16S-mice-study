#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH -N 1
#SBATCH -n 10
#SBATCH --mem=64G
#SBATCH -t 6:00:00
#SBATCH --mail-type=END,FAIL
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate qiime2-amplicon-2024.2

# Report
echo "Starting script denoising.sh"
date

qiime dada2 denoise-paired \
--i-demultiplexed-seqs $PWD/results/cut-adapt/trimmed_remove_primers.qza \
--p-trim-left-f 0 \
--p-trim-left-r 0 \
--p-trunc-len-f 134 \
--p-trunc-len-r 207 \
--o-table $PWD/results/denoising/table.qza \
--o-representative-sequences $PWD/results/denoising/repseqs.qza \
--o-denoising-stats $PWD/results/denoising/denoising-stats.qza \
--p-n-threads 10                                            

qiime feature-table summarize \
--i-table $PWD/results/denoising/table.qza \
--m-sample-metadata-file $PWD/data/meta/metadataArranged-subset.tsv \
--o-visualization $PWD/results/visualizations/table.qzv

qiime feature-table tabulate-seqs \
--i-data $PWD/results/denoising/repseqs.qza \
--o-visualization $PWD/results/visualizations/repseqs.qzv

qiime metadata tabulate \
--m-input-file $PWD/results/denoising/denoising-stats.qza \
--o-visualization $PWD/results/visualizations/denoising-stats.qzv


# Report
echo "Done with script denoising.sh"
date