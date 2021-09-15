-- Мониторинг выпуска комплектов
CREATE TABLE core.docset_mon (
    id             bigserial PRIMARY KEY,
    docset_id      bigint NOT NULL REFERENCES core.docset(id),
    mondate        date NOT NULL,
    monpercent     smallint DEFAULT 0 NOT NULL,
    description    varchar(1024),
    created        timestamp WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT docset_mon_percent_chk CHECK (((monpercent >= 0) AND (monpercent <= 100)))
);

CREATE INDEX docset_mon_idx ON core.docset_mon USING btree (docset_id, mondate, created DESC);

COMMENT ON TABLE core.docset_mon IS 'Мониторинг выпуска комплектов';

COMMENT ON COLUMN core.docset_mon.id IS 'Идентификатор';
COMMENT ON COLUMN core.docset_mon.docset_id IS 'Ссылка на комплект документации';
COMMENT ON COLUMN core.docset_mon.mondate IS 'Дата мониторинга разработки комплекта';
COMMENT ON COLUMN core.docset_mon.monpercent IS '% разработки комплекта';
COMMENT ON COLUMN core.docset_mon.description IS 'Комментарии/описание';
COMMENT ON COLUMN core.docset_mon.created IS 'Дата создания записи';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('core.DocsetMons.c', 'Создание записи в мониторинге выпуска комплектов'),
    ('core.DocsetMons.r', 'Чтение записей мониторинга выпуска комплектов'),
    ('core.DocsetMons.u', 'Изменение записи мониторинга выпуска комплектов'),
    ('core.DocsetMons.d', 'Удаление записи мониторинга выпуска комплектов');

