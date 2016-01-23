'''
___________________________________________________________________________________________________
Purpose:
___________________________________________________________________________________________________
To determine the number of tweets from all of the entire RAND Corp. dataset.
     To determine the number of tweets per file.
     To determine the number of unique users who tweeted.

NOTE: User must change the directory to the appropriate JSON file directory before running.     
___________________________________________________________________________________________________
'''
######################################################################
##                           IMPORT LIBRARIES
######################################################################
import json
import os
import sys
######################################################################
##                     OPEN DIRECTORY TO JSON FILES
######################################################################
path = r'C:/Users/jroman09/Downloads/DELETE'#<-----CHANGE DIRECTORY to json files directory
data = {}; UICounter = 0;UUIC = 0;
for dir_entry in os.listdir(path):
    dir_entry_path = os.path.join(path, dir_entry)
    if os.path.isfile(dir_entry_path):
        with open(dir_entry_path, 'rb') as my_file:
            data[dir_entry] = my_file.read()
        my_file.close()
######################################################################
##                      READ EACH JSON FILE
######################################################################        
for i in iter(data): #<--range of files          
    UI=list()#<--UserId list()
    jsondata=json.loads(data[i].decode())
    print("Searching in file: {0}\n".format(i+' ...'))    
    for j in range(len(jsondata['interactions'])):
######################################################################
##                      RECORD # of TWEETS
###################################################################### 
        UI.append(jsondata['interactions'][j]['interaction']['author']['id'])
        UICounter+=1;
######################################################################
##               DETERMINE NUMBER OF UNIQUE USERS
######################################################################        
    TotalUniqueUsers = {x for x in UI};UUIC+=len(TotalUniqueUsers)
    print("\t# of TWEETERS: {0}\n".format(len(TotalUniqueUsers)))
######################################################################
##                  DETERMINE NUMBER OF TWEETS
######################################################################    
    print("\t# of TWEETS: {0}\n".format(len(UI)))
print("Total Number of TWEETS: {0}".format(UICounter))#<-- 181468+300441+548906+663635 = 1694450
print("Total Number of unique TWEETERS: {0}".format(UUIC))#<-- + + + = 
