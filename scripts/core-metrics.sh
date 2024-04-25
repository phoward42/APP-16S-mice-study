#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=12:00:00
#SBATCH --mail-type=END,FAIL
set -euo pipefail

module load miniconda3/23.3.1-py310
conda activate qiime2-amplicon-2024.2

# Report
echo "Starting script core-metrics.sh"
date

