CREATE TABLE "mrd_oksgroup" (
    "id"		serial PRIMARY KEY,		-- ИД
    "code_range"	varchar(32),			-- диапазон кодов
    "name"		varchar(512) NOT NULL		-- наименование группы ОКС
);

COMMENT ON COLUMN mrd_oksgroup.code_range IS 'диапазон кодов';
COMMENT ON COLUMN mrd_oksgroup.name IS 'наименование группы ОКС';

