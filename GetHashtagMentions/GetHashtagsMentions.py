'''
___________________________________________________________________________________________________
Purpose:
___________________________________________________________________________________________________
Using Python, data mine through the JSON files and keep record of all the unique hashtags and
user mentions reported.

At the end, output the recorded hashtags and user mentions with appropriate counters to files
HASHTAGS.txt and MENTIONS.txt

*BUG: Attempts to index the hashtag and user mentions of users with self-reported gender
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
def main():
########################################################################################################
##    OPEN JSON file directory
########################################################################################################
    path = r'C:/Users/jroman09/Downloads/DELETE'#<----MODIFY path to correspond to your JSON file directory
########################################################################################################
##    Initialize dictionary values and variables
########################################################################################################
    data = {};HashtagList=[];MentionsList=[];
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
    for i in iter(data):#<------COUNTER to keep track of current file
        jsondata=json.loads(data[i].decode())
        print("Searching in filename: {0}\n".format(i+' ...'))
            
            for j in range(len(jsondata['interactions'])):#<------COUNTER to keep track of # of tweets
                if (((jsondata['interactions'][j]['twitter']['text'].split()[0]) != 'RT') &\
                    ('name' in jsondata['interactions'][j]['twitter']['user']) \
                & (jsondata['interactions'][j]['twitter']['user']['lang'] == 'en')):                
                    text=jsondata['interactions'][j]['twitter']['text']
                    pattern1=r'(?<=#)\w+'
                    pattern2=r'(?<=@)\w+'
                    without_case1=re.compile(pattern1,re.IGNORECASE)
                    without_case2=re.compile(pattern2,re.IGNORECASE)
                    
                    for Hashtags in range(len(without_case1.findall(text))):
                        HashtagList.append(without_case1.findall(text)[Hashtags])
                        
                    for Mentions in range(len(without_case2.findall(text))):
                        MentionsList.append(without_case2.findall(text)[Mentions])
########################################################################################################
##  Compute the frequency of each hashtag: len of HashtagFreq => # of unique hashtags
########################################################################################################                    
    HashtagFreqDict=collections.Counter(HashtagList)
    HashtagKeys=list(HashtagFreqDict)
########################################################################################################
##  WRITE/OUTPUT RESULTS to file HASHTAGS.txt
########################################################################################################
    with open("HASHTAGS.txt", "w", encoding='utf8') as f:
        print("Writing to file: HASHTAGS.txt ...")
        for hashtag in sorted(HashtagKeys):
            f.write("{0:35}\t {1:5}\n".format(hashtag, HashtagFreqDict[hashtag]))
        print("Total number of unique hashtags: {0}".format(len(HashtagFreqDict)))
        f.write("\nTotal number of unique hashtags: {0}\n".format(len(HashtagFreqDict)))
        f.close()
########################################################################################################
##  Compute the frequency of each user mention: len of MentionsFreqDict => # of unique user mentions
########################################################################################################
    MentionsFreqDict=collections.Counter(MentionsList)
    MentionsKeys=list(MentionsFreqDict)
########################################################################################################
##  WRITE/OUTPUT RESULTS to file MENTIONS.txt
########################################################################################################    
    with open("MENTIONS.txt", "w", encoding='utf8') as f:
        print("Writing to file: MENTIONS.txt ...")
        for mention in sorted(MentionsFreqDict):
            f.write("{0:35}\t {1:5}\n".format(mention, MentionsFreqDict[mention]))
        print("Total number of unique mentions: {0}".format(len(MentionsFreqDict)))
        f.write("\nTotal number of unique mentions: {0}".format(len(MentionsFreqDict)))
        f.close()           
    input('\nPress ENTER to exit...')
if __name__ == "__main__":
    main()
