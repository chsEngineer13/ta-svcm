-- Классификатор групп частей комплексов строек 
CREATE TABLE core.ref_constrpart_group (
    id		  serial PRIMARY KEY,		-- ИД
    code_range    varchar(32),			-- диапазон кодов
    name	  varchar(512) NOT NULL		-- наименование группы частей комплексов строек
);

COMMENT ON TABLE core.ref_constrpart_group IS 'Классификатор групп частей комплексов строек';

COMMENT ON COLUMN core.ref_constrpart_group.id IS 'Идентификатор';
COMMENT ON COLUMN core.ref_constrpart_group.code_range IS 'Диапазон кодов';
COMMENT ON COLUMN core.ref_constrpart_group.name IS 'Наименование';

INSERT INTO sys.acl_function(name, descr) VALUES 
     ('core.RefConstrPartGroups.c', 'Создание классификатора групп частей комплексов строек'),
     ('core.RefConstrPartGroups.r', 'Чтение классификаторов групп частей комплексов строек'),
     ('core.RefConstrPartGroups.u', 'Изменение классификатора групп частей комплексов строек'),
     ('core.RefConstrPartGroups.d', 'Удаление классификатора групп частей комплексов строек'),
     ('core.RefConstrPartGroups.l', 'Создание/удаление записи в связанной таблице');

