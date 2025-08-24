BEGIN;

CREATE TABLE species_traits (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

COMMIT;
