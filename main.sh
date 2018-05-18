#! /usr/bin/env bash

bamfile=$1
datadir=$2
cutsite=$3

bash /home/garner1/Work/pipelines/refgenomeLP/generate_vocabulary.sh $bamfile $datadir $cutsite # generate vocabulary from dataset
if [ ! -f $datadir/common_vocabulary.p ]; then
    python /home/garner1/Work/pipelines/refgenomeLP/find_common_vocabulary.py # find intersection vocabulary
fi
python /home/garner1/Work/pipelines/refgenomeLP/build_PPMI_onCommonVoc.py $datadir/docs/genome.doc # truncated SVD of dtm matrix restricted to common vocabulary
cd $datadir
cd ..
mkdir -p $datadir/SVD_from_DTM
rename -v 's/\/docs\/genome.doc//' $datadir/docs/genome.doc.p
mv XZ*.p SVD_from_DTM

