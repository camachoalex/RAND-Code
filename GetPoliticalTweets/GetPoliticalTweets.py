'''
___________________________________________________________________________________________________
Purpose:
___________________________________________________________________________________________________
Using Python, data mine through the JSON files and keep record of all politically inclined tweets.

At the end, output the recorded tweets to the files called PoliticalTweets.txt
___________________________________________________________________________________________________
'''
########################################################################################################
##    IMPORT libraries
########################################################################################################
import glob
import json
import os
import sys
import re
from itertools import groupby
import collections
########################################################################################################
##    OPEN JSON file directory
########################################################################################################
path = r'C:/Users/jroman09/Downloads/DELETE'
########################################################################################################
##    Declare & initialize variables
########################################################################################################
data = {};pdict= {};DocNum=0
########################################################################################################
##    OPEN Political Dictionary file directory
########################################################################################################
with open(r'C:/Users/jroman09/Downloads/DELETE/PoliticalDictionary.txt','r') as txtfile:
    contents = txtfile.readlines()
    for row in contents:
        pdict[row.split(',')[0]]=row.split(',')[1].replace('\n','')
########################################################################################################
##    Import JSON files into the data array
########################################################################################################
for dir_entry in os.listdir(path):
    dir_entry_path = os.path.join(path, dir_entry)
    if os.path.isfile(dir_entry_path):
        with open(dir_entry_path, 'rb') as my_file:
            data[dir_entry] = my_file.read()
########################################################################################################
##    Begin the JUICY data mining
########################################################################################################
for i in iter(data)):           #<------COUNTER to keep track of current file
########################################################################################################
##    Write Political Tweets to appropriate text files
########################################################################################################    
    with open("PoliticalTweets-"+DocNum+".txt","w",encoding='utf8') as f:
        DocNum+=1
        jsondata=json.loads(data[i].decode())
        print("Searching in filename: {0}\n".format(i+' ...'))
        for key in pdict:
            pattern = pdict[key]
            without_case=re.compile(pattern,re.IGNORECASE)
            for j in range(len(jsondata['interactions'])):
                text=jsondata['interactions'][j]['twitter']['text']
                if ([]!=without_case.findall(text)) & ('location' in jsondata['interactions'][j]['twitter']['user']):
                    f.write('\t'+text+'\n\n')
                    TweetCounter+=1              
f.close()
