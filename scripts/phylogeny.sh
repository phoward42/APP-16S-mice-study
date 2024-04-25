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

qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences results/import/repseqsNoFilt.qza \
  --o-alignment results/phylogeny/aligned-rep-seqs.qza \
  --o-masked-alignment results/phylogeny/masked-aligned-rep-seqs.qza \
  --o-tree results/phylogeny/unrooted-tree.qza \
  --o-rooted-tree results/phylogeny/rooted-tree.qza

# Report
echo "Done with script phylogeny.sh"
date