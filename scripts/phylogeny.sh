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
    --i-representative-sequences rep-seqs-deblur.qza \
    --i-reference-database sepp-refs-gg-13-8.qza \
    --p-threads 4 \
    --o-tree insertion-tree.qza \
    --o-placements insertion-placements.qza

# Report
echo "Done with script phylogeny.sh"
date