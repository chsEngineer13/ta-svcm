CREATE TABLE "mrd_oksref" (
    "id"		serial PRIMARY KEY,				-- ИД
    "oksgroup_id"	int REFERENCES "mrd_oksgroup" ("id"),		-- ссылка на группу ОКС
    "code"		varchar(8) NOT NULL,				-- код вида ОКС
    "name"		varchar(512) NOT NULL				-- наименования вида ОКС
);

COMMENT ON COLUMN mrd_oksref.oksgroup_id IS 'ссылка на группу ОКС';
COMMENT ON COLUMN mrd_oksref.code IS 'код вида ОКС';
COMMENT ON COLUMN mrd_oksref.name IS 'наименования вида ОКС';

