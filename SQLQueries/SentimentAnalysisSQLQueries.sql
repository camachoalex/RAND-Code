CREATE DATABASE PSentiment;
use PSentiment;
use thefinal;
select * from ptfinal;

## Create a table with Twitter users' ID, Name, Location, Twitter inferred gender, Tweet content, classified gender, first name, last name and sentiment.
CREATE TABLE PoliticalTWeets(
	TW_ID BIGINT(20),
	User_name varchar(255),
	Location varchar(255),
	TwiGender varchar(255),
	Tweet varchar(255),
	gender varchar(255),
	fname varchar(255),
	lastname varchar(255),
	sentiment varchar(255)
);

SET NAMES 'utf8';
LOAD DATA LOCAL INFILE 'C:/Users/Alejandro/Desktop/SentimentAnalysis.txt'
	INTO TABLE politicaltweets
	FIELDS TERMINATED BY '$x$'
	LINES TERMINATED BY '\n'
	(TW_ID, USER_NAME, LOCATION, TWIGENDER, Tweet,gender, fname, lastname,sentiment)
;


select sentiment, count(user_name)
	FROM politicaltweets
	Group by sentiment
;
#This outputs the number of informative and opinionated tweets in our dataset
select count(*) from politicaltweets WHERE sentiment  like 'Infor%';
select count(*) from politicaltweets WHERE sentiment  like 'O%';

select * FROM PoliticalTweets;

# In the following scripts we attempt to classify the sentiment per state. Due to time constraints, we were not able to debug the code completely.
SELECT  sum(sentiment like 'O%'), State_name FROM thefinal.politicaltweets,polidata.us_states 
	WHERE UPPER(thefinal.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	OR polidata.US_STATES.State_name regexp thefinal.politicaltweets.location
	AND GENDER = 'male'
	AND sentiment like 'O%'
	group by polidata.us_states.state_name
;

SELECT  sum(sentiment like 'O%'), State_name FROM thefinal.politicaltweets,polidata.us_states 
	WHERE UPPER(thefinal.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	OR polidata.US_STATES.State_name regexp thefinal.politicaltweets.location
	AND GENDER = 'female'
	AND sentiment like 'O%'
	group by polidata.us_states.state_name
;

SELECT  sum(sentiment like 'Infor%'), State_name FROM thefinal.politicaltweets,polidata.us_states 
	WHERE UPPER(thefinal.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	OR polidata.US_STATES.State_name regexp thefinal.politicaltweets.location
	AND GENDER = 'male'
	AND sentiment like 'Infor%'
	group by polidata.us_states.state_name
;

SELECT  sum(sentiment like 'Infor%'), State_name FROM thefinal.politicaltweets,polidata.us_states 
	WHERE UPPER(thefinal.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(thefinal.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	OR polidata.US_STATES.State_name regexp thefinal.politicaltweets.location
	AND GENDER = 'female'
	AND sentiment like 'Infor%'
	group by polidata.us_states.state_name
;



