CREATE TABLE "mrd_object" (
    "id"		serial PRIMARY KEY,
    "parent_id" 	int,
    "construction_id" 	smallint NOT NULL REFERENCES core.construction ("id"),
    "type_id"		int,
    "type" 		char(1) NOT NULL REFERENCES "mrd_objecttype" ("id"),
    "code" 		varchar(32),
    "number" 		varchar(32),
    "descr" 		varchar(8192)
);

