-- Типы событий для аудита
CREATE TABLE sys.ref_logeventtype (
  id SERIAL PRIMARY KEY,
  name VARCHAR(10) NOT NULL UNIQUE,
  descr core.d_description
);

COMMENT ON TABLE sys.ref_logeventtype IS 'Типы событий для аудита';

COMMENT ON COLUMN sys.ref_logeventtype.id IS 'Идентификатор';
COMMENT ON COLUMN sys.ref_logeventtype.name IS 'Наименование действия';
COMMENT ON COLUMN sys.ref_logeventtype.descr IS 'Описание';

INSERT INTO sys.ref_logeventtype(name, descr) VALUES
    ('c', 'Создание')
    ,('r', 'Чтение')
    ,('u', 'Изменение')
    ,('d', 'Удаление')
    ,('p', 'Генерация отчета')
    ,('e', 'Запуск процедуры')
    ,('a', 'Аутентификация пользователя')
    ,('h', 'Проверка прав доступа')
    ,('l', 'Создание связи для таблиц')
;

