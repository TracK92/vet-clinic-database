/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT * FROM animals WHERE date_of_birth BETWEEN date '2016-01-01' AND date '2019-01-01';

SELECT * FROM animals WHERE neutered=true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name='Pikachu' OR name='Agumon';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered=true;

SELECT * FROM animals WHERE NOT name='Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- UPDATES
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- species 'digimon' for animals ending with 'mon'

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- species 'pokemon' where no species is specified
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- delete all rows in table
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- new transaction
BEGIN;
-- delete animals born after JAN 1st 2022
DELETE FROM animals WHERE date_of_birth > date '2022-01-01';
-- CREATE SAVEPOINT FOR THE TRANSACTION
SAVEPOINT weight_changes;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO weight_changes;
-- Update weight for negative values
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- commit
COMMIT;

-- QUERIES TO QUESTIONS
-- Number of animals
SELECT COUNT(*) FROM animals;
-- Animals with zero escape attempts
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
-- Average weight of all animals
SELECT AVG(weight_kg) FROM animals;
-- who escapes the most
SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
-- minimum weight
SELECT MIN(weight_kg) FROM animals;
-- maximum weight
SELECT MAX(weight_kg) FROM animals;
-- Average escape attempts for specific animals
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN date '1990-01-01' AND date '2000-01-01';

-- QUERIES TO QUESTIONS USING JOIN
-- melody's animals
SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- pokemon species
SELECT animals.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- all animal owners
SELECT owners.full_name FROM owners LEFT JOIN animals on owners.id = animals.owner_id;

-- number of animals per species
SELECT species.name, COUNT(*) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- All Digimon owners by Jennifer Orwell
SELECT animals.name FROM animals INNER JOIN owners ON owners.id = animals.owner_id WHERE species_id = 2 AND owners.full_name = 'Jennifer Orwell';

-- Animals owned by Dean Winchester that have tried to escape
SELECT animals.name FROM animals INNER JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Dean Winchester' AND escape_attempts > 0;

-- owner with the most animals
SELECT owners.full_name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;
