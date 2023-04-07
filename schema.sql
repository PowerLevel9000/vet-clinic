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

-- day-2 TABLE alter
ALTER TABLE animals ADD COLUMN species TEXT;

-- checking Table structure
\ d animals -- viewing table 
SELECT
  *
from
  animals;