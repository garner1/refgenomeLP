# coding: utf-8

import sys
import csv
import numpy as np
import os.path
import cPickle as pickle
from os import listdir
from os.path import isfile, join

allfiles = [] # Creates an empty list
ind = 0
for root, dirs, files, in os.walk("/home/garner1/Work/dataset/refgenomeLP/pickle_vocabularies/"):
    for file in files:
        ind = ind+1
        if file.endswith(".p"):
            print (file)
            print (str(ind) + " of " + str(len(files)) )
            openfiles = open(os.path.join(root, file), 'rb')
            loadedfiles = pickle.load(openfiles)
            allfiles.append(loadedfiles)

oldset = set(allfiles[0])
for ind in range(1,len(allfiles)):
    print (len(oldset))
    newset = set(allfiles[ind])
    common_voc = set.intersection(oldset,newset)
    oldset = common_voc

pickle.dump( common_voc, open( "/home/garner1/Work/dataset/refgenomeLP/"+"common_vocabulary"+".p", "wb" ) )
