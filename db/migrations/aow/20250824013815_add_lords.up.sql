BEGIN;

-- Create tables
CREATE TABLE lord_types (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE lord_subtypes (
	lord_type INT NOT NULL,
	name TEXT NOT NULL,
	PRIMARY KEY(lord_type, name),
	FOREIGN KEY(lord_type) REFERENCES lord_types(id) ON DELETE RESTRICT
);

CREATE TABLE lord_subtype_aspects (
	lord_type INT NOT NULL,
	lord_subtype TEXT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(lord_subtype, aspect),
	FOREIGN KEY(lord_type, lord_subtype) REFERENCES lord_subtypes(lord_type, name) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Insert data
INSERT INTO lord_types (name) VALUES 
('Mortal Champion'),
('Wizard King'),
('Dragon Lord'),
('Eldritch Sovereign'),
('Giant King');

INSERT INTO lord_subtypes (lord_type, name)
SELECT t.id, v.name
FROM (VALUES
  ('Dragon Lord', 'Astral Dragon'),
  ('Dragon Lord', 'Chaos Dragon'),
  ('Dragon Lord', 'Materium Dragon'),
  ('Dragon Lord', 'Nature Dragon'),
  ('Dragon Lord', 'Order Dragon'),
  ('Dragon Lord', 'Shadow Dragon')
) AS v(lord_type, name)
JOIN lord_types t ON t.name = v.lord_type
ON CONFLICT (lord_type, name) DO NOTHING;

INSERT INTO lord_subtype_aspects (lord_type, lord_subtype, aspect)
SELECT s.lord_type, s.name, v.aspect::aspects
FROM (VALUES
	('Astral Dragon', 'Astral'),
	('Chaos Dragon', 'Chaos'),
	('Materium Dragon', 'Materium'),
	('Nature Dragon', 'Nature'),
	('Order Dragon', 'Order'),
	('Shadow Dragon', 'Shadow')
) AS v(lord_subtype, aspect)
JOIN lord_subtypes s ON s.name = v.lord_subtype
ON CONFLICT (lord_subtype, aspect) DO NOTHING;

COMMIT;
