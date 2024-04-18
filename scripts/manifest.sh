#path to forward
ls -f /fs/ess/PAS2700/users/phoward42/Final-project/data/raw/*_R1_001.fastq.gz | sort -V > r1path
#path to reverse
ls -f /fs/ess/PAS2700/users/phoward42/Final-project/data/raw/*_R2_001.fastq.gz | sort -V > r2path

#checking if we have all pairs of forward and reverse reads
diff -s <(cat r1path | cut -d_ -f1) <(cat r2path | cut -d_ -f1) #if the outcome is "identical", then we good :)

#Cutting sample IDs from the path file (from either is good)
cut -d_ -f1 r1path > IDpath
cut -d/ -f 10 IDpath > SampleID

#adding sample ids to paths
paste SampleID r1path r2path > manifest

#Binning ids and forward reverse columns together with tab-delimited seperation --> then store to .tsv
sed $'1 i\\\nsampleID \t forward-absolute-filepath \t reverse-absolute-filepath' manifest | tee $PWD/data/meta/manifestArranged.tsv #Assumes $PWD is ./Final-project

#Get rid of unneeded variables
rm IDpath r1path r2path SampleID manifest