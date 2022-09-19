/* Database schema to keep the structure of entire database. */
-- animals table
CREATE TABLE animals (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg NUMERIC(5, 2) NOT NULL,
  species VARCHAR(50)
);

-- owners table
CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(50) NOT NULL,
  age INT
);

-- species table
CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

--  new animals
CREATE TABLE new_animals (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg NUMERIC(5, 2) NOT NULL,
  species VARCHAR(50)
);

-- copy data from animals to new_animals except for id
INSERT INTO
  new_animals(
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg,
    species
  )
SELECT
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg,
  species
FROM
  animals;

-- drop animals table
DROP TABLE animals;

-- rename new_animals to animals
ALTER TABLE
  new_animals RENAME TO animals;

-- remove column species from animals
ALTER TABLE
  animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE
  animals
ADD
  COLUMN species_id INT REFERENCES species(id) ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE
  animals
ADD
  COLUMN owner_id INT REFERENCES owners(id) ON DELETE CASCADE;

-- JOIN TABLE FOR VISITS
-- create table named vets
CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(50),
  age INT,
  date_of_graduation DATE
);

-- join table called specialization to handle relationship between species and vets
CREATE TABLE specialization (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  species_id INT REFERENCES species(id) ON DELETE CASCADE,
  vet_id INT REFERENCES vets(id) ON DELETE CASCADE
);

-- join table called visits to handle relationship between animals and vets
CREATE TABLE visits (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
  vet_id INT REFERENCES vets(id) ON DELETE CASCADE,
  date_of_visit DATE NOT NULL
);

-- CREATE INDEXES FOR ANIMAL_ID, VET_ID AND EMAIL
-- create new table animals_visists_number
CREATE TABLE animals_visits_number(
  id INT GENERATED ALWAYS AS IDENTITY,
  animal_id INT,
  count INT,
  CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE
);

-- create index for vet_id
CREATE INDEX visits_vet_id_asc ON visits(vet_id ASC);

-- create index for email
CREATE INDEX owners_email_asc ON owners(email ASC);