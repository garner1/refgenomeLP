# coding: utf-8

# Given a genomic region (union of continous DNA portions) segmented into short DNA words, we build a statistics taking into account the frequency of occurrence of each word and the frequency of co-occurrence of pairs of words in the same window (this can be the fragment or a larger bin in the genome). We can keep the information about the linear location of the fragments or not (the best strategy can be chosen afterwards depending on the result of clustering, for example). 

import sys
import csv
import numpy as np
import os.path
import cPickle as pickle
import matplotlib.pyplot as plt
import gensim, logging
from os import listdir
from os.path import isfile, join

logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
###############################################################                                                                                                                                             
import sklearn
from sklearn import datasets
from sklearn.feature_extraction.text import CountVectorizer

filename = sys.argv[1]           # /home/garner1/Work/dataset/refgenomeLP/docs/1.doc

# Given a bam file, we select the 50bp left/right extension of the reference locations (reference genome is GRCh37). We tokenize these fragments and build a document-term matrix from the segmented chr 1 to 22 (no X, Y and MT). This matrix is extremely sparse given tha large size of the vocabulary and the small number of terms per document.

vectorizer = CountVectorizer(min_df=1) # set the min numb of times a word can occur
corpus = open(filename)
dtm = vectorizer.fit_transform(corpus) # get document-term matrix
vocab = vectorizer.get_feature_names() # a list  

pickle.dump( vocab, open( filename+".vocabulary"+".p", "wb" ) )

