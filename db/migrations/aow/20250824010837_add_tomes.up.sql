BEGIN;

CREATE TABLE tomes (
	id SERIAL,
	name TEXT NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE tome_aspects (
	tome_id INT NOT NULL,
	aspect aspects NOT NULL,
	PRIMARY KEY(tome_id, aspect),
	FOREIGN KEY(tome_id) REFERENCES tomes(id) ON DELETE RESTRICT
);

COMMIT;
