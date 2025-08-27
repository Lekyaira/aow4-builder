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
	('Barbarian', 'chaos'),
	('Barbarian', 'nature'),
	('Dark', 'shadow'),
	('Dark', 'shadow'),
	('Feudal Monarchy', 'order'),
	('Feudal Monarchy', 'materium'),
	('Feudal Aristocracy', 'order'),
	('Feudal Aristocracy', 'nature'),
	('High', 'order'),
	('High', 'order'),
	('Industrious', 'materium'),
	('Industrious', 'materium'),
	('Mystic Attunement', 'astral'),
	('Mystic Attunement', 'astral'),
	('Mystic Potential', 'astral'),
	('Mystic Potential', 'shadow'),
	('Mystic Summoning', 'astral'),
	('Mystic Summoning', 'astral'),
	('Reaver', 'chaos'),
	('Reaver', 'materium'),
	('Primal Mire Crocodile', 'nature'),
	('Primal Mire Crocodile', 'nature'),
	('Primal Storm Crow', 'nature'),
	('Primal Storm Crow', 'astral'),
	('Primal Glacial Mammoth', 'nature'),
	('Primal Glacial Mammoth', 'shadow'),
	('Primal Dune Serpent', 'nature'),
	('Primal Dune Serpent', 'materium'),
	('Primal Ash Sabertooth', 'nature'),
	('Primal Ash Sabertooth', 'chaos'),
	('Primal Tunneling Spider', 'nature'),
	('Primal Tunneling Spider', 'nature'),
	('Primal Sylvan Wolf', 'nature'),
	('Primal Sylvan Wolf', 'nature'),
	('Oathsworn Harmony', 'order'),
	('Oathsworn Harmony', 'nature'),
	('Oathsworn Righteousness', 'order'),
	('Oathsworn Righteousness', 'order'),
	('Oathsworn Strife', 'order'),
	('Oathsworn Strife', 'chaos')
) AS v(culture_name, aspect)
JOIN cultures c ON c.name = v.culture_name;

INSERT INTO culture_traits (name, aspect) VALUES
	('Chosen Uniters', 'order'),
	('Devotees of Good', 'order'),
	('Imperialists', 'order'),
	('Bannerlords', 'order'),
	('Relentless Crusaders', 'order'),
	('Vigilante Knights', 'order'),
	('Prolific Swarmers', 'chaos'),
	('Ritual Cannibals', 'chaos'),
	('Ruthless Raiders', 'chaos'),
	('Swift Marchers', 'chaos'),
	('Chosen Destroyers', 'chaos'),
	('Merciless Slavers', 'chaos'),
	('Ancient Wise Ones', 'astral'),
	('Astrological Diviners', 'astral'),
	('Gifted Casters', 'astral'),
	('Hermit Kingdom', 'astral'),
	('Mana Channelers', 'astral'),
	('Mana Addicts', 'astral'),
	('Adept Settlers', 'nature'),
	('Experienced Seafarers', 'nature'),
	('Fabled Hunters', 'nature'),
	('Druidic Terraformers', 'nature'),
	('Talented Collectors', 'nature'),
	('Equipment Hoarders', 'materium'),
	('Great Builders', 'materium'),
	('Perfectionist Artisans', 'materium'),
	('Reclaimers', 'materium'),
	('Runesmiths', 'materium'),
	('Subterranean Society', 'materium'),
	('Wonder Architects', 'materium'),
	('Devious Watchers', 'shadow'),
	('Keepers of Knowledge', 'shadow'),
	('Powerful Evokers', 'shadow'),
	('Scions of Evil', 'shadow'),
	('Umbral Disciples', 'shadow'),
	('Cult of Personality', 'shadow'),
	('Silver Tongued', 'shadow'),
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

CREATE FUNCTION cultures_with_aspects()
RETURNS TABLE(id INT, name TEXT, aspects aspects[])
LANGUAGE sql 
AS $$
	SELECT
		c.id,
		c.name,
		COALESCE(
			array_agg(ca.aspect ORDER BY ca.aspect),
			'{}'
		)::aspects[] AS aspects
	FROM cultures c
	LEFT JOIN culture_aspects ca ON ca.culture_id = c.id
	GROUP BY c.id, c.name
	ORDER BY c.name;
$$;

CREATE FUNCTION culture_traits_with_excludes()
RETURNS TABLE(id INT, name TEXT, aspect aspects, traits_excluded INT[])
LANGUAGE sql 
AS $$
	SELECT
		t.id,
		t.name,
		t.aspect,
		COALESCE(
			array_agg(e.trait_excluded) FILTER (WHERE e.trait_excluded IS NOT NULL),
			'{}'
		)::INT[] AS traits_excluded
	FROM culture_traits t
	LEFT JOIN culture_trait_excludes e ON e.trait_that_excludes = t.id
	GROUP BY t.id, t.name, t.aspect
	ORDER BY t.name;
$$;

COMMIT;
