/* Populate database with sample data. */
-- after creating successful animal table we can insert row and data with following commands
-- inserting row data
INSERT INTO
	animals (
		id,
		name,
		date_of_birth,
		weight_kg,
		neutered,
		escape_attempts
	)
VALUES
	('1', 'Agumon', '2020-02-03', '10.23', '1', '0');

INSERT INTO
	animals (
		id,
		name,
		date_of_birth,
		weight_kg,
		neutered,
		escape_attempts
	)
VALUES
	('2', 'Gabumon', '2018-11-15', '8', '1', '2');

INSERT INTO
	animals (
		id,
		name,
		date_of_birth,
		weight_kg,
		neutered,
		escape_attempts
	)
VALUES
	('4', 'Pikachu', '2021-01-07', '15.04', '0', '1');

INSERT INTO
	animals (
		id,
		name,
		date_of_birth,
		weight_kg,
		neutered,
		escape_attempts
	)
VALUES
	('4', 'Devimon', '2017-05-12', '11', '1', '5');

-- view table 
SELECT
	*
From
	animals