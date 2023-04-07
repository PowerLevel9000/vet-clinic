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
 ** output **
 You are now connected to database "vet_clinic" as user "postgres".
 */
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

-- ************************************************************************* line COMMENTS ARE EXPECTED OUTPUTS **************************************************************
-- day-2 TABLE alter
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

-- DAY-3 TABLE CREATION OWNER
CREATE TABLE owners (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  full_name varchar(50) NOT NULL,
  age INT NOT NULL
);

-- CREATE TABLE
\ d owners;

--                                      Table "public.owners"
--   Column   |         Type          | Collation | Nullable |              Default
-- -----------+-----------------------+-----------+----------+------------------------------------
--  id        | bigint                |           | not null | nextval('owners_id_seq'::regclass)
--  full_name | character varying(50) |           | not null |
--  age       | integer               |           | not null |
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