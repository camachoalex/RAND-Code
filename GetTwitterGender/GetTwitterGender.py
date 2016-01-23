'''
___________________________________________________________________________________________________
Purpose:
___________________________________________________________________________________________________
Using Python, data mine through the JSON files and keep record of all the twitter recorded genders:
male, female, or other (e.g., mostly_male, mostly_female, unisex, blank field).
___________________________________________________________________________________________________
'''
######################################################################
##                           IMPORT LIBRARIES
######################################################################
import glob
import json
import os
import sys
########################################################################################################
##    Declare and Initialize Variables
########################################################################################################
tot_gen = 0;male = 0;female=0;other = 0
data = {}; LangCount=0;
########################################################################################################
##    OPEN JSON file directory
########################################################################################################
path = r'C:/Users/jroman09/Downloads/DELETE'  # <-----CHANGE DIRECTORY to json files
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
for i in iter(data):
    jsondata=json.loads(data[i].decode())  
    print("Searching in file: {0}\n".format(i+' ...'))
    for j in range(len(jsondata['interactions'])):
        if('demographic' in jsondata['interactions'][j]):
            tot_gen= tot_gen+1
            if(jsondata['interactions'][j]['demographic']['gender'] == 'male'):
                male = male+1
            elif(jsondata['interactions'][j]['demographic']['gender']  == 'female'):
                female = female+1
            else:
                other = other+1
########################################################################################################
##  OUTPUT RESULTS
########################################################################################################                
print("Total Male Count: {0}\n".format(male))
print("Total Female Count: {0}\n".format(female))
print("Total Other Count: {0}\n".format(other))
print("Total Count: {0}\n".format(tot_gen))
