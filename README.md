# Project overview
This project pulls from a 16S data set generated as a part of one of my thesis projects. Mice were fed one of four different diets **(High fat, low fat, high fat + 4.5% apple pomace, and high fat + 9% apple pomace)**. Fecal pellets from each mouse in the study (44 in total) were collected and submitted for 16S sequenceing. One sample from each group was selected for the purposes of this class.

--- 
## Workflow documentation
I initially created a series of scripts used to explore my data using the QIIME2 native tools. These can be seen in the "scripts/*" directory aside from the nf-ampliseq.sh script. Each one does as follows:
-   manifest.sh --> generates a qiime2 compatible manifest file from a folder containing fastq.gz files
-   import.sh --> converts raw data into a qiime artifact according to the manifest file
-   cut-adapt.sh --> trims the reads using cut-adapt given specified primers
-   denoising.sh --> runs DADA2 on the imported (and trimmed) data
-   phylogeny.sh --> takes the denoised reads, and a reference dataset, and runs fragment insertion to build a phylogenetic tree
-   core-metrics --> (unimplemented) for running alpha and beta diversity metrics using qiime2
  
Though this was working for me, I wanted to plan ahead in creating a more automated process. That's when I came across the nf-core pipeline **ampliseq**.  
  
[Ampliseq GitHub](https://github.com/nf-core/ampliseq)  
[nf-core/ampliseq page](https://nf-co.re/ampliseq/2.9.0)
  
Ampliseq performs a large number of tasks from quality control to differential abundance analysis while only requiring your raw data, primers, and output directory as inputs.  
  
In order to execute this pipeline I wrote two scripts, nf-ampliseq.sh and run.sh modeled after the scripts we wrote for class in week 6. The scripts do the following:
-    nf-ampliseq.sh --> establishes the workflow dir, checks for input arguments, creates the output and work directories as needed, then executes the workflow (NB: this is where parameters such as primers and denoising truncation lengths exist if/when they need to be modified)
-   run.sh --> downloads the pipeline files to $PWD/software for execution by Nextflow, defines input and output directories, creates nextflow.config file to allow for slurm batch submissions, then submits the workflow
  
*Assumed primers are the 16S 515f-806r Illumina paired-end primers*

---
## Re-running the workflow
The necessary file structures required to run the workflow include:
1. Final-project (parent directory and running directory for all scripts) - I treated this as my $PWD (can have any name as long as it is used to run any scripts)
2. ./data (subfolders = raw, meta)
3. ./scripts (containing nf-ampliseq.sh)
4. ./run (containing run.sh)
5. ./results
6. ./software (subfolders = containers, nfc-ampliseq)
  
Fastq.gz files need to be copied into $PWD/data/raw  
*metadataArranged-subset.tsv* should be copied from my repository into $PWD/data/meta (ignore the manifest file, ampliseq does not require it)  
  
If the user does not have nextflow version 2.13 (or higher installed) do so before running the pipeline.
Separate containers can be downloaded into $PWD/software/containers or mine can be used by editing the NXF_SINGULARITY_CACHEDIR env variable so $USER = phoward42.  
  
The workflow should be ready to run.  
  
Submit run.sh as a batch job  
  
**This takes a while as some steps request a lot of core time, nf-ampliseq.sh alone requests 24hr to accomodate long queue times**  
  
The workflow should generate the following files in the $PWD:  
-   work - Directory containing the nextflow working files  
-   <"OUTDIR"> - Finished results in specified location (defined with --outdir)  
-   .nextflow_log - Log file from Nextflow  
-   Other nextflow hidden files, eg. history of pipeline runs and old logs.