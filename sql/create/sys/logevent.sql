-- Аудит действий пользователя
CREATE TABLE sys.logevent (
  id BIGSERIAL PRIMARY KEY,
  account_id INTEGER NOT NULL REFERENCES sys.acl_account(id),
  eventtype_id INTEGER NOT NULL REFERENCES sys.ref_logeventtype(id),
  eventtime TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
  schema_name VARCHAR(25),
  operation_name VARCHAR(250) NOT NULL,
  operation_pk_id BIGINT,
  operation_pk_time TIMESTAMP WITH TIME ZONE,
  details JSON,
  descr core.d_description
);

COMMENT ON TABLE sys.logevent IS 'Аудит действий пользователя';

COMMENT ON COLUMN sys.logevent.id IS 'Идентификатор';
COMMENT ON COLUMN sys.logevent.account_id IS '-> acl_account';
COMMENT ON COLUMN sys.logevent.eventtype_id IS '-> ref_logeventtype';
COMMENT ON COLUMN sys.logevent.eventtime IS 'Дата и время события';
COMMENT ON COLUMN sys.logevent.schema_name IS 'Имя схемы БД для операции';
COMMENT ON COLUMN sys.logevent.operation_name IS 'Имя операции - логируемая таблица/отчет/функция и т.д.';
COMMENT ON COLUMN sys.logevent.operation_pk_id IS 'Id первичного ключа логируемой таблицы';
COMMENT ON COLUMN sys.logevent.operation_pk_time IS 'Дата и время первичного ключа логируемой таблицы';
COMMENT ON COLUMN sys.logevent.details IS 'Детализация данных операции';
COMMENT ON COLUMN sys.logevent.descr IS 'Описание';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('sys.LogEvents.r', 'Чтение записей аудита');

