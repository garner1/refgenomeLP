# coding: utf-8

import sys
import csv
import numpy as np
import os.path
import cPickle as pickle
import matplotlib.pyplot as plt
import gensim, logging
from os import listdir
from os.path import isfile, join

import sklearn
from sklearn import datasets
from sklearn.feature_extraction.text import CountVectorizer

filename = sys.argv[1]           # /home/garner1/Work/dataset/refgenomeLP/docs/1.doc

openfile = open("/home/garner1/Work/dataset/refgenomeLP/common_vocabulary.p", 'rb')
common_voc = pickle.load(openfile)
vectorizer = CountVectorizer(vocabulary=common_voc) # set the vocabulary
corpus = open(filename)
dtm = vectorizer.fit_transform(corpus) # get document-term matrix
vocab = vectorizer.get_feature_names() # a list  

# Get the occurrence of each unique word in the list of documents, and observe how the majority of the words is rare and there are few words shared by the majority of the documents. 
dtm_word = dtm.sum(axis=0)

# A term-term co-occurence matrix is obtained as the product of dtm.T * dtm. This also is a sparse matrix and, after truncated SVD, we can identify main eigenwords:
"""
Compute the PPMI values for the raw co-occurrence matrix.
PPMI values will be written to mat and it will get overwritten.
"""    
from scipy.sparse import coo_matrix
from numpy import *

mat = dtm.transpose().dot(dtm)      # build word-word matrix
del dtm                             # remove dtm from memory
rows,cols = mat.nonzero() # get the list of non-zero rows and cols index
data = np.divide(mat.data*1.0,dtm_word[0,rows]*1.0) # pointwise division of data matrix by row-sum
data = np.divide(data,dtm_word[0,cols]*1.0) # pointwise division by col-sum
data = data*dtm_word.sum() #rescaling by number of tokens
data = np.squeeze(np.asarray(data))

coomat = coo_matrix((data, (rows, cols)), shape=mat.shape) # sparse mat in coordinate format
coomat.data = ma.log(coomat.data)
coomat.data = ma.masked_less(coomat.data, 0)
del mat                         # remove mat from memory
from scipy.sparse.linalg import svds
[u,s,vt] = svds(coomat, k=6, which='LM', return_singular_vectors=True)

output = [u,s,vt]

pickle.dump( output, open( filename+".p", "wb" ) )

