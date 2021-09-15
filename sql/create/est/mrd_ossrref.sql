CREATE TABLE "mrd_ossrref" (
    "id"		serial PRIMARY KEY,				-- ИД
    "ossrgroup_id"	int REFERENCES "mrd_ossrgroup" ("id"),		-- ccылка на группу ОССР
    "code"		varchar(8) NOT NULL,				-- код вида ОССР
    "name"		varchar(512) NOT NULL				-- наименования вида ОССР
);

COMMENT ON COLUMN mrd_ossrref.ossrgroup_id IS 'ccылка на группу ОССР';
COMMENT ON COLUMN mrd_ossrref.code IS 'код вида ОССР';
COMMENT ON COLUMN mrd_ossrref.name IS 'наименования вида ОССР';

