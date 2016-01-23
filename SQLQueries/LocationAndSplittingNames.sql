#The following query is used for reading in location files.
use Polidata;
SELECT * FROM state;
SELECT * FROM totaldata;


CREATE TABLE US_STATES (
State_name varchar(30),
	State_abv varchar(30),
	Assc_Press varchar(30),
	Region varchar(30),
	Division varchar(30)
);

LOAD DATA LOCAL INFILE 'C:/Users/Alejandro/Desktop/state_table.csv'
	INTO TABLE US_STATES
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	(State_name,State_abv,assc_press, region, division)
;


#OUTPUT STATE and the tweet frequency
SELECT State_name,Count(State_name)  FROM totaldata, US_STATES 
	WHERE UPPER(loc)=UPPER(State_abv )
	OR UPPER(loc) = UPPER(State_name)
	OR UPPER(loc) = UPPER(assc_press)
	OR UPPER(loc) = UPPER(Region)
	OR UPPER(loc) = UPPER(Division)
	OR US_STATES.State_name regexp totaldata.loc
	group by State_name
;

#GENDER COUNTS
SELECT  gender, count(gender), State_name FROM totaldata, us_states
	WHERE UPPER(loc)=UPPER(State_abv )
	OR UPPER(loc) = UPPER(State_name)
	OR UPPER(loc) = UPPER(assc_press)
	OR UPPER(loc) = UPPER(Region)
	OR UPPER(loc) = UPPER(Division)
	OR US_STATES.State_name regexp totaldata.loc
	group by State_name
;

Create table gender_per_state(
men  int(10),
ladies  int(10),
unisex  int(10),
mostly_men int(10),
mostly_fem int(10),
estado varchar(30)
);


#Counts the genders in each state!!!!!
SELECT distinct gender, count( gender),State_name FROM totaldata,us_states 
	WHERE UPPER(loc)=UPPER(State_abv)
	OR UPPER(loc) = UPPER(State_name)
	OR UPPER(loc) = UPPER(assc_press)
	OR UPPER(loc) = UPPER(Region)
	OR UPPER(loc) = UPPER(Division)
	OR US_STATES.State_name regexp totaldata.loc
	group by state_name,gender
;

#This creates a table with only the users we were able to classify.
CREATE TABLE OUR_ALGORITHM(
	SELECT SSAN_Name AS SSAN_Fname, score AS GenderScore,
	FNAME AS TwitterName,gender AS TwitterAlgorithm,loc AS TwitterLocation
	FROM gender_prob,dropme,politweet_gender, US_states
	WHERE UPPER(gender_prob.SSAN_NAME=dropme.FNAME) 
	AND  score >0.95
	AND score <-.95
);


#Takes the sum of the individuals per state
SELECT  State_name,Count(State_name),(select count(state_name) from totaldata, US_STATES 
	WHERE UPPER(loc)=UPPER(State_abv )
	OR UPPER(loc) = UPPER(State_name)
	OR UPPER(loc) = UPPER(assc_press)
	OR UPPER(loc) = UPPER(Region)
	OR UPPER(loc) = UPPER(Division)
	OR US_STATES.State_name regexp totaldata.loc
) AS total_count FROM totaldata, US_STATES
	group by State_name
;
