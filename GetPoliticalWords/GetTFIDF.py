'''
___________________________________________________________________________________________________
Purpose:
___________________________________________________________________________________________________
To determine the TF-IDF metric of the most frequent words found among the provided Rand Corp. data.
The user must run and view the output to record the most frequent political words and append to the
political dictionary.
The script displays the top 5 (i.e., frequent) words in each file.

NOTE: User must install TextBlob and download the necessary NLTK corpora by running
      the following commands on the console:

$ pip install -U textblob
$ python -m textblob.download_corpora
___________________________________________________________________________________________________
'''
########################################################################################################
##    IMPORT libraries
########################################################################################################
import glob
import json
import os
import sys
import math
import re
from itertools import groupby
import collections
from textblob import TextBlob as tb
########################################################################################################
##    Define Text Mining Functions
######################################################################################################## 
def tf(word, blob):
    return blob.words.count(word) / len(blob.words)
 
def n_containing(word, bloblist):
    return sum(1 for blob in bloblist if word in blob)
 
def idf(word, bloblist):
    return math.log(len(bloblist) / (1 + n_containing(word, bloblist)))
 
def tfidf(word, blob, bloblist):
    return tf(word, blob) * idf(word, bloblist)
########################################################################################################
##    OPEN JSON file directory
########################################################################################################
path = r'C:/Users/jroman09/Downloads/DELETE'#<-----CHANGE DIRECTORY to Political Tweets file directory
########################################################################################################
##    Initialize dictionary values and variables
########################################################################################################
data = {};bloblist=[]  

for dir_entry in os.listdir(path):
    dir_entry_path = os.path.join(path, dir_entry)
    if os.path.isfile(dir_entry_path):
        with open(dir_entry_path, 'rb') as my_file:
            data[dir_entry] = my_file.read()
########################################################################################################
##    Begin the JUICY data mining
########################################################################################################
for i in range(len(data)):           #<------COUNTER to keep track of current file
    if 'PoliticalTweets-'+str(i+1)+'.txt' in data:
        bloblist.append(tb(data['PoliTweets-'+str(i+1)+'.txt'].decode()))        
for i, blob in enumerate(bloblist):
    print("Top words in document: {}".format('PoliticalTweets-'+str(i+1)+'.txt'))    
    scores = {word: tfidf(word, blob, bloblist) for word in blob.words}
    sorted_words = sorted(scores.items(), key=lambda x: x[1], reverse=True)
    for word, score in sorted_words[:3]:
        print("\tWord: {}, TF-IDF: {}".format(word, round(score, 5)))
