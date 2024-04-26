#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=1:00:00
#SBATCH --mail-type=END,FAIL
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate qiime2-amplicon-2024.2

# Report
echo "Starting script import.sh"
date

qiime tools import \
  --type "SampleData[PairedEndSequencesWithQuality]" \
  --input-format PairedEndFastqManifestPhred33V2 \
  --input-path /fs/ess/PAS2700/users/phoward42/Final-project/data/meta/manifestArranged.tsv \
  --output-path /fs/ess/PAS2700/users/phoward42/Final-project/results/import/demuxed-dss.qza                 # link to the path where I want my demultiplexed data to be exported

# Convert demultiplexed qza to qzv
qiime demux summarize \
  --i-data results/import/demuxed-dss.qza \
  --o-visualization results/visualizations/demuxed-dss.qzv

# Report
echo "Done with script import.sh"
date