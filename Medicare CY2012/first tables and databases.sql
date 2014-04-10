-- Data downloaded from http://www.cms.gov/apps/ama/license-2011.asp?file=http://download.cms.gov/Research-Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-Charge-Data/Downloads/Medicare-Physician-and-Other-Supplier-PUF-CY2012.zip on 04/09/2014.

CREATE DATABASE medicare2012;

/c medicare 2012

CREATE TABLE medicare_original (
	npi VARCHAR (10),
	nppes_provider_last_org_name VARCHAR (70),
	nppes_provider_first_name VARCHAR (20),
	nppes_provider_mi VARCHAR (1),
	nppes_credentials VARCHAR (20),
	nppes_provider_gender VARCHAR (1),
	nppes_entity_code VARCHAR (1),
	nppes_provider_street1 VARCHAR (55),
	nppes_provider_street2 VARCHAR (55),
	nppes_provider_city VARCHAR (40),
	nppes_provider_zip VARCHAR (20),
	nppes_provider_state VARCHAR (2),
	nppes_provider_country VARCHAR (2),
	provider_type VARCHAR (43),
	medicare_participation_indicator VARCHAR (1),
	place_of_service VARCHAR (1),
	hcpcs_code VARCHAR (5),
	hcpcs_description VARCHAR (30),
	line_srvc_cnt DECIMAL,
	bene_unique_cnt DECIMAL,
	bene_day_srvc_cnt DECIMAL,
	average_Medicare_allowed_amt DECIMAL,
	stdev_Medicare_allowed_amt DECIMAL,
	average_submitted_chrg_amt DECIMAL,
	stdev_submitted_chrg_amt DECIMAL,
	average_Medicare_payment_amt DECIMAL,
	stdev_Medicare_payment_amt DECIMAL
);


-- Original data groups by NPI for the performing provider, the HCPCS code, and the place of service (F/O). There can be multiple records for a given NPI based on distinct HCPCS and where the services were provided.

COPY medicare_original
	FROM 'C:/Users/Elizabeth/Desktop/Medicare-Physician-and-Other-Supplier-PUF-CY2012.txt'
	WITH DELIMITER E'\t' CSV HEADER;
	
DELETE FROM medicare_original
	WHERE npi = '0000000001';

CREATE TABLE shorthand (
	shorthand VARCHAR (35),
	description VARCHAR (60)
);

INSERT INTO shorthand (shorthand,description) VALUES
	('npi','National Provider Identifier'),
	('nppes_provider_last_org_name','Last Name/Organization Name'),
	('nppes_provider_first_name','First Name'),
	('nppes_provider_mi','Middle Initial'),
	('nppes_credentials','Credentials'),
	('nppes_provider_gender','Gender'),
	('nppes_entity_code','Entity Type'),
	('nppes_provider_street1','Street Address 1'),
	('nppes_provider_street2','Street Address 2'),
	('nppes_provider_city','City'),
	('nppes_provider_zip','Zip Code'),
	('nppes_provider_state','State Code'),
	('nppes_provider_country','Country Code'),
	('provider_type','Provider Type'),
	('medicare_participation_indicator','Medicare Participation'),
	('place_of_service','Place of Service'),
	('hcpcs_code','HCPCS Code'),
	('hcpcs_description','HCPCS Description'),
	('line_srvc_cnt','Number of Services'),
	('bene_unique_cnt','Number of Medicare Beneficiaries'),
	('bene_day_srvc_cnt','Number of Medicare Beneficiary/Day Services'),
	('average_Medicare_allowed_amt','Average Medicare Allowed Amount'),
	('stdev_Medicare_allowed_amt','Standard Deviation of Medicare Allowed Amount'),
	('average_submitted_chrg_amt','Average Submitted Charge Amount'),
	('stdev_submitted_chrg_amt','Standard Deviation of Submitted Charge Amount'), 
	('average_Medicare_payment_amt','Average Medicare Payment Amount'),
	('stdev_Medicare_payment_amt','Standard Deviation of Medicare Payment Amount');