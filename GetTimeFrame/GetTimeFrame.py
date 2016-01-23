'''
___________________________________________________________________________________________________
Purpose:
___________________________________________________________________________________________________
Using Python, data mine through the JSON files and keep record of all the times reported.
___________________________________________________________________________________________________
'''
########################################################################################################
##    IMPORT libraries
########################################################################################################
import glob
import json
import os
import sys
##
########################################################################################################
##    OPEN JSON file directory
########################################################################################################
path = r'C:/Users/jroman09/Downloads/DELETE'  # <-----CHANGE DIRECTORY to json files
########################################################################################################
##    Initialize dictionary values and variables
########################################################################################################
data = {};TotalTweets=0;TF=list()
########################################################################################################
##    Begin the JUICY data mining
########################################################################################################
for dir_entry in os.listdir(path):
    dir_entry_path = os.path.join(path, dir_entry)
    if os.path.isfile(dir_entry_path):
        with open(dir_entry_path, 'rb') as my_file:
            data[dir_entry] = my_file.read()
        my_file.close()
with open('TimeFrame.txt', "a+") as f:
    for i in iter(data):
        jsondata=json.loads(data[i].decode())
        print("Searching in file: {0}\n".format(i+' ...'))
        for j in range(len(jsondata['interactions'])):
            if ((jsondata['interactions'][j]['twitter']['text'].split()[0]) != 'RT')\
                &((jsondata['interactions'][j]['twitter']['text'].split()[0]) != 'via'):
                f.write(jsondata['interactions'][j]['twitter']['created_at'][17:-1]+'\n')
    f.write(str(TotalTweets)+'\n')
f.close()            
########################################################################################################
##    Compute Distinct Times
########################################################################################################
with open('TimeFrame.txt', "r+") as f:
    TF=f.readlines()
f.close()
UniqueTimeFrame = {x for x in TF}
########################################################################################################
##    Display Results
########################################################################################################
print("# of Times: {0}\n".format(len(TF)))
print("# of Unique Times: {0}\n".format(len(UniqueTimeFrame)))
SUTF=sorted([i.replace(' +000\n','') for i in UniqueTimeFrame])
print("Earliest Time Reported: {0}".format(min(UniqueTimeFrame)))
print("Latest Time Reported: {0}".format(max(UniqueTimeFrame)))
