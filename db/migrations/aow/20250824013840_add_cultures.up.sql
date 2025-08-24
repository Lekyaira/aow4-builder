BEGIN;

CREATE TABLE cultures (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE culture_aspects (
	culture_id INT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(culture_id, aspect),
	FOREIGN KEY(culture_id) REFERENCES cultures(id) ON DELETE RESTRICT
);

CREATE TABLE culture_traits (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

COMMIT;
