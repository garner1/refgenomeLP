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
echo "Tokenize the documents"
g++ -std=c++11 ~/Work/pipelines/genomicNLP/module/tokenizer_withMean.cpp -o ~/Work/pipelines/genomicNLP/module/mean # compile the tokenizer
mkdir -p $datadir/docs
cd $datadir/chr
# parallel "~/Work/pipelines/genomicNLP/module/mean {} ~/Work/dataset/genomicNLP/CATG/6mer/{.}.table.tsv | cut -d' ' -f2- > ../docs/{.}.doc" ::: *
parallel "~/Work/pipelines/genomicNLP/module/mean {} ~/Work/dataset/genomicNLP/\$cutsite/6mer/{.}.table.tsv | cut -d' ' -f2- > ../docs/{.}.doc" ::: *
cat $datadir/docs/{?,??}.doc > $datadir/docs/genome.doc # this is the document X terms input

python /home/garner1/Work/pipelines/refgenomeLP/build_vocabulary.py $datadir/docs/genome.doc # get vocabulary from dtm
cd $datadir
cd ..
rename -v 's/\/docs\/genome.doc//' $datadir/docs/genome.doc.vocabulary.p
mkdir -p pickle_vocabularies
mv *.vocabulary.p pickle_vocabularies

