# Project proposal and overview for PRACS24
This project pulls from a 16S data set generated as a part of one of my thesis projects. Mice were fed one of four different diets **(High fat, low fat, high fat + 4.5% apple pomace, and high fat + 9% apple pomace)**. Fecal pellets from each mouse in the study (44 in total) were collected and submitted for 16S sequenceing. For this project I will work with the raw fastqc.gz files we recieved from the sequencer and attempt to follow the Qiime2 pipeline. Outputs I hope to generate include: trimmed read counts, relative abundance (feature) tables, alpha and beta diversity metrics, and taxonomic identifications.  

---
## Technical aspects
Becuase I will be using the Qiime2 pipeline each tool can be pretty easily called so my plan is to write a unique script for each tool in the series. Depending on how many files I choose to analyze for this class (I have a total of 88 fastqc.gz files), I will very likely also use some runner scripts to run batch jobs for me over all the relavent files using the desired tool. My scripts will go in the scripts folder and my runners will go in the runner folder.  
  
There is a lot I'm sure I will learn about qiime as I play around with this data, but I would like to try and use as many of the following tool/qiime commands as possible:  
1. demux
2. DADA2/deblur
3. feature-table
4. phylogeny
5. diversity
6. feature-classifier
7. taxa
8. composition  
  
Whether during this class or after, I will take most of the outputs from these programs and pull them into RStudio for better control over my data visualizations.

---
## Uncertainties
I don't have any experience or knowledge on how to prepare or find a reference database for the analysis I want. When we recieved our raw data it came with most of this analysis already done. For reasons I don't need to get into I want to both practice with this data and also run the same analysis again. I'm just lacking the reference set that was initially used. Also unsure on if this is a standardize process or unique to every project/dataset.  
  
Given the lack of info I have about how the data was processed before I don't know yet how far I will get in the workflow. Even if I dont get through it all in this class I'll be happy just to through the first major steps of importing, de-noising, and creating a reference dataset. 

---
## Motivations
This project is a part of my thesis more, as I mentioned before, and makes up a part of a larger, collaborative project studying the effect of dietary changes on the health of mice. I also have other projects I think could benefit from building a working knowledge of large data type analyses. Plus, I also just like computers and find very analytical work to be pretty fun so I love to expand and improve my skills in that regard.
