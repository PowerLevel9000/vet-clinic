/* Populate database with sample data. */
-- after creating successful animal table we can insert row and data with following commands
-- inserting row data
-- day-1 new way data insertion
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
	('1', 'Agumon', '2020-02-03', '10.23', '1', '0'),
	('2', 'Gabumon', '2018-11-15', '8', '1', '2'),
	('3', 'Pikachu', '2021-01-07', '15.04', '0', '1'),
	('4', 'Devimon', '2017-05-12', '11', '1', '5');

-- day-2 data insertion
INSERT INTO
	animals (
		id,
		name,
		date_of_birth,
		escape_attempts,
		neutered,
		weight_kg
	)
VALUES
	(5, 'Charmander', '2020-02-08', 0, 'f', -11),
	(6, 'Plantmon', '2021-11-15', 2, 't', -5.7),
	(7, 'Squirtle', '1993-04-02', 3, 'f', -12.13),
	(8, 'Angemon', '2005-06-12', 1, 't', -45),
	(9, 'Boarmon', '2005-06-07', 7, 't', 20.4),
	(10, 'Blossom', '1998-10-13', 3, 't', 17),
	(11, 'Ditto', '2022-05-14', 4, 't', 22);

-- view table 
SELECT
	*
From
	animals