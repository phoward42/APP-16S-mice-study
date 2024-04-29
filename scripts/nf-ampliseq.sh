#!/bin/bash
#SBATCH --account=PAS2700
#SBATCH --time=24:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=slurm-nfc_ampliseq-%j.out
set -euo pipefail

# Settings and constants
WORKFLOW_DIR=software/nfc-ampliseq/2_9_0

# Load the Nextflow Conda environment
module load miniconda3/23.3.1-py310
conda activate nextflow
export NXF_SINGULARITY_CACHEDIR=/fs/ess/PAS2700/$USER/Final-project/software/containers

# Process command-line arguments
if [[ ! "$#" -eq 4 ]]; then
    echo "Error: wrong number of arguments"
    echo "You provided $# arguments, while 4 are required."
    echo "Usage: nfc-ampliseq.sh <raw_data> <metadata> <outdir> <workdir>"
    exit 1
fi
raw_data=$1
metadata=$2
outdir=$3
workdir=$4

# Report
echo "Starting script nfc-ampliseq.sh"
date
echo "Raw Data:             $raw_data"
echo "Metadata:             $metadata"
echo "Output dir:           $outdir"
echo "Nextflow work dir:    $workdir"
echo

# Create the output dirs
mkdir -p "$outdir" "$workdir"

# Run the workflow
nextflow run "$WORKFLOW_DIR" \
    -profile singularity \
    -ansi-log false \
    -resume \
    -work-dir "$workdir" \
    --input_folder "$raw_data" \
    --FW_primer GTGYCAGCMGCCGCGGTAA \
    --RV_primer GGACTACNVGGGTWTCTAAT \
    --metadata "$metadata" \
    --outdir "$outdir" \
    --save_intermediates TRUE \
    --trunclenf 134 \
    --trunclenr 236

# Report
echo "Done with script nfc-ampliseq.sh"
date