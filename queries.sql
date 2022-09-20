/*Queries that provide answers to the questions from all projects.*/
SELECT
  *
FROM
  animals
WHERE
  name LIKE '%mon';

SELECT
  *
FROM
  animals
WHERE
  date_of_birth BETWEEN date '2016-01-01'
  AND date '2019-01-01';

SELECT
  *
FROM
  animals
WHERE
  neutered = true
  AND escape_attempts < 3;

SELECT
  date_of_birth
FROM
  animals
WHERE
  name = 'Pikachu'
  OR name = 'Agumon';

SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

SELECT
  *
FROM
  animals
WHERE
  neutered = true;

SELECT
  *
FROM
  animals
WHERE
  NOT name = 'Gabumon';

SELECT
  *
FROM
  animals
WHERE
  weight_kg BETWEEN 10.4
  AND 17.3;

-- UPDATES
BEGIN;

UPDATE
  animals
SET
  species = 'unspecified';

ROLLBACK;

-- species 'digimon' for animals ending with 'mon'
UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon';

-- species 'pokemon' where no species is specified
UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species IS NULL;

-- delete all rows in table
BEGIN;

DELETE FROM
  animals;

ROLLBACK;

-- new transaction
BEGIN;

-- delete animals born after JAN 1st 2022
DELETE FROM
  animals
WHERE
  date_of_birth > date '2022-01-01';

-- CREATE SAVEPOINT FOR THE TRANSACTION
SAVEPOINT weight_changes;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE
  animals
SET
  weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO weight_changes;

-- Update weight for negative values
UPDATE
  animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;

-- commit
COMMIT;

-- QUERIES TO QUESTIONS
-- Number of animals
SELECT
  COUNT(*)
FROM
  animals;

-- Animals with zero escape attempts
SELECT
  COUNT(escape_attempts)
FROM
  animals
WHERE
  escape_attempts = 0;

-- Average weight of all animals
SELECT
  AVG(weight_kg)
FROM
  animals;

-- who escapes the most
SELECT
  name
FROM
  animals
WHERE
  escape_attempts = (
    SELECT
      MAX(escape_attempts)
    FROM
      animals
  );

-- minimum weight
SELECT
  MIN(weight_kg)
FROM
  animals;

-- maximum weight
SELECT
  MAX(weight_kg)
FROM
  animals;

-- Average escape attempts for specific animals
SELECT
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN date '1990-01-01'
  AND date '2000-01-01';

-- QUERIES TO QUESTIONS USING JOIN
-- melody's animals
SELECT
  name
FROM
  animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

-- pokemon species
SELECT
  animals.name
FROM
  animals
  INNER JOIN species ON animals.species_id = species.id
WHERE
  species.name = 'Pokemon';

-- all animal owners
SELECT
  owners.full_name
FROM
  owners
  LEFT JOIN animals on owners.id = animals.owner_id;

-- number of animals per species
SELECT
  species.name,
  COUNT(*)
FROM
  animals
  INNER JOIN species ON animals.species_id = species.id
GROUP BY
  species.name;

-- All Digimon owners by Jennifer Orwell
SELECT
  animals.name
FROM
  animals
  INNER JOIN owners ON owners.id = animals.owner_id
WHERE
  species_id = 2
  AND owners.full_name = 'Jennifer Orwell';

-- Animals owned by Dean Winchester that have tried to escape
SELECT
  animals.name
FROM
  animals
  INNER JOIN owners ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Dean Winchester'
  AND escape_attempts > 0;

-- owner with the most animals
SELECT
  owners.full_name
FROM
  owners
  LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY
  owners.full_name
ORDER BY
  COUNT(*) DESC
LIMIT
  1;

-- QUERIES TO QUESTIONS REGARDING JOIN TABLES
-- last animal seen by William Tatcher
SELECT
  animals.name
FROM
  animals
  INNER JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = 1
ORDER BY
  visits.date_of_visit DESC
LIMIT
  1;

-- Number of animals seen by Stephanie Mendez
SELECT
  animals.name,
  COUNT(*)
FROM
  animals
  INNER JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = 3
GROUP BY
  animals.name;

-- list all vets and their specialties
SELECT
  vets.name,
  specialization.species_id
FROM
  vets
  LEFT JOIN specialization ON vets.id = specialization.vet_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020
SELECT
  animals.name
FROM
  animals
  INNER JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = 3
  AND visits.date_of_visit BETWEEN date '2020-04-01'
  AND date '2020-08-30';

-- Animal with the most visits to vet
SELECT
  animals.name
FROM
  animals
  INNER JOIN visits ON animals.id = visits.animal_id
GROUP BY
  animals.name
ORDER BY
  COUNT(*) DESC
LIMIT
  1;

-- Maisy Smith's first visit
SELECT
  animals.name
FROM
  animals
  INNER JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = 2
  AND visits.date_of_visit = (
    SELECT
      MIN(date_of_visit)
    FROM
      visits
    WHERE
      visits.vet_id = 2
  );

-- Details for most recent visit: animal information, vet information, and date of visit
SELECT
  animals.name,
  visits.vet_id,
  visits.date_of_visit
FROM
  animals
  INNER JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.date_of_visit = (
    SELECT
      MAX(date_of_visit)
    FROM
      visits
  );

-- Number of visits with a vet that did not specialize in a particular species
SELECT
  COUNT(visits.animal_id)
FROM
  visits
  INNER JOIN vets ON visits.vet_id = vets.id
  INNER JOIN animals ON animals.id = visits.animal_id
  INNER JOIN specialization ON specialization.species_id = vets.id
WHERE
  specialization.species_id != animals.species_id;

-- Most species visits for Maisy
SELECT
  animals.species_id,
  COUNT(*)
FROM
  animals
  INNER JOIN visits ON animals.id = visits.animal_id
WHERE
  visits.vet_id = 2
GROUP BY
  animals.species_id
ORDER BY
  COUNT(*) DESC
LIMIT
  1;

-- EXPLAIN ANALYZE - REDUCE EXECUTION TIME FOR THE FOLLOWING QUERIES
-- Select all visits for vet number 2
SELECT
  *
FROM
  visits
where
  vet_id = 2;

-- select owner with the following email address
SELECT
  *
FROM
  owners
where
  email = 'owner_18327@mail.com';

--phase 5
SELECT count FROM animals_visits_number where animal_id = 4;