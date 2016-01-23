use Polidata;

Create table TotalData(
user_name varchar(30),
gender varchar(30),
loc varchar(30)
);
Create table gender_prob(
first_name varchar(50),
score float(20)
);

#Read in the file into the corresponding tables
LOAD DATA LOCAL INFILE 'C:/Users/Alejandro/Dropbox/Rand Project/JDAD_CODE/name_scores.txt'
INTO TABLE gender_prob
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
(first_name,score);

LOAD DATA LOCAL INFILE 'C:/Users/Alejandro/Desktop/Updated Politweets/datatoSQL_MT.txt'
INTO TABLE politweet_gender
FIELDS TERMINATED BY '$$'
LINES TERMINATED BY '\n'
(User_name,gender,loc);


LOAD DATA LOCAL INFILE 'C:/Users/Alejandro/Dropbox/Rand Project/AlexLOOK/datatoSQL_Total.txt'
INTO TABLE TotalData
FIELDS TERMINATED BY '$$'
LINES TERMINATED BY '\n'
(User_name,loc,gender)
;
# IN ORDER TO DETERMINE THE GENDER PROBABILTIY
CREATE TABLE dropme2 AS
(SELECT
    User_name AS DATA_NAME,
    CASE WHEN LOCATE(' ', User_name) > 0 THEN
        LEFT(User_name,LOCATE(' ',User_name)-1)
    ELSE
        User_name
    END as FNAME,
    CASE WHEN LOCATE(' ', User_name) > 0 THEN
        SUBSTRING(User_name,LOCATE(' ',User_name)+1, ( LENGTH(User_name) - LOCATE(' ',User_name)+1) )
    ELSE
        NULL
    END as LNAME
FROM TotalData)
;


SELECT distinct SSAN_Name AS SSAN_Fname, score AS GenderScore,
	FNAME AS TwitterName,gender AS TwitterAlgorithm,loc AS TwitterLocation
	FROM gender_prob,dropme,politweet_gender
	WHERE UPPER(gender_prob.SSAN_NAME=dropme.FNAME) 
	AND score >.95
;

SELECT Count(*)
	FROM gender_prob,dropme,politweet_gender
	WHERE UPPER(gender_prob.SSAN_NAME=dropme.FNAME) 
;


SELECT SSAN_NAME AS SSAN_FirstName,score AS GenderScore,
	FNAME AS TwitterNameFirstName,gender AS TwitterAlgorithm 
	FROM gender_prob,dropme,politweet_gender 
	WHERE dropme.FNAME regexp  gender_prob.SSAN_NAME 
;

