#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=12:00:00
#SBATCH --mail-type=END,FAIL
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate qiime2-amplicon-2024.2

# Report
echo "Starting script phylogeny.sh"
date

qiime fragment-insertion sepp \
    --i-representative-sequences results/denoising/repseqsNoFilt.qza \
    --i-reference-database data/ref/sepp-refs-gg-13-8.qza \
    --p-threads 4 \
    --o-tree results/phylogeny/insertion-tree.qza \
    --o-placements results/phylogeny/insertion-placements.qza

qiime fragment-insertion filter-features \
    --i-table results/denoising/tableNoFilt.qza \
    --i-tree results/phylogeny/insertion-tree.qza \
    --o-filtered-table results/phylogeny/filtered-table-deblur.qza \
    --o-removed-table results/phylogeny/removed-table.qza

# Report
echo "Done with script phylogeny.sh"
date