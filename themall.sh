#! /usr/bin/env bash

parallel "python /home/garner1/Work/pipelines/refgenomeLP/build_PPMI_onCommonVoc.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{114,115,117}/docs/genome.doc
parallel "python /home/garner1/Work/pipelines/refgenomeLP/build_PPMI_onCommonVoc.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{118,119,120}/docs/genome.doc
parallel "python /home/garner1/Work/pipelines/refgenomeLP/build_PPMI_onCommonVoc.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{121,122,82}/docs/genome.doc
parallel "python /home/garner1/Work/pipelines/refgenomeLP/build_PPMI_onCommonVoc.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{83,85,86}/docs/genome.doc
parallel "python /home/garner1/Work/pipelines/refgenomeLP/build_PPMI_onCommonVoc.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{88,89,90,91}/docs/genome.doc

# parallel "python /home/garner1/Work/pipelines/refgenomeLP/vectorization.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{122,82,83}/docs/genome.doc
# parallel "python /home/garner1/Work/pipelines/refgenomeLP/vectorization.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{85,86,88}/docs/genome.doc
# parallel "python /home/garner1/Work/pipelines/refgenomeLP/vectorization.py {}" ::: /home/garner1/Work/dataset/refgenomeLP/XZ{89,90,91,121}/docs/genome.doc


# lib=XZ117
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ118
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ119
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ120
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ121
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ122
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ82
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ83
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ85
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ86
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ88
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ89
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ90
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
# lib=XZ91
# bash main.sh ~/Work/dataset/reduced_sequencing/bamfiles/"$lib"-*.bam ~/Work/dataset/refgenomeLP/"$lib" CATG
