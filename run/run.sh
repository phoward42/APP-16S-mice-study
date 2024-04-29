#!/bin/bash
#SBATCH --account=PAS2700

# 2024-04-28, Peter Howard
# - A runner script to run the nf-core ampliseq analysis pipeline.
# - The working dir is /fs/ess/PAS2700/users/phoward42/Final-project.
# - I am working on the OSC Pitzer cluster.

module load miniconda3/23.3.1-py310
conda activate nextflow

# Create an environment variable for the container dir
export NXF_SINGULARITY_CACHEDIR=/fs/ess/PAS2700/$USER/Final-project/software/containers

# Download the nf-core ampliseq pipeline files (remove comments as needed)
nf-core download ampliseq \
    --revision 2.9.0 \
    --outdir software/nfc-ampliseq \
    --compress none \
    --container-system singularity \
    --container-cache-utilisation amend \
    --download-configuration \
    --force

# Defining the pipeline outputs
outdir=results/nf-ampliseq
workdir=/fs/scratch/PAS2700/$USER/nfc-ampliseq

# Defining the pipeline inputs
metadata=data/meta/metadataArranged-subset.tsv
raw_data=data/raw

# Create the dir that will contain the pipeline outputs 
mkdir -p "$outdir"

# Append config file for batch job submissions
echo "
process.executor='slurm'
process.clusterOptions='--account=PAS2700'
" > nextflow.config

# Submit the script to run the pipeline as a batch job
sbatch scripts/nf-ampliseq.sh "$raw_data" "$metadata" "$outdir" "$workdir"