-- Элемент "Файл документа" (может входить в состав <Document> или <Invoice>)
CREATE TABLE core.mfile (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  parent_object_type VARCHAR(64),
  parent_object_id BIGINT,
  name VARCHAR(256) NOT NULL,
  size BIGINT,
  modify_time TIMESTAMP WITH TIME ZONE,
  filetype_id INTEGER DEFAULT 0 NOT NULL
);

COMMENT ON TABLE core.mfile IS 'Элемент "Файл документа" (может входить в состав <Document> или <Invoice>)';

COMMENT ON COLUMN core.mfile.id IS 'Идентификатор';
COMMENT ON COLUMN core.mfile.parent_object_type IS 'Тип объекта, которому принадлежит файл';
COMMENT ON COLUMN core.mfile.parent_object_id IS '-> core.document | core.invoice';
COMMENT ON COLUMN core.mfile.name IS 'Имя файла без пути';
COMMENT ON COLUMN core.mfile.size IS 'Размер файла в байтах';
COMMENT ON COLUMN core.mfile.modify_time IS 'Дата/время последней модификации файла';
COMMENT ON COLUMN core.mfile.filetype_id IS 'Тип файла: 0-UNKNOWN, 1-Скан с подписями, 2-Файл в редактируемом формате, (>=3)-Зарезервировано';

INSERT INTO sys.acl_function(name, descr) VALUES
     ('core.MFiles.c', 'Создание метаданных файла'),
     ('core.MFiles.r', 'Чтение метаданных файла'),
     ('core.MFiles.u', 'Изменение метаданных файла'),
     ('core.MFiles.d', 'Удаление метаданных файла'),
     ('core.MFiles.l', 'Создание/удаление записи в связанной таблице')
;
