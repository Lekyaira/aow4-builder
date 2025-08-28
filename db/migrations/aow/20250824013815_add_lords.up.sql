BEGIN;

-- Create tables
CREATE TABLE ruler_types (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE ruler_type_aspects (
	ruler_type INT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(ruler_type, aspect),
	FOREIGN KEY(ruler_type) REFERENCES ruler_types(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert data
INSERT INTO ruler_types (name) VALUES 
('Mortal Champion'),
('Wizard King'),
('Astral Dragon Lord'),
('Chaos Dragon Lord'),
('Materium Dragon Lord'),
('Nature Dragon Lord'),
('Order Dragon Lord'),
('Shadow Dragon Lord'),
('Eldritch Sovereign'),
('Giant King');

INSERT INTO ruler_type_aspects (ruler_type, aspect)
SELECT t.id, v.aspect::aspects
FROM (VALUES
	('Astral Dragon Lord', 'astral'),
	('Chaos Dragon Lord', 'chaos'),
	('Materium Dragon Lord', 'materium'),
	('Nature Dragon Lord', 'nature'),
	('Order Dragon Lord', 'order'),
	('Shadow Dragon Lord', 'shadow')
) AS v(ruler_type, aspect)
JOIN ruler_types t ON t.name = v.ruler_type
ON CONFLICT (ruler_type, aspect) DO NOTHING;

-- Functions
CREATE FUNCTION ruler_types()
RETURNS TABLE(id INT, name TEXT, aspects aspects[])
LANGUAGE sql 
AS $$
	SELECT
		r.id,
		r.name,
		COALESCE(
			array_agg(a.aspect ORDER BY a.aspect) FILTER (WHERE a.aspect IS NOT NULL),
			'{}'
		)::aspects[] AS aspects
	FROM ruler_types r
	LEFT JOIN ruler_type_aspects a ON a.ruler_type = r.id
	GROUP BY r.id, r.name
	ORDER BY 
		CASE
			WHEN name ILIKE '%mortal%' OR name ILIKE '%wizard%' THEN 1
			WHEN name ILIKE '%dragon lord%' THEN 2
			ELSE 3
		END,
		name;
$$;

COMMIT;
