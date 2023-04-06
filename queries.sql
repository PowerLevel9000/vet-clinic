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
 
 vet_clinic=# SELECT * from animals;
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
  escape_attempts < '3';

/* output expected 
 name
 ---------
 Agumon
 Gabumon
 Pikachu
 (3 rows)
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