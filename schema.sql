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

\c vet_clinic

/*
** output **
You are now connected to database "vet_clinic" as user "postgres".
 */

-- creating animal table
CREATE TABLE animals (
  id int, --i thought i should add serial but seen int in project
	name int,
	date_of_birth date,
	escape_attempts int,
	neutered boolean,
  weight_kg real,
);

-- checking Table structure

\d animals

-- viewing table 

SELECT * from animals;