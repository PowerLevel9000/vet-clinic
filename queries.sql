/*Queries that provide answers to the questions from all projects.*/
/*
 connect to the database if you created already otherwise go to the respective file
 
 follow this in psql shell
 
 Server [localhost]:
 Database [postgres]: vet_clinic
 Port [5432]:
 Username [postgres]:
 Password for user postgres:
 psql (15.2)
 WARNING: Console code page (437) differs from Windows code page (1252)
 8-bit characters might not work correctly. See psql reference
 page "Notes for Windows users" for details.
 Type "help" for help.
 
 SELECT * from animals;
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
 ----+---------+---------------+-----------------+----------+-----------
 1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
 2 | Gabumon | 2018-11-15    |               2 | t        |         8
 3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
 4 | Devimon | 2017-05-12    |               5 | t        |        11
 (4 rows)
 
 */
-- Find all animals whose name ends in "mon".
SELECT
  name
FROM
  animals
WHERE
  name LIKE '%mon';

/* output expected
 name
 ---------
 Agumon
 Gabumon
 Devimon
 (3 rows)
 */
--  List the name of all animals born between 2016 and 2019.
SELECT
  name
FROM
  animals
WHERE
  date_of_birth BETWEEN '2016-01-01'
  AND '2019-12-31';

/* output expected
 name
 ---------
 Gabumon
 Devimon
 (2 rows)
 */
--  List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT
  name
FROM
  animals
WHERE
  escape_attempts < '3'
  AND neutered = '1';

/* output expected 
 name
 ---------
 Agumon
 Gabumon
 (2 rows)
 */
--  List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT
  date_of_birth
FROM
  animals
WHERE
  name IN ('Agumon', 'Pikachu');

/* output expected
 date_of_birth
 ---------------
 2020-02-03
 2021-01-07
 (2 rows)
 */
--  List name and escape attempts of animals that weigh more than 10.5kg
SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > '10.5';

/* output expected 
 name   | escape_attempts
 ---------+-----------------
 Pikachu |               1
 Devimon |               5
 (2 rows)
 */
--  Find all animals that are neutered.
SELECT
  name
FROM
  animals
WHERE
  neutered = '1';

/* output expected
 name
 ---------
 Agumon
 Gabumon
 Devimon
 (3 rows)
 */
--  Find all animals not named Gabumon.
SELECT
  name
FROM
  animals
WHERE
  name != 'Gabumon';

/* output expected
 name
 ---------
 Agumon
 Pikachu
 Devimon
 (3 rows)
 */
--  Find every thing about animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT
  *
FROM
  animals
WHERE
  weight_kg >= '10.4'
  AND weight_kg <= '17.3';

/* output expected
 id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
 ----+---------+---------------+-----------------+----------+-----------
 3 | Pikachu | 2021-01-07    |               1 | f        |     15.04
 4 | Devimon | 2017-05-12    |               5 | t        |        11
 (2 rows)
 */
--  Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT
  name
FROM
  animals
WHERE
  weight_kg >= '10.4'
  AND weight_kg <= '17.3';

/* output expected
 name
 ---------
 Pikachu
 Devimon
 (2 rows)
 */
--  DAY 2 QUERIES
-- ************************************************************************* line COMMENTS ARE EXPECTED OUTPUTS **************************************************************
/*Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
 */
BEGIN;

-- BEGIN
UPDATE
  animals
SET
  species = 'unspecified';

-- UPDATE 11
-- SELECT * FROM animals;
--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg |   species
-- ----+------------+---------------+-----------------+----------+-----------+-------------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | unspecified
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | unspecified
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | unspecified
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | unspecified
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 | unspecified
--   6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | unspecified
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | unspecified
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | unspecified
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | unspecified
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | unspecified
--  11 | Ditto      | 2022-05-14    |               4 | t        |        22 | unspecified
-- (11 rows)
ROLLBACK;

-- ROLLBACK
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 |
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 |
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 |
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 |
--   6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 |
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 |
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 |
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 |
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 |
--  11 | Ditto      | 2022-05-14    |               4 | t        |        22 |
-- (11 rows)
/*
 Inside a transaction:
 
 Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
 Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
 Commit the transaction.
 Verify that change was made and persists after commit.
 
 */
BEGIN;

-- BEGIN
UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon';

-- UPDATE 6
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 |
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 |
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 |
--  11 | Ditto      | 2022-05-14    |               4 | t        |        22 |
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
-- (11 rows)
UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species IS NULL;

UPDATE
  5
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
--  11 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
-- (11 rows)
COMMIT;

-- COMMIT
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
--  11 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
-- (11 rows)
/* Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
 After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)  */
/* (✿◡‿◡)(✿◡‿◡)(✿◡‿◡)[]~(￣▽￣)~*[]~(￣▽￣)~*[]~(￣▽￣)~*[]~(￣▽￣)~*[]~(￣▽￣)~*[]~(￣▽￣)~*(✿◡‿◡)(✿◡‿◡)(❁´◡`❁) */
BEGIN;

-- BEGIN
DELETE FROM
  animals;

-- DELETE 11
\ d --                List of relations
--  Schema |      Name      |   Type   |  Owner
-- --------+----------------+----------+----------
--  public | animals        | table    | postgres
--  public | car            | table    | postgres
--  public | car_id_seq     | sequence | postgres
--  public | persons        | table    | postgres
--  public | persons_id_seq | sequence | postgres
-- (5 rows)
SELECT
  *
FROM
  animals;

--  id | name | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------+---------------+-----------------+----------+-----------+---------
-- (0 rows)
ROLLBACK;

-- ROLLBACK
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
--  11 | Ditto      | 2022-05-14    |               4 | t        |        22 | pokemon
-- (11 rows)
/* Inside a transaction:
 
 Delete all animals born after Jan 1st, 2022.
 Create a savepoint for the transaction.
 Update all animals' weight to be their weight multiplied by -1.
 Rollback to the savepoint
 Update all animals' weights that are negative to be their weight multiplied by -1.
 Commit transaction
 */
BEGIN;

-- BEGIN
DELETE FROM
  animals
WHERE
  date_of_birth > '2022-01-01';

-- DELETE 1
SAVEPOINT dateOfBirth;

-- SAVEPOINT
UPDATE
  animals
SET
  weight_kg = weight_kg * -1;

-- UPDATE 10
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |    -10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |        -8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |       -11 | digimon
--   6 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |        45 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |     -20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |    -15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |       -17 | pokemon
-- (10 rows)
ROLLBACK TO dateOfBirth;

-- ROLLBACK
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   6 | Plantmon   | 2021-11-15    |               2 | t        |      -5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |       -45 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |       -11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |    -12.13 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
-- (10 rows)
UPDATE
  animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;

-- UPDATE 4
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   6 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |        45 | digimon
--   5 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
-- (10 rows)
COMMIT;

-- COMMIT

