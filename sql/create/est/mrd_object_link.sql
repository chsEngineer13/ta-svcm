CREATE TABLE "mrd_object_link" (
    "id"		serial PRIMARY KEY,
    "cobject_id"		bigint NOT NULL REFERENCES core.cobject ("id"),
    "mrd_object_id"	int NOT NULL REFERENCES "mrd_object" ("id")
);

