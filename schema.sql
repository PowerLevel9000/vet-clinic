/* 
 Database schema to keep the structure of entire database.
 
 ** hope you are connected with data base **
 if not open psql shell
 Server [localhost]:
 Database [postgres]: --you can write here you database name as well
 Port [5432]:
 Username [postgres]:
 Password for user postgres:
 ** output**
 psql (15.2)
 WARNING: Console code page (437) differs from Windows code page (1252)
 8-bit characters might not work correctly. See psql reference
 page "Notes for Windows users" for details.
 Type "help" for help.
 */
\ c vet_clinic
/*
 You are now connected to database "vet_clinic" as user "postgres".
 */
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
--*************************************************************** DAY 1 creation ****************************************************************************************************************************************
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
/* *************************************************************** EXPLANATION ****************************************************************************************************************************************
 *********************************************  Every query have output expected just bellow the query ends *********************************************************************************************************** */
-- creating animal table
CREATE TABLE animals (
  id INT NOT NULL PRIMARY KEY,
  --i thought i should add serial but seen int in project
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg REAL NOT NULL
);

------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
--*************************************************************** DAY 2 ALTERATION ****************************************************************************************************************************************
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
ALTER TABLE
  animals
ADD
  COLUMN species TEXT;

-- checking Table structure
\ d animals;

-- viewing table 
SELECT
  *
from
  animals;

------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
--*************************************************************** DAY 2 creation And alteration ****************************************************************************************************************************************
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
CREATE TABLE owners (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  full_name varchar(50) NOT NULL,
  age INT
);

-- CREATE TABLE
\ d owners;

--                                      Table "public.owners"
--   Column   |         Type          | Collation | Nullable |              Default
-- -----------+-----------------------+-----------+----------+------------------------------------
--  id        | bigint                |           | not null | nextval('owners_id_seq'::regclass)
--  full_name | character varying(50) |           | not null |
--  age       | integer               |           |          |
-- Indexes:
--     "owners_pkey" PRIMARY KEY, btree (id)
-- TABLE CREATION species
CREATE TABLE species (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL
);

-- CREATE TABLE
\ d species;

--                                     Table "public.species"
--  Column |          Type          | Collation | Nullable |               Default
-- --------+------------------------+-----------+----------+-------------------------------------
--  id     | bigint                 |           | not null | nextval('species_id_seq'::regclass)
--  name   | character varying(100) |           | not null |
-- Indexes:
--     "species_pkey" PRIMARY KEY, btree (id)
-- drop species from animals
BEGIN;

-- BEGIN
ALTER TABLE
  animals DROP COLUMN species;

ALTER TABLE
  SAVEPOINT drop_species;

-- SAVEPOINT
ALTER TABLE
  animals
ADD
  COLUMN species_id int,
ADD
  COLUMN owner_id int;

-- ALTER TABLE
SAVEPOINT species_id_and_owner_id;

ALTER TABLE
  animals
ADD
  CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id),
ADD
  CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);

-- ALTER TABLE
commit;

-- COMMIT
/*view the table */
SELECT
  *
FROM
  animals;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species_id | owner_id
-- ----+------------+---------------+-----------------+----------+-----------+------------+----------
--   6 | Plantmon   | 2021-11-15    |               2 | t        |       5.7 |            |
--   8 | Angemon    | 2005-06-12    |               1 | t        |        45 |            |
--   5 | Charmander | 2020-02-08    |               0 | f        |        11 |            |
--   7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 |            |
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 |            |
--   2 | Gabumon    | 2018-11-15    |               2 | t        |         8 |            |
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 |            |
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 |            |
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.04 |            |
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 |            |
-- (10 rows)
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
--*************************************************************** DAY 4 creation ****************************************************************************************************************************************
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
CREATE TABLE vets (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE
);

-- CREATE TABLE
SELECT
  *
From
  vets;

--    id |       name       | age | date_of_graduation
-- ----+------------------+-----+--------------------
--   1 | William Tatcher  |  45 | 2000-04-23
--   2 | Maisy Smith      |  26 | 2019-01-17
--   3 | Stephanie Mendez |  64 | 1981-05-04
--   4 | Jack Harkness    |  38 | 2008-06-08
CREATE TABLE specializations (
  vet_id INT NOT NULL,
  species_id INT NOT NULL,
  PRIMARY KEY (vet_id, species_id),
  CONSTRAINT fk_specializations_vets FOREIGN KEY (vet_id) REFERENCES vets (id),
  CONSTRAINT fk_specializations_species FOREIGN KEY (species_id) REFERENCES species (id)
);

-- CREATE TABLE
SELECT
  *
From
  specializations;

--  vet_id | species_id
-- --------+------------
--       1 |          2
--       3 |          2
--       3 |          1
--       4 |          1
-- (4 rows)
CREATE TABLE visits (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  animal_id INT NOT NULL,
  vet_id INT NOT NULL,
  date_of_visit DATE NOT NULL,
  CONSTRAINT fk_visits_animals FOREIGN KEY (animal_id) REFERENCES animals (id),
  CONSTRAINT fk_visits_vets FOREIGN KEY (vet_id) REFERENCES vets (id)
);

-- CREATE TABLE
SELECT
  *
From
  visits;

--  id | animal_id | vet_id | date_of_visit
-- ----+-----------+--------+---------------
--   1 |         1 |      1 | 2020-05-24
--   2 |         1 |      3 | 2020-07-22
--   3 |         1 |      4 | 2021-02-02
--   4 |         2 |      2 | 2020-01-05
--   5 |         2 |      2 | 2020-03-08
--   6 |         2 |      2 | 2020-05-14
--   7 |         1 |      3 | 2021-05-04
--   8 |         2 |      4 | 2021-02-24
--   9 |         1 |      2 | 2019-12-21
--  10 |         1 |      1 | 2020-08-10
--  11 |         1 |      2 | 2021-04-07
--  12 |         2 |      3 | 2019-09-29
--  13 |         1 |      4 | 2020-10-03
--  14 |         1 |      4 | 2020-11-04
--  15 |         1 |      2 | 2019-01-24
--  16 |         1 |      2 | 2019-05-15
--  17 |         1 |      2 | 2020-02-27
--  18 |         1 |      2 | 2020-08-03
--  19 |         2 |      3 | 2020-05-24
--  20 |         2 |      1 | 2021-01-11
\ d;

--                List of relations
--  Schema |      Name       |   Type   |  Owner
-- --------+-----------------+----------+----------
--  public | animals         | table    | postgres
--  public | car             | table    | postgres
--  public | car_id_seq      | sequence | postgres
--  public | owners          | table    | postgres
--  public | owners_id_seq   | sequence | postgres
--  public | persons         | table    | postgres
--  public | persons_id_seq  | sequence | postgres
--  public | specializations | table    | postgres
--  public | species         | table    | postgres
--  public | species_id_seq  | sequence | postgres
--  public | vets            | table    | postgres
--  public | vets_id_seq     | sequence | postgres
--  public | visits          | table    | postgres
--  public | visits_id_seq   | sequence | postgres
-- (14 rows)
\ d animals;

--                           Table "public.animals"
--      Column      |          Type          | Collation | Nullable | Default
-- -----------------+------------------------+-----------+----------+---------
--  id              | integer                |           | not null |
--  name            | character varying(255) |           | not null |
--  date_of_birth   | date                   |           | not null |
--  escape_attempts | integer                |           | not null |
--  neutered        | boolean                |           | not null |
--  weight_kg       | real                   |           | not null |
--  species_id      | integer                |           |          |
--  owner_id        | integer                |           |          |
-- Indexes:
--     "animals_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "fk_species_id" FOREIGN KEY (species_id) REFERENCES species(id)
-- Referenced by:
--     TABLE "visits" CONSTRAINT "fk_visits_animals" FOREIGN KEY (animal_id) REFERENCES animals(id)
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
--*************************************************************** week-2 DAY 1 table alteration ****************************************************************************************************************************************
------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------+------
ALTER TABLE
  owners
ADD
  COLUMN email VARCHAR(120);

  CREATE INDEX indx_animal_id on visits (animal_id);

-- CREATE INDEX
  CREATE INDEX index_vet_id ON visits (vet_id);
  -- CREATE INDEX