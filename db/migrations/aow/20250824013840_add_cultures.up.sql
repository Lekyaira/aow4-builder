BEGIN;

-- Create tables
CREATE TABLE cultures (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE culture_aspects (
	id SERIAL,
	culture_id INT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(culture_id) REFERENCES cultures(id) ON DELETE RESTRICT
);

CREATE TABLE culture_traits (
	id SERIAL,
	name TEXT NOT NULL,
	aspect aspects,
	PRIMARY KEY(id)
);

CREATE TABLE culture_trait_excludes (
	trait_that_excludes INT NOT NULL,
	trait_excluded INT NOT NULL,
	PRIMARY KEY(trait_that_excludes, trait_excluded),
	FOREIGN KEY(trait_that_excludes) REFERENCES culture_traits(id) ON DELETE RESTRICT,
	FOREIGN KEY(trait_excluded) REFERENCES culture_traits(id) ON DELETE RESTRICT
);

-- Insert data
INSERT INTO cultures (name) VALUES
	('Barbarian'),
	('Dark'),
	('Feudal Monarchy'),
	('Feudal Aristocracy'),
	('High'),
	('Industrious'),
	('Mystic Attunement'),
	('Mystic Potential'),
	('Mystic Summoning'),
	('Reaver'),
	('Primal Mire Crocodile'),
	('Primal Storm Crow'),
	('Primal Glacial Mammoth'),
	('Primal Dune Serpent'),
	('Primal Ash Sabertooth'),
	('Primal Tunneling Spider'),
	('Primal Sylvan Wolf'),
	('Oathsworn Harmony'),
	('Oathsworn Righteousness'),
	('Oathsworn Strife');

INSERT INTO culture_aspects (culture_id, aspect)
SELECT c.id, v.aspect::aspects
FROM (VALUES
	('Barbarian', 'Chaos'),
	('Barbarian', 'Nature'),
	('Dark', 'Shadow'),
	('Dark', 'Shadow'),
	('Feudal Monarchy', 'Order'),
	('Feudal Monarchy', 'Materium'),
	('Feudal Aristocracy', 'Order'),
	('Feudal Aristocracy', 'Nature'),
	('High', 'Order'),
	('High', 'Order'),
	('Industrious', 'Materium'),
	('Industrious', 'Materium'),
	('Mystic Attunement', 'Astral'),
	('Mystic Attunement', 'Astral'),
	('Mystic Potential', 'Astral'),
	('Mystic Potential', 'Shadow'),
	('Mystic Summoning', 'Astral'),
	('Mystic Summoning', 'Astral'),
	('Reaver', 'Chaos'),
	('Reaver', 'Materium'),
	('Primal Mire Crocodile', 'Nature'),
	('Primal Mire Crocodile', 'Nature'),
	('Primal Storm Crow', 'Nature'),
	('Primal Storm Crow', 'Astral'),
	('Primal Glacial Mammoth', 'Nature'),
	('Primal Glacial Mammoth', 'Shadow'),
	('Primal Dune Serpent', 'Nature'),
	('Primal Dune Serpent', 'Materium'),
	('Primal Ash Sabertooth', 'Nature'),
	('Primal Ash Sabertooth', 'Chaos'),
	('Primal Tunneling Spider', 'Nature'),
	('Primal Tunneling Spider', 'Nature'),
	('Primal Sylvan Wolf', 'Nature'),
	('Primal Sylvan Wolf', 'Nature'),
	('Oathsworn Harmony', 'Order'),
	('Oathsworn Harmony', 'Nature'),
	('Oathsworn Righteousness', 'Order'),
	('Oathsworn Righteousness', 'Order'),
	('Oathsworn Strife', 'Order'),
	('Oathsworn Strife', 'Chaos')
) AS v(culture_name, aspect)
JOIN cultures c ON c.name = v.culture_name;

INSERT INTO culture_traits (name, aspect) VALUES
	('Chosen Uniters', 'Order'),
	('Devotees of Good', 'Order'),
	('Imperialists', 'Order'),
	('Bannerlords', 'Order'),
	('Relentless Crusaders', 'Order'),
	('Vigilante Knights', 'Order'),
	('Prolific Swarmers', 'Chaos'),
	('Ritual Cannibals', 'Chaos'),
	('Ruthless Raiders', 'Chaos'),
	('Swift Marchers', 'Chaos'),
	('Chosen Destroyers', 'Chaos'),
	('Merciless Slavers', 'Chaos'),
	('Ancient Wise Ones', 'Astral'),
	('Astrological Diviners', 'Astral'),
	('Gifted Casters', 'Astral'),
	('Hermit Kingdom', 'Astral'),
	('Mana Channelers', 'Astral'),
	('Mana Addicts', 'Astral'),
	('Adept Settlers', 'Nature'),
	('Experienced Seafarers', 'Nature'),
	('Fabled Hunters', 'Nature'),
	('Druidic Terraformers', 'Nature'),
	('Talented Collectors', 'Nature'),
	('Equipment Hoarders', 'Materium'),
	('Great Builders', 'Materium'),
	('Perfectionist Artisans', 'Materium'),
	('Reclaimers', 'Materium'),
	('Runesmiths', 'Materium'),
	('Subterranean Society', 'Materium'),
	('Wonder Architects', 'Materium'),
	('Devious Watchers', 'Shadow'),
	('Keepers of Knowledge', 'Shadow'),
	('Powerful Evokers', 'Shadow'),
	('Scions of Evil', 'Shadow'),
	('Umbral Disciples', 'Shadow'),
	('Cult of Personality', 'Shadow'),
	('Silver Tongued', 'Shadow'),
	('Vision of Destiny', NULL),
	('Vision of Promise', NULL),
	('Vision of Ruin', NULL);

INSERT INTO culture_trait_excludes (trait_that_excludes, trait_excluded) 
SELECT t.id, e.id
FROM (VALUES
	('Chosen Uniters', 'Chosen Destroyers'),
	('Chosen Uniters', 'Scions of Evil'),
	('Devotees of Good', 'Ritual Cannibals'),
	('Devotees of Good', 'Ruthless Raiders'),
	('Devotees of Good', 'Chosen Destroyers'),
	('Devotees of Good', 'Merciless Slavers'),
	('Devotees of Good', 'Scions of Evil'),
	('Devotees of Good', 'Umbral Disciples'),
	('Imperialists', 'Adept Settlers'),
	('Bannerlords', 'Chosen Destroyers'),
	('Relentless Crusaders', 'Scions of Evil'),
	('Ritual Cannibals', 'Devotees of Good'),
	('Ruthless Raiders', 'Devotees of Good'),
	('Chosen Destroyers', 'Chosen Uniters'),
	('Chosen Destroyers', 'Devotees of Good'),
	('Chosen Destroyers', 'Imperialists'),
	('Chosen Destroyers', 'Bannerlords'),
	('Chosen Destroyers', 'Relentless Crusaders'),
	('Chosen Destroyers', 'Adept Settlers'),
	('Chosen Destroyers', 'Keepers of Knowledge'),
	('Chosen Destroyers', 'Silver Tongued'),
	('Merciless Slavers', 'Devotees of Good'),
	('Gifted Casters', 'Ancient Wise Ones'),
	('Gifted Casters', 'Devious Watchers'),
	('Adept Settlers', 'Imperialists'),
	('Adept Settlers', 'Chosen Destroyers'),
	('Keepers of Knowledge', 'Chosen Destroyers'),
	('Keepers of Knowledge', 'Scions of Evil'),
	('Scions of Evil', 'Chosen Uniters'),
	('Scions of Evil', 'Devotees of Good'),
	('Scions of Evil', 'Relentless Crusaders'),
	('Scions of Evil', 'Keepers of Knowledge'),
	('Umbral Disciples', 'Devotees of Good'),
	('Silver Tongued', 'Chosen Destroyers'),
	('Vision of Destiny', 'Vision of Promise'),
	('Vision of Destiny', 'Vision of Ruin'),
	('Vision of Promise', 'Vision of Destiny'),
	('Vision of Promise', 'Vision of Ruin'),
	('Vision of Ruin', 'Vision of Destiny'),
	('Vision of Ruin', 'Vision of Promise')
) AS v(excludes_name, excluded_name)
JOIN culture_traits t ON t.name = v.excludes_name
JOIN culture_traits e ON e.name = v.excluded_name
ON CONFLICT (trait_that_excludes, trait_excluded) DO NOTHING;

COMMIT;
