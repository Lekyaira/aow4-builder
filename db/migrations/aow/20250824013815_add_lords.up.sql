BEGIN;

-- Create tables
CREATE TABLE lord_types (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE lord_type_aspects (
	lord_type INT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(lord_type, aspect),
	FOREIGN KEY(lord_type) REFERENCES lord_types(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert data
INSERT INTO lord_types (name) VALUES 
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

INSERT INTO lord_type_aspects (lord_type, aspect)
SELECT s.id, v.aspect::aspects
FROM (VALUES
	('Astral Dragon Lord', 'astral'),
	('Chaos Dragon Lord', 'chaos'),
	('Materium Dragon Lord', 'materium'),
	('Nature Dragon Lord', 'nature'),
	('Order Dragon Lord', 'order'),
	('Shadow Dragon Lord', 'shadow')
) AS v(lord_type, aspect)
JOIN lord_types s ON s.name = v.lord_type
ON CONFLICT (lord_type, aspect) DO NOTHING;

-- Functions
CREATE FUNCTION lord_types_with_aspects()
RETURNS TABLE(id INT, name TEXT, aspects aspects[])
LANGUAGE sql 
AS $$
	SELECT
		l.id,
		l.name,
		COALESCE(
			array_agg(a.aspect ORDER BY a.aspect) FILTER (WHERE a.aspect IS NOT NULL),
			'{}'
		)::aspects[] AS aspects
	FROM lord_types l
	LEFT JOIN lord_type_aspects a ON a.lord_type = l.id
	GROUP BY l.id, l.name
	ORDER BY 
		CASE
			WHEN name ILIKE '%mortal%' OR name ILIKE '%wizard%' THEN 1
			WHEN name ILIKE '%dragon lord%' THEN 2
			ELSE 3
		END,
		name;
$$;

COMMIT;
