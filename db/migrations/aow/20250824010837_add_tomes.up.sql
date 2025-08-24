BEGIN;

-- Create tables
CREATE TABLE tomes (
	id SERIAL,
	name TEXT NOT NULL,
	tier INT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE tome_aspects (
	tome_id INT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(tome_id, aspect),
	FOREIGN KEY(tome_id) REFERENCES tomes(id) ON DELETE RESTRICT
);

-- Insert data
INSERT INTO tomes (name, tier) VALUES 
-- Astral
	('Evocation', 1),
	('Warding', 1),
	('Scrying', 2),
	('Summoning', 2),
	('Amplification', 3),
	('Teleportation', 3),
	('Astral Convergence', 4),
	('The Astral Mirror', 4),
	('The Arch Mage', 5),
-- Chaos
	('Pyromancy', 1),
	('The Horde', 1),
	('Mayhem', 2),
	('Revelry', 2),
	('Devastation', 3),
	('Pandemonium', 3),
	('Chaos Channeling', 4),
	('The Demon Gate', 4),
	('The Chaos Lord', 5),
-- Materium 
	('Enchantment', 1),
	('Rock', 1),
	('Artificing', 2),
	('Winds', 2),
	('The Dungeon Depths', 2),
	('Terramancy', 3),
	('Transmutation', 3),
	('The Crucible', 4),
	('The Golden Realm', 4),
	('The Creator', 5),
-- Nature 
	('Beasts', 1),
	('Roots', 1),
	('Fertility', 2),
	('Glades', 2),
	('Cycles', 3),
	('Vigor', 3),
	('Nature''s Wrath', 4),
	('Paradise', 4),
	('The Goddess of Nature', 5),
-- Order 
	('Faith', 1),
	('Zeal', 1),
	('The Beacon', 2),
	('The Inquisition', 2),
	('Virtue', 2),
	('Sanctuary', 3),
	('Subjugation', 3),
	('Exaltation', 4),
	('Supremacy', 4),
	('Archon', 4),
	('The God Emperor', 5),
-- Shadow 
	('Necromancy', 1),
	('Cryomancy', 1),
	('The Doomherald', 2),
	('Souls', 2),
	('The Cold Dark', 3),
	('The Great Transformation', 3),
	('Oblivion', 4),
	('The Reaper', 4),
	('The Eternal Lord', 5),
-- Hybrid
	('Evolution', 1),
	('Alchemy', 1),
	('The Tentacle', 1),
	('Discipline', 1),
	('The Construct', 2),
	('Fey Mists', 2),
	('Shades', 2),
	('Dragons', 3),
	('The Dreadnought', 3),
	('The Cleansing Flame', 3),
	('Corruption', 3),
	('Geomancy', 3),
	('Prophecies', 3),
	('Severing', 4),
	('The Stormborn', 4),
	('Calamity', 4),
	('Prosperity', 4),
	('The Revenant', 4);

INSERT INTO tome_aspects (tome_id, aspect)
SELECT t.id, v.aspect::aspects
FROM (VALUES
-- Astral
	('Evocation', 'Astral'),
	('Warding', 'Astral'),
	('Scrying', 'Astral'),
	('Summoning', 'Astral'),
	('Amplification', 'Astral'),
	('Teleportation', 'Astral'),
	('Astral Convergence', 'Astral'),
	('The Astral Mirror', 'Astral'),
	('The Arch Mage', 'Astral'),
-- Chaos
	('Pyromancy', 'Chaos'),
	('The Horde', 'Chaos'),
	('Mayhem', 'Chaos'),
	('Revelry', 'Chaos'),
	('Devastation', 'Chaos'),
	('Pandemonium', 'Chaos'),
	('Chaos Channeling', 'Chaos'),
	('The Demon Gate', 'Chaos'),
	('The Chaos Lord', 'Chaos'),
-- Materium 
	('Enchantment', 'Materium'),
	('Rock', 'Materium'),
	('Artificing', 'Materium'),
	('Winds', 'Materium'),
	('The Dungeon Depths', 'Materium'),
	('Terramancy', 'Materium'),
	('Transmutation', 'Materium'),
	('The Crucible', 'Materium'),
	('The Golden Realm', 'Materium'),
	('The Creator', 'Materium'),
-- Nature 
	('Beasts', 'Nature'),
	('Roots', 'Nature'),
	('Fertility', 'Nature'),
	('Glades', 'Nature'),
	('Cycles', 'Nature'),
	('Vigor', 'Nature'),
	('Nature''s Wrath', 'Nature'),
	('Paradise', 'Nature'),
	('The Goddess of Nature', 'Nature'),
-- Order 
	('Faith', 'Order'),
	('Zeal', 'Order'),
	('The Beacon', 'Order'),
	('The Inquisition', 'Order'),
	('Virtue', 'Order'),
	('Sanctuary', 'Order'),
	('Subjugation', 'Order'),
	('Exaltation', 'Order'),
	('Supremacy', 'Order'),
	('Archon', 'Order'),
	('The God Emperor', 'Order'),
-- Shadow 
	('Necromancy', 'Shadow'),
	('Cryomancy', 'Shadow'),
	('The Doomherald', 'Shadow'),
	('Souls', 'Shadow'),
	('The Cold Dark', 'Shadow'),
	('The Great Transformation', 'Shadow'),
	('Oblivion', 'Shadow'),
	('The Reaper', 'Shadow'),
	('The Eternal Lord', 'Shadow'),
-- Hybrid
	('Evolution', 'Nature'),
	('Evolution', 'Chaos'),
	('Alchemy', 'Nature'),
	('Alchemy', 'Materium'),
	('The Tentacle', 'Astral'),
	('The Tentacle', 'Shadow'),
	('Discipline', 'Order'),
	('Discipline', 'Materium'),
	('The Construct', 'Materium'),
	('The Construct', 'Order'),
	('Fey Mists', 'Nature'),
	('Fey Mists', 'Astral'),
	('Shades', 'Shadow'),
	('Shades', 'Materium'),
	('Dragons', 'Nature'),
	('Dragons', 'Chaos'),
	('The Dreadnought', 'Chaos'),
	('The Dreadnought', 'Materium'),
	('The Cleansing Flame', 'Chaos'),
	('The Cleansing Flame', 'Order'),
	('Corruption', 'Shadow'),
	('Corruption', 'Astral'),
	('Geomancy', 'Astral'),
	('Geomancy', 'Materium'),
	('Prophecies', 'Astral'),
	('Prophecies', 'Order'),
	('Severing', 'Shadow'),
	('Severing', 'Materium'),
	('The Stormborn', 'Astral'),
	('The Stormborn', 'Nature'),
	('Calamity', 'Chaos'),
	('Calamity', 'Shadow'),
	('Prosperity', 'Order'),
	('Prosperity', 'Nature'),
	('The Revenant', 'Shadow'),
	('The Revenant', 'Order')
) AS v(tome_name, aspect)
JOIN tomes t ON t.name = v.tome_name
ON CONFLICT (tome_id, aspect) DO NOTHING;

-- Functions on tomes
CREATE FUNCTION tomes_with_aspects()
RETURNS TABLE(id INT, name TEXT, tier INT, aspect aspects)
LANGUAGE sql 
AS $$
	SELECT tomes.id, tomes.name, tomes.tier, tome_aspects.aspect FROM tomes, tome_aspects WHERE tome_aspects.tome_id = tomes.id;
$$;

CREATE FUNCTION tomes_by_aspect(aspect_search aspects)
RETURNS TABLE(id INT, name TEXT, tier INT)
LANGUAGE sql 
AS $$
	SELECT tomes.id, tomes.name, tomes.tier FROM tomes, tome_aspects WHERE tome_aspects.tome_id = tomes.id AND tome_aspects.aspect = aspect_search;
$$;

COMMIT;
