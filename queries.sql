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
/*
 Write queries to answer the following questions:
 
 How many animals are there?
 How many animals have never tried to escape?
 What is the average weight of animals?
 Who escapes the most, neutered or not neutered animals?
 What is the minimum and maximum weight of each type of animal?
 What is the average number of escape attempts per animal type of those born between 1990 and 2000?
 */
SELECT
  MAX(id)
FROM
  animals;

--  max
-- -----
--   10
-- (1 row)
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;

count -------
2 (1 row)
SELECT
  AVG(weight_kg)
FROM
  animals;

--         avg
-- --------------------
--  15.549999904632568
-- (1 row)
SELECT
  ROUND(AVG(weight_kg))
FROM
  animals;

--  round
-- -------
--     16
-- (1 row)
SELECT
  neutered,
  SUM(escape_attempts)
FROM
  animals
GROUP BY
  neutered;

--  neutered | sum
-- ----------+-----
--  f        |   4
--  t        |  20
-- (2 rows)
SELECT
  neutered,
  SUM(escape_attempts)
FROM
  animals
GROUP BY
  neutered
ORDER BY
  sum DESC
LIMIT
  1;

--  neutered | sum
-- ----------+-----
--  t        |  20
-- (1 row)
SELECT
  neutered,
  SUM(escape_attempts) AS max_attempt_made
FROM
  animals
GROUP BY
  neutered
HAVING
  SUM(escape_attempts) = (
    SELECT
      MAX(total_escapes)
    FROM
      (
        SELECT
          neutered,
          SUM(escape_attempts) AS total_escapes
        FROM
          animals
        GROUP BY
          neutered
      ) AS max_subquery
  );

--  neutered | max_attempt_made
-- ----------+------------------
--  t        |               20
-- (1 row)
SELECT
  species,
  MAX(weight_kg),
  MIN(weight_kg)
FROM
  animals
GROUP BY
  species;

--  species | max | min
-- ---------+-----+-----
--  pokemon |  17 |  11
--  digimon |  45 | 5.7
-- (2 rows)
^ --  SELECT species, AVG(escape_attempts) AS average_attempts from animals
--  WHERE date_of_birth BETWEEN DATE '1990-12-31' AND '2000-01-01'
--  GROUP BY species;
--  species |  average_attempts
-- ---------+--------------------
--  pokemon | 3.0000000000000000
-- (1 row)
SELECT
  species,
  date_of_birth
FROM
  animals
WHERE
  date_of_birth BETWEEN DATE '1990-12-31'
  AND '2000-01-01';

--  species | date_of_birth
-- ---------+---------------
--  pokemon | 1993-04-02
--  pokemon | 1998-10-13
-- (2 rows)
-- day 3 query
/* Write queries (using JOIN) to answer the following questions:
 
 What animals belong to Melody Pond?
 */
SELECT
  animals.name
FROM
  animals
  JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

--       name
-- ------------
--  Blossom
--  Squirtle
--  Charmander
-- (3 rows)
/*List of all animals that are pokemon (their type is Pokemon).*/
SELECT
  animals.name
FROM
  animals
  JOIN species ON animals.species_id = species.id
WHERE
  species.name = 'Pokemon';

--     name
-- ------------
--  Blossom
--  Squirtle
--  Charmander
--  Pikachu
-- (4 rows)
/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT
  owners.full_name,
  COALESCE(animals.name, 'not own animal')
FROM
  owners
  LEFT JOIN animals ON owners.id = animals.owner_id;

--     full_name    |    coalesce
-- -----------------+----------------
--  Sam Smith       | Agumon
--  Melody Pond     | Blossom
--  Melody Pond     | Squirtle
--  Melody Pond     | Charmander
--  Dean Winchester | Boarmon
--  Dean Winchester | Angemon
--  Jodie Whittaker | not own animal
--  Bob             | Devimon
--  Bob             | Plantmon
--  Jennifer Orwell | Pikachu
--  Jennifer Orwell | Gabumon
-- (11 rows)
/*List all Digimon owned by Jennifer Orwell.*/
SELECT
  animals.name
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id
  JOIN species ON animals.species_id = species.id
WHERE
  owners.full_name = 'Jennifer Orwell'
  AND species.name = 'Digimon';

-- ---------
--  Gabumon
-- (1 row)
/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT
  animals.name
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Dean Winchester'
  AND animals.escape_attempts = 0;

--    name
-- ------
-- (0 rows)
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
-- (10 rows)
SELECT
  *
from
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
-- vet_clinic = #
/*Who owns the most animals?*/
SELECT
  owners.full_name,
  COUNT(animals.id) AS num_animals
FROM
  owners
  LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY
  owners.id
ORDER BY
  num_animals DESC
LIMIT
  1;

--   full_name  | num_animals
-- -------------+-------------
--  Melody Pond |           3
-- (1 row)
/*How many animals are there per species?*/
SELECT
  species.name AS species_name,
  COUNT(animals.id) AS num_animals
FROM
  animals
  JOIN species ON animals.species_id = species.id
GROUP BY
  species.id;

--    species_name | num_animals
-- --------------+-------------
--  Digimon      |           6
--  Pokemon      |           4
-- (2 rows)
-- day - 4 query
/* Who was the last animal seen by William Tatcher? */
SELECT
  vets.name AS VETS,
  animals.name AS last_Visit_by
FROM
  animals
  JOIN visits ON visits.animal_id = animals.species_id
  JOIN vets ON visits.vet_id = vets.id
WHERE
  vets.name = 'William Tatcher'
ORDER BY
  date_of_visit DESC;

SELECT
  vets.name AS VETS,
  animals.name AS last_Visit_by
FROM
  animals
  JOIN visits ON visits.animal_id = animals.species_id
  JOIN vets ON visits.vet_id = vets.id
WHERE
  vets.name = 'William Tatcher'
ORDER BY
  date_of_visit DESC
LIMIT
  1;

--          vets       | last_visit_by
-- ------------------+---------------
--  William Tatcher | Blossom
/*How many different animals did Stephanie Mendez see?*/
SELECT
  vets.name AS VETS,
  species.name AS last_Visit_by
FROM
  species
  JOIN visits ON visits.animal_id = species.id
  JOIN vets ON visits.vet_id = vets.id
WHERE
  vets.name = 'Stephanie Mendez'
ORDER BY
  date_of_visit DESC;

SELECT
  vets.name AS VETS,
  count(DISTINCT species.name) AS different_animals
FROM
  species
  JOIN visits ON visits.animal_id = species.id
  JOIN vets ON visits.vet_id = vets.id
WHERE
  vets.name = 'Stephanie Mendez'
GROUP BY
  vets.name;

--        vets       | different_animals
-- ------------------+-------------------
--  Stephanie Mendez |                 2
/*List all vets and their specialties, including vets with no specialties.*/
SELECT
  vets.name AS vet,
  species.name AS specializations
FROM
  vets
  JOIN specializations ON vet_id = vets.id
  JOIN species ON species_id = species.id
ORDER BY
  vets.name;

--         vet       |  specializations
-- ------------------+---------
--  Jack Harkness    | Digimon
--  Stephanie Mendez | Pokemon
--  Stephanie Mendez | Digimon
--  William Tatcher  | Pokemon
-- (4 rows)
----------------------------------------------------------------------------------------
/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT
  visits.date_of_visit AS visited_date,
  animals.name AS visitor
FROM
  visits
  JOIN animals ON animal_id = animals.species_id
  JOIN vets ON vet_id = vets.id
WHERE
  vets.name = 'Stephanie Mendez'
  AND date_of_visit between DATE '2020-04-01'
  AND '2020-08-30'
ORDER BY
  date_of_visit DESC;

--  visited_date |  visitor
-- --------------+------------
--  2020-07-22   | Boarmon
--  2020-07-22   | Angemon
--  2020-07-22   | Devimon
--  2020-07-22   | Plantmon
--  2020-07-22   | Gabumon
--  2020-07-22   | Agumon
--  2020-05-24   | Blossom
--  2020-05-24   | Squirtle
--  2020-05-24   | Charmander
--  2020-05-24   | Pikachu
-- (10 rows)
------------------------------------------------------------------------------
/* What animal has the most visits to vets? */
SELECT
  animals.name AS animal,
  count(*) AS most_VISITS
FROM
  visits
  JOIN animals ON visits.animal_id = animals.species_id
GROUP BY
  animals.name
ORDER BY
  most_VISITS DESC
LIMIT
  1;

------------------------------------------------------------------------------
/*Who was Maisy Smith's first visit?*/
SELECT
  animals.name AS visited,
  vets.name AS vet
FROM
  visits
  JOIN animals ON animal_id = animals.species_id
  JOIN vets ON vet_id = vets.id
WHERE
  vets.name = 'Maisy Smith'
ORDER BY
  date_of_visit ASC
LIMIT
  1;

--  visited |     vet
-- ---------+-------------
--  Boarmon | Maisy Smith
-- (1 row)
------------------------------------------------------------------------------------
/* Details for most recent visit: animal information, vet information, and date of visit */
SELECT
  vets.*,
  animals.*,
  visits.date_of_visit
from
  visits
  JOIN animals ON animal_id = animals.species_id
  JOIN vets ON vet_id = vets.id
ORDER BY
  date_of_visit DESC
LIMIT
  1;

--  id |       name       | age | date_of_graduation | id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id | date_of_visit
-- ----+------------------+-----+--------------------+----+---------+---------------+-----------------+----------+-----------+------------+----------+---------------
--   3 | Stephanie Mendez |  64 | 1981-05-04         |  9 | Boarmon | 2005-06-07    |               7 | t        |      20.4 |          1 |        5 | 2021-05-04
--------------------------------------------------------------------------------------
/* How many visits were with a vet that did not specialize in that animal's species? */
/************************************************* EXPLANATION **************************************************************************/
/* I refactor my data and i found a problem like i inserted species id instead of animal id thats why i am getting three times of the counter so 
 division of three is helpful for now same with last query */
SELECT
  count(*) / 3
FROM
  visits
  JOIN animals ON animals.id = visits.animal_id
  JOIN vets ON vets.id = visits.vet_id
WHERE
  animals.species_id NOT IN (
    SELECT
      species_id
    FROM
      specializations
    WHERE
      vet_id = vets.id
  ) --  counter
  -- ---------
  --        4
  -- (1 row)
  --------------------------------------------------------------------------------------
  /* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
  /* SEE line no 903 for explanation */
SELECT
  species.name,
  count(*) / 3 AS counter
FROM
  visits
  JOIN animals ON animals.id = visits.animal_id
  JOIN species ON animals.species_id = species.id
  JOIN vets ON vets.id = visits.vet_id
WHERE
  vets.name = 'Maisy Smith'
GROUP BY
  species.name;

--   name   | counter
-- ---------+---------
--  Digimon |       3
-- (1 row)
--  so she should be specialist of digimon not pokemon