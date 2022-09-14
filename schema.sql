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
INSERT INTO new_animals(name, date_of_birth, escape_attempts, neutered, weight_kg, species)
SELECT name, date_of_birth, escape_attempts, neutered, weight_kg, species FROM animals;

-- drop animals table
DROP TABLE animals;
-- rename new_animals to animals
ALTER TABLE new_animals
RENAME TO animals;

-- remove column species from animals
ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id)
ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners(id) ON DELETE CASCADE;
