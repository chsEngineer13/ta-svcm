-- Документ в составе составного документа (Document)
CREATE TABLE core.document (
  id BIGSERIAL PRIMARY KEY,
  docset_id BIGINT REFERENCES core.docset(id),
  cipher VARCHAR(128),
  doccode_id INTEGER REFERENCES core.ref_doccode(id),
  name TEXT,
  developer_dep VARCHAR(16),
  izm_num INTEGER,
  status VARCHAR(64),
  is_actual BOOLEAN DEFAULT TRUE NOT NULL
);

COMMENT ON TABLE core.document IS 'Документ в составе составного документа (Document)';

COMMENT ON COLUMN core.document.id IS 'Идентификатор';
COMMENT ON COLUMN core.document.docset_id IS '-> core.docset';
COMMENT ON COLUMN core.document.cipher IS 'Обозначение документа в соответствии с Регламентом Р-08';
COMMENT ON COLUMN core.document.doccode_id IS '-> core.ref_doccode';
COMMENT ON COLUMN core.document.name IS 'Наименование с титульного листа';
COMMENT ON COLUMN core.document.developer_dep IS 'Код подразделения-исполнителя внутри филиала';
COMMENT ON COLUMN core.document.izm_num IS 'Номер изменения';
COMMENT ON COLUMN core.document.status IS 'Статус документа в исторической системе';
COMMENT ON COLUMN core.document.is_actual IS 'Признак актуальности документа';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.Documents.c', 'Создание документа')
    ,('core.Documents.r', 'Чтение документов')
    ,('core.Documents.u', 'Изменение документа')
    ,('core.Documents.d', 'Удаление документа')
    ,('core.Documents.l', 'Создание/удаление записи в связанной таблице')
;

