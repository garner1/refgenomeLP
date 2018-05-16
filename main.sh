#! /usr/bin/env bash

bamfile=$1
datadir=$2
cutsite=$3

mkdir -p $datadir
# input: bamfile from restseq
# output: fasta file with expanded reference fragment
cd $datadir
bam2bed < $bamfile | cut -f-3 | awk '{OFS="\t"}{print $1,$2-50,$3+50}' | awk '$2>0' | sed 's/^chr//' | # enlarge the location of the mapped read by 50bp per side
    bedtools getfasta -fi ~/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa -bed - | # generate the fasta file 
    paste - - | tr -d '>' | tr ':' '\t' | awk '{print $3>$1}'	# only keep read content splitted by chromosome
mkdir -p $datadir/chr
mv `seq 1 22` chr
# Tokenize the genome documents 
echo "Tokenize the documents"
g++ -std=c++11 ~/Work/pipelines/genomicNLP/module/tokenizer_withMean.cpp -o ~/Work/pipelines/genomicNLP/module/mean # compile the tokenizer
mkdir -p $datadir/docs
cd $datadir/chr
parallel "~/Work/pipelines/genomicNLP/module/mean {} ~/Work/dataset/genomicNLP/CATG/6mer/{.}.table.tsv | cut -d' ' -f2- > ../docs/{.}.doc" ::: *

parallel --memfree 30G "python /home/garner1/Work/pipelines/refgenomeLP/vectorization.py {}" ::: $datadir/docs/*.doc
