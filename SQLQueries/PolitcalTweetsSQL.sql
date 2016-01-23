use PoliticalData420;


CREATE TABLE UserIds1(
	TwitterID  bigint(11)
);

select count(distinct TwitterID) FROM USERIDS2;
select count(TwitterID) FROM USERIDS2;

CREATE TABLE PoliticalTWeets(
	TW_ID BIGINT(20),
	User_name varchar(255),
	Location varchar(255),
	TwiGender varchar(255),
	Tweet varchar(255)
);

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
LOAD DATA LOCAL INFILE 'C:/Users/Alejandro/Dropbox (CSU Fullerton)/Rand Project/PoliticalTweetsSQL/datatoSQL_NYE3.txt'
	INTO TABLE politicaltweets
	FIELDS TERMINATED BY '$$'
	LINES TERMINATED BY '\n'
(TW_ID, USER_NAME, LOCATION, TWIGENDER, Tweet)
;
DELETE FROM politicaltweets WHERE tw_id=0;

#Used to classify the unisex users.
UPDATE Politicaltweets SET gender = 'male' where Twigender = 'male' or twigender ='mostly_male';
UPDATE Politicaltweets SET gender = 'female' where Twigender = 'female' or twigender ='mostly_female';
select  User_name,twigender,gender from politicalTweets where twigender = 'unisex'; 
select count(gender) from politicaltweets where twigender = 'unisex' and gender='female';
select count(gender) from politicaltweets where twigender = 'unisex' and gender='male';

#==================================================================
use politicaldata420;
#Splits the name by first and last name
SELECT TW_ID, User_name AS User_full_name, Location, Twigender,tweet,
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
FROM politicalTweets
;
select User_name,tweet,twigender, gender, fname FROM politicaltweets where twigender='unisex';
#UPDATE politicaltweets SET gender = 'female' where fname = 'leslie';
select * from politicaltweets where twigender = 'unisex';
select * FROM polidata.gender_prob where ssan_name = 'bakem';

select count(tw_id) from politicaltweets; # classified 184/568

select User_name,tweet,twigender, gender, fname FROM politicaltweets;


#Counts the genders in each state
SELECT DISTINCT gender, count(gender),State_name FROM politicaldata420.politicaltweets,polidata.us_states 
	WHERE UPPER(politicaldata420.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	OR polidata.US_STATES.State_name regexp politicaldata420.politicaltweets.location
	group by polidata.us_states.state_name,politicaldata420.politicaltweets.gender
;

SELECT  sum(gender='feMALE'), State_name FROM politicaldata420.politicaltweets,polidata.us_states 
	WHERE UPPER(politicaldata420.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	OR polidata.US_STATES.State_name regexp politicaldata420.politicaltweets.location
	AND GENDER = 'feMALE'
	group by polidata.us_states.state_name#,politicaldata420.politicaltweets.gender
;

SELECT DISTINCT state_name, (count(gender)) AS 'HOMBRE' FROM polidata.us_states,politicaltweets
	WHERE UPPER(politicaldata420.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	AND gender = 'male'
	OR polidata.US_STATES.State_name regexp politicaldata420.politicaltweets.location
	group by 'hombre','lady',polidata.us_states.state_name
;


#Total tweets per state
SELECT distinct count(gender),State_name FROM politicaldata420.politicaltweets,polidata.us_states 
	WHERE UPPER(politicaldata420.politicaltweets.Location)=UPPER(polidata.us_states.State_abv)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.State_name)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.assc_press)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Region)
	OR UPPER(politicaldata420.politicaltweets.Location) = UPPER(polidata.us_states.Division)
	OR polidata.US_STATES.State_name regexp politicaldata420.politicaltweets.location
	group by polidata.us_states.state_name#,politicaldata420.politicaltweets.gender
;