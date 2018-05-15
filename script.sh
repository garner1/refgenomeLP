#! /usr/bin/env bash

bamfile=$1

bam2bed < $bamfile | cut -f-3 |
bedtools getfasta -fi ~/Work/genomes/Homo_sapiens.GRCh37.dna.primary_assembly.fa/GRCh37.fa -bed - > $bamfile.bed
