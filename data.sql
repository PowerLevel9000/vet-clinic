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
	animals -- DAY 3 insertion
INSERT INTO
	owners(full_name, age)
VALUES
	('Sam Smith', 34),
	('Jennifer Orwell', 45),
	('Bob', 77),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

-- INSERT 0 6
-- updates due to wrong insertion
UPDATE
	owners
SET
	age = CASE
		WHEN full_name = 'Bob' THEN 45
		WHEN full_name = 'Jennifer Orwell' THEN 19
		ELSE age
	END
WHERE
	full_name IN ('Bob', 'Jennifer Orwell');

-- UPDATE 2
-- table view
SELECT
	*
FROM
	owners;

--  id |    full_name    | age
-- ----+-----------------+-----
--   1 | Sam Smith       |  34
--   4 | Melody Pond     |  77
--   5 | Dean Winchester |  14
--   6 | Jodie Whittaker |  38
--   3 | Bob             |  45
--   2 | Jennifer Orwell |  19
-- (6 rows)
INSERT INTO
	species(name)
VALUES
	('Digimon'),
	('Pokemon');

-- INSERT 0 2
SELECT
	*
FROM
	species;

-- id |  name
-- ----+---------
--   1 | Digimon
--   2 | Pokemon
-- (2 rows)
/*Modify your inserted animals so it includes the species_id value:
 
 If the name ends in "mon" it will be Digimon
 All other animals are Pokemon
 */
UPDATE
	animals
SET
	species_id = (
		SELECT
			id
		from
			species
		WHERE
			name = 'Digimon'
	)
WHERE
	name Like '%mon';

-- UPDATE 6
UPDATE
	animals
SET
	species_id = (
		SELECT
			id
		from
			species
		WHERE
			name = 'Pokemon'
	)
WHERE
	species_id IS NULL;

-- UPDATE 4
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		from
			owners
		WHERE
			full_name = 'Sam Smith'
	)
WHERE
	name = 'Agumon';

-- UPDATE 1
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		from
			owners
		WHERE
			full_name = 'Jennifer Orwell'
	)
WHERE
	name IN ('Pikachu', 'Gabumon');

-- UPDATE 2
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		from
			owners
		WHERE
			full_name = 'Bob'
	)
WHERE
	name IN ('Devimon', 'Plantmon');

-- UPDATE 2
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		from
			owners
		WHERE
			full_name = 'Dean Winchester'
	)
WHERE
	name IN ('Angemon', 'Boarmon');

-- UPDATE 2
UPDATE
	animals
SET
	owner_id = (
		SELECT
			id
		from
			owners
		WHERE
			full_name = 'Melody Pond'
	)
WHERE
	name IN ('Charmander', 'Squirtle', 'Blossom');

-- UPDATE 3
SELECT
	*
FROM
	animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id
-- ----+------------+---------------+-----------------+----------+-----------+------------+----------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 |          1 |        1
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 |          1 |        2
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |          2 |        2
--   6 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 |          1 |        3
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 |          1 |        3
--   8 | Angemon    | 2005-06-12    |               1 | t        |        45 |          1 |        5
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 |          1 |        5
--   5 | Charmander | 2020-02-08    |               0 | f        |        11 |          2 |        4
--   7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 |          2 |        4
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 |          2 |        4
SELECT
	*
FROM
	owners;

--  id |  name
-- ----+---------
--   1 | Digimon
--   2 | Pokemon
-- (2 rows)
SELECT
	*
FROM
	species;

--  id |  name
-- ----+---------
--   1 | Digimon
--   2 | Pokemon
-- (2 rows)