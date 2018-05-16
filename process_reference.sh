#!/usr/bin/env bash

datadir_ref=$1		 # /home/garner1/Work/dataset/genomicNLP
cutsite=$2			# the restriction enzyme cutsite we are using
ref=$3				# the reference genome

workdir=$PWD
mkdir -p $datadir_ref/$cutsite

##############
# OUTPUT A bed FILE ASSOCIATED TO A CUTSITE NEIGHBOROUGH
##############
cd $datadir_ref/$cutsite

bash /home/garner1/Dropbox/pipelines/aux.scripts/script_split_genome_wrt_enzyme.sh $ref $cutsite # produce the cutsite bed file

awk '{OFS="\t";print $1,$2-100,$3+100}' $cutsite.bed | awk '$2>0' > "$cutsite"_larger.bed    # enlarge the cutsite bedfile to a neighbourough

bedtools merge -i "$cutsite"_larger.bed > "$cutsite"_merged.bed # merge bed files to avoid double counting of word frequencies

bedtools getfasta -fi $ref -bed "$cutsite"_merged.bed -bedOut -s | tr '[:lower:]' '[:upper:]' |
    LC_ALL=C grep -v N > refExtendedDoc.bed # create the bed file associated to the cutsite
##############
# TOKENIZE THE GENOME FRAGMENTS 
# ##############
echo 'Prepare kmer table'                          
g++ -std=c++11 $workdir/module/kmers.cpp -o $workdir/module/kmers # compile kmers
mkdir $datadir_ref/$cutsite/chr
cd $datadir_ref/$cutsite/chr
awk '{print $4 >> $1; close($1)}' ../refExtendedDoc.bed # split by chromosome 
parallel "sed -i 's/$/NNNNNN/' {}" ::: * #introduce the Ns to count the kmers

echo "Count kmers ..."
mkdir -p "$datadir_ref"/$cutsite/6mer
rm -f "$datadir_ref"/$cutsite/6mer/*
cd $datadir_ref/$cutsite/chr
parallel "cat {} | tr -d '\n' | $workdir/module/kmers 6 6 |LC_ALL=C grep -v 'N' | awk 'NF == 2' > ../6mer/{}.tsv" ::: *

echo "Prepare information tables ..."
cd $datadir_ref/$cutsite/6mer                            
parallel "bash $workdir/module/parse_kmer_table.sh {} 6 1.0" ::: {?,??}.tsv                                    
rm *kmer*                                          
rename 's/tsv.table.tsv/table.tsv/' *tsv           

echo "Tokenize the documents"
mkdir -p "$datadir_ref"/$cutsite/docs
# SEGMENT THE GENOME
g++ -std=c++11 $workdir/module/tokenizer_withMean.cpp -o $workdir/module/mean # compile the tokenizer 
cd $datadir_ref/$cutsite/chr
parallel "sed -i 's/NNNNNN//' {}" ::: *
parallel "$workdir/module/mean {} ../6mer/{.}.table.tsv | cut -d' ' -f2- > ../docs/{.}.txt" ::: *

