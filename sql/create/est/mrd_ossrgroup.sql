CREATE TABLE "mrd_ossrgroup" (
    "id"		serial PRIMARY KEY,				-- ИД
    "code_range"	varchar(32),					-- диапазон кодов
    "name"		varchar(512) NOT NULL				-- наименование группы ОКС
);

COMMENT ON COLUMN mrd_ossrgroup.code_range IS 'диапазон кодов';
COMMENT ON COLUMN mrd_ossrgroup.name IS 'наименование группы ОКС';

