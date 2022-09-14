/* Populate database with sample data. */
-- insert into animals table

INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', date '2020-02-03', 0, true, 10.23);

INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg)
VALUES (2, 'Gabumon', date '2018-11-15', 2, true, 8.00);

INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg)
VALUES (3, 'Pikachu', date '2021-01-07', 1, false, 15.04);

INSERT INTO animals (id, name, date_of_birth,escape_attempts, neutered, weight_kg)
VALUES (4, 'Devimon', date '2017-05-12', 5, true, 11.00);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (5, 'Charmander', date '2020-02-08', 0, false, 11.00);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (6, 'Plantmon', date '2020-11-15', 2, true, 5.70);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (7, 'Squirtle', date '1993-04-02', 3, false, 12.13);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (8, 'Angeomon', date '2005-06-12', 1, true, 45.00);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (9, 'Boarmon', date '2005-06-07', 7, true, 20.40);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (10, 'Blossom', date '1998-10-13', 3, false, 17.00);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (11, 'Ditto', date '2022-05-14', 4, true, 22.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Yellow', date '2020-02-08', 0, false, 11.00);

-- insert into owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 30);

INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);

INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);

INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);

INSERT INTO owners (full_name, age)
VALUES ('JoDIE Whitaker', 38);

--  insert into species table
INSERT INTO species (name)
VALUES ('Pokemon');

INSERT INTO species (name)
VALUES ('Digimon');


-- update species id
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- update owner id

UPDATE animals SET owner_id = 1 WHERE name='Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Pikachu', 'Gabumon');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angeomon', 'Boarmon');
