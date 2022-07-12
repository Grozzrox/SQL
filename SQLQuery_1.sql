--DROP TABLE PokemonType;
--DROP TABLE Pokemon;
--DROP TABLE Type;

CREATE TABLE Pokemon
(
-- column-name variable-type modifiers
    Id INT PRIMARY KEY, -- not null and unique, identity == index
    Name NVARCHAR(64) NOT NULL UNIQUE,
    Height INT NOT NULL,
    Weight INT NOT NULL
);

CREATE TABLE Type 
(
    Id INT PRIMARY KEY,
    Name NVARCHAR(64) NOT NULL UNIQUE
);

/* Multiplicity - the relationships between the entries in a database/tables

1-to-1: For each entry in table A, there is one (and only one) entry related to it in table B
1-to-many: For each entry in table A, there is/are many entries related to it in table B
many-to-many: For many entries in table A, there are many entries related to it in table B

*/

-- create a linking table between Pokemon and Type

CREATE TABLE PokemonType
(
    Id INT NOT NULL PRIMARY KEY IDENTITY,
    PokemonId INT NOT NULL FOREIGN KEY REFERENCES Pokemon (Id)
        ON DELETE CASCADE,

    TypeId INT NOT NULL FOREIGN KEY REFERENCES Type (Id)
        ON DELETE CASCADE
);

-- CASCADE triggers the specified column to also delete/update when the FK entry is affected

-- Insert data into the tables

INSERT INTO Pokemon (Id, Name, Height, Weight) VALUES
(1, 'Charizard', 67, 215),
(2, 'Mudkip', 24, 45);

INSERT INTO Type (Id, Name) VALUES
(1, 'Fire'),
(2, 'Water'),
(3, 'Dragon'),
(4, 'Grass');

INSERT INTO PokemonType(PokemonId, TypeId) VALUES
(1, 1),
(1, 3),
(2, 2);
-- Is there a better way to enter this data? Where I DON'T have to look up the tables first to find their FKs?

SELECT * FROM Type;
SELECT * FROM Pokemon;

SELECT Name, Height FROM Pokemon;

-- Use the WHERE keyword to add a filter to your query
SELECT Name FROM Pokemon WHERE (Height > 50);

SELECT Name FROM Pokemon WHERE Name LIKE '%ar%';

SELECT * FROM PokemonType;

-- join two tables along a common column (key pair) so that we can retrieve data from both tables at the same time 
-- use the AS keyword to create an alias that can shorten the names of the tables you are using

SELECT P.Name, T.Name 
FROM Pokemon AS P
JOIN PokemonType AS PT ON P.Id = PT.PokemonId
JOIN Type AS T ON T.Id = PT.TypeId;

/* JOINS

table a            table b
1                  null
2                  b
null               null
null               e


full: return all matched records, ignoring null (left, right, and center of the venn diagram)
inner: return matched records, removing all null entries (the center only)
outer: returns matched records, keeping only the entries with a null (left and right, no center)
left: returns the entire "left" table, as well as matching non-null entries from the "right" (left and center)
right: returns the entire "right" table, as well as matching non-null entires from the "left" (right and center)
cross: returns any and all combination of entries possible between two tables (all options)