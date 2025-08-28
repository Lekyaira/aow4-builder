BEGIN;

-- Create tables
CREATE TABLE tomes (
	id SERIAL,
	name TEXT NOT NULL,
	tier INT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE tome_aspects (
	id SERIAL,
	tome_id INT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(id),
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
	('Evocation', 'astral'),
	('Evocation', 'astral'),
	('Warding', 'astral'),
	('Warding', 'astral'),
	('Scrying', 'astral'),
	('Scrying', 'astral'),
	('Summoning', 'astral'),
	('Summoning', 'astral'),
	('Amplification', 'astral'),
	('Amplification', 'astral'),
	('Teleportation', 'astral'),
	('Teleportation', 'astral'),
	('Astral Convergence', 'astral'),
	('Astral Convergence', 'astral'),
	('The Astral Mirror', 'astral'),
	('The Astral Mirror', 'astral'),
	('The Arch Mage', 'astral'),
	('The Arch Mage', 'astral'),
-- Chaos
	('Pyromancy', 'chaos'),
	('Pyromancy', 'chaos'),
	('The Horde', 'chaos'),
	('The Horde', 'chaos'),
	('Mayhem', 'chaos'),
	('Mayhem', 'chaos'),
	('Revelry', 'chaos'),
	('Revelry', 'chaos'),
	('Devastation', 'chaos'),
	('Devastation', 'chaos'),
	('Pandemonium', 'chaos'),
	('Pandemonium', 'chaos'),
	('Chaos Channeling', 'chaos'),
	('Chaos Channeling', 'chaos'),
	('The Demon Gate', 'chaos'),
	('The Demon Gate', 'chaos'),
	('The Chaos Lord', 'chaos'),
	('The Chaos Lord', 'chaos'),
-- Materium 
	('Enchantment', 'materium'),
	('Enchantment', 'materium'),
	('Rock', 'materium'),
	('Rock', 'materium'),
	('Artificing', 'materium'),
	('Artificing', 'materium'),
	('Winds', 'materium'),
	('Winds', 'materium'),
	('The Dungeon Depths', 'materium'),
	('The Dungeon Depths', 'materium'),
	('Terramancy', 'materium'),
	('Terramancy', 'materium'),
	('Transmutation', 'materium'),
	('Transmutation', 'materium'),
	('The Crucible', 'materium'),
	('The Crucible', 'materium'),
	('The Golden Realm', 'materium'),
	('The Golden Realm', 'materium'),
	('The Creator', 'materium'),
	('The Creator', 'materium'),
-- Nature 
	('Beasts', 'nature'),
	('Beasts', 'nature'),
	('Roots', 'nature'),
	('Roots', 'nature'),
	('Fertility', 'nature'),
	('Fertility', 'nature'),
	('Glades', 'nature'),
	('Glades', 'nature'),
	('Cycles', 'nature'),
	('Cycles', 'nature'),
	('Vigor', 'nature'),
	('Vigor', 'nature'),
	('Nature''s Wrath', 'nature'),
	('Nature''s Wrath', 'nature'),
	('Paradise', 'nature'),
	('Paradise', 'nature'),
	('The Goddess of Nature', 'nature'),
	('The Goddess of Nature', 'nature'),
-- Order 
	('Faith', 'order'),
	('Faith', 'order'),
	('Zeal', 'order'),
	('Zeal', 'order'),
	('The Beacon', 'order'),
	('The Beacon', 'order'),
	('The Inquisition', 'order'),
	('The Inquisition', 'order'),
	('Virtue', 'order'),
	('Virtue', 'order'),
	('Sanctuary', 'order'),
	('Sanctuary', 'order'),
	('Subjugation', 'order'),
	('Subjugation', 'order'),
	('Exaltation', 'order'),
	('Exaltation', 'order'),
	('Supremacy', 'order'),
	('Supremacy', 'order'),
	('Archon', 'order'),
	('Archon', 'order'),
	('The God Emperor', 'order'),
	('The God Emperor', 'order'),
-- Shadow 
	('Necromancy', 'shadow'),
	('Necromancy', 'shadow'),
	('Cryomancy', 'shadow'),
	('Cryomancy', 'shadow'),
	('The Doomherald', 'shadow'),
	('The Doomherald', 'shadow'),
	('Souls', 'shadow'),
	('Souls', 'shadow'),
	('The Cold Dark', 'shadow'),
	('The Cold Dark', 'shadow'),
	('The Great Transformation', 'shadow'),
	('The Great Transformation', 'shadow'),
	('Oblivion', 'shadow'),
	('Oblivion', 'shadow'),
	('The Reaper', 'shadow'),
	('The Reaper', 'shadow'),
	('The Eternal Lord', 'shadow'),
	('The Eternal Lord', 'shadow'),
-- Hybrid
	('Evolution', 'nature'),
	('Evolution', 'chaos'),
	('Alchemy', 'nature'),
	('Alchemy', 'materium'),
	('The Tentacle', 'astral'),
	('The Tentacle', 'shadow'),
	('Discipline', 'order'),
	('Discipline', 'materium'),
	('The Construct', 'materium'),
	('The Construct', 'order'),
	('Fey Mists', 'nature'),
	('Fey Mists', 'astral'),
	('Shades', 'shadow'),
	('Shades', 'materium'),
	('Dragons', 'nature'),
	('Dragons', 'chaos'),
	('The Dreadnought', 'chaos'),
	('The Dreadnought', 'materium'),
	('The Cleansing Flame', 'chaos'),
	('The Cleansing Flame', 'order'),
	('Corruption', 'shadow'),
	('Corruption', 'astral'),
	('Geomancy', 'astral'),
	('Geomancy', 'materium'),
	('Prophecies', 'astral'),
	('Prophecies', 'order'),
	('Severing', 'shadow'),
	('Severing', 'materium'),
	('The Stormborn', 'astral'),
	('The Stormborn', 'nature'),
	('Calamity', 'chaos'),
	('Calamity', 'shadow'),
	('Prosperity', 'order'),
	('Prosperity', 'nature'),
	('The Revenant', 'shadow'),
	('The Revenant', 'order')
) AS v(tome_name, aspect)
JOIN tomes t ON t.name = v.tome_name;

-- Functions on tomes
CREATE FUNCTION tomes()
RETURNS TABLE(id INT, name TEXT, tier INT, aspects aspects[])
LANGUAGE sql 
AS $$
	SELECT 
		t.id, 
		t.name, 
		t.tier, 
		COALESCE(
			array_agg(a.aspect) FILTER (WHERE a.aspect IS NOT NULL),
			'{}'
		)::aspects[] AS aspects
		FROM tomes t
		JOIN tome_aspects a ON a.tome_id = t.id
		GROUP BY t.id, t.name, t.tier
		ORDER BY t.name;
$$;

CREATE FUNCTION tomes_by_aspect(aspect_search aspects)
RETURNS TABLE(id INT, name TEXT, tier INT, aspects aspects[])
LANGUAGE sql 
AS $$
	SELECT 
		t.id, 
		t.name, 
		t.tier, 
		COALESCE(
			array_agg(a.aspect) FILTER (WHERE a.aspect IS NOT NULL),
			'{}'
		)::aspects[] AS aspects
		FROM tomes t
		JOIN tome_aspects a ON a.tome_id = t.id
		WHERE EXISTS (
				SELECT 1
				FROM tome_aspects ta
				WHERE ta.tome_id = t.id
					AND ta.aspect = aspect_search
			)
		GROUP BY t.id, t.name, t.tier
		ORDER BY t.name;
$$;

CREATE FUNCTION tomes_by_tier(tier_search INT)
RETURNS TABLE(id INT, name TEXT, tier INT, aspects aspects[])
LANGUAGE sql 
AS $$
	SELECT 
		t.id, 
		t.name, 
		t.tier, 
		COALESCE(
			array_agg(a.aspect) FILTER (WHERE a.aspect IS NOT NULL),
			'{}'
		)::aspects[] AS aspects
		FROM tomes t
		JOIN tome_aspects a ON a.tome_id = t.id
		WHERE t.tier = tier_search 
		GROUP BY t.id, t.name, t.tier
		ORDER BY t.name;
$$;

-- Indices
CREATE INDEX idx_tome_aspects_tome_aspect
  ON tome_aspects (tome_id, aspect);

COMMIT;
