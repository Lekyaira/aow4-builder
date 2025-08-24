CREATE TYPE roles AS ENUM ('guest', 'user', 'admin');

CREATE TABLE users (
	id SERIAL,
	username TEXT NOT NULL,
	password TEXT,
	role roles NOT NULL,
	PRIMARY KEY(id)
);
