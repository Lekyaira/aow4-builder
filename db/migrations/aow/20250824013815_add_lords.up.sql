BEGIN;

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

COMMIT;
