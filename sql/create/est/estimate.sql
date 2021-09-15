-- Сметы
CREATE TABLE estimate (
    id                  BIGSERIAL PRIMARY KEY,
    checksum 		BIGINT,
    machine_id          VARCHAR(32),
    developer_id        INT REFERENCES core.ref_developer (id),
    origin_key          VARCHAR(128),
    cobject_id          BIGINT REFERENCES core.cobject (id),
    contract_id         INT REFERENCES core.contract (id),
    phase_id		SMALLINT REFERENCES core.ref_phase (id),
    title		VARCHAR(2048),
    type_id		SMALLINT REFERENCES estimate_type (id),
    parent_id           bigint REFERENCES estimate (id),
    chapter_num	        SMALLINT,
    line_num            SMALLINT,
    subline1_num        SMALLINT,
    subline2_num        SMALLINT,
    subline3_num        SMALLINT,
    subline4_num        SMALLINT,
    subline5_num        SMALLINT,
    local_num	        SMALLINT,
    phase_id_num        SMALLINT REFERENCES core.ref_phase (id),
    changeset_num	SMALLINT,
    addenda_num         SMALLINT,
    source_num          VARCHAR(32),
    is_annulled         BOOLEAN DEFAULT false NOT NULL,
    replaces_id         BIGINT REFERENCES estimate (id),
    volume_value        DECIMAL(15,2),
    volume_measure      VARCHAR(64),
    cost_code_id        INT REFERENCES cost_kind (id),
    construction_cost   DECIMAL(15,2),
    installation_cost   DECIMAL(15,2),
    equipment_cost      DECIMAL(15,2),
    material_cost       DECIMAL(15,2),
    other_cost          DECIMAL(15,2),
    total_cost	        DECIMAL(15,2),
    comments            TEXT,
    price_at            DATE,
    approval_date       DATE,
    state_at            DATE NOT NULL,
    basis               VARCHAR(2048),
    book_cipher         VARCHAR(256),
    load_date           TIMESTAMP NOT NULL,
    tm_from             TIMESTAMP,
    tm_to               TIMESTAMP
);

COMMENT ON TABLE estimate IS 'Сметы';

COMMENT ON COLUMN estimate.id IS 'Идентификатор';
COMMENT ON COLUMN estimate.checksum IS 'Идентификатор источника (число)';
COMMENT ON COLUMN estimate.machine_id IS 'Машинный номер сметы';
COMMENT ON COLUMN estimate.developer_id IS 'Разработчик (филиал)';
COMMENT ON COLUMN estimate.origin_key IS 'Идентификатор сметы разработчика';
COMMENT ON COLUMN estimate.cobject_id IS 'Объект проектирования (стройка)';
COMMENT ON COLUMN estimate.contract_id IS 'Проект (договор)';
COMMENT ON COLUMN estimate.phase_id IS 'Стадия проектирования';
COMMENT ON COLUMN estimate.title IS 'Заголовок сметы (наименование работ и затрат...)';
COMMENT ON COLUMN estimate.type_id IS 'Тип сметы: объектная, локальная...';
COMMENT ON COLUMN estimate.parent_id IS 'Cсылка на объектную смету';
COMMENT ON COLUMN estimate.chapter_num IS 'Номер главы';
COMMENT ON COLUMN estimate.line_num IS 'Номер объектной сметы';
COMMENT ON COLUMN estimate.subline1_num IS 'Номер подобъектной сметы 1';
COMMENT ON COLUMN estimate.subline2_num IS 'Номер подобъектной сметы 2';
COMMENT ON COLUMN estimate.subline3_num IS 'Номер подобъектной сметы 3';
COMMENT ON COLUMN estimate.subline4_num IS 'Номер подобъектной сметы 4';
COMMENT ON COLUMN estimate.subline5_num IS 'Номер подобъектной сметы 5';
COMMENT ON COLUMN estimate.local_num IS 'Номер локальной сметы';
COMMENT ON COLUMN estimate.phase_id_num IS 'Стадия проектирования в номере сметы';
COMMENT ON COLUMN estimate.changeset_num IS 'Номер изменения';
COMMENT ON COLUMN estimate.addenda_num IS 'Номер дополнения';
COMMENT ON COLUMN estimate.source_num IS 'Номер сметы (из источника)';
COMMENT ON COLUMN estimate.volume_value IS 'Объемный показатель - количество';
COMMENT ON COLUMN estimate.volume_measure IS 'Объемный показатель - ед. изм.';
COMMENT ON COLUMN estimate.cost_code_id IS 'Код вида затрат (МРД)';
COMMENT ON COLUMN estimate.construction_cost IS 'Стоимость строительных работ';
COMMENT ON COLUMN estimate.installation_cost IS 'Стоимость монтажных работ';
COMMENT ON COLUMN estimate.equipment_cost IS 'Стоимость оборудования';
COMMENT ON COLUMN estimate.material_cost IS 'Стоимость материалов';
COMMENT ON COLUMN estimate.other_cost IS 'Стоимость прочих работ';
COMMENT ON COLUMN estimate.total_cost IS 'Стоимость итого';
COMMENT ON COLUMN estimate.comments IS 'Комментарий';
COMMENT ON COLUMN public.estimate.is_annulled IS 'Признак что смета аннулирована';
COMMENT ON COLUMN public.estimate.replaces_id IS 'Ссылка на заменённую смету';
COMMENT ON COLUMN estimate.price_at IS 'Уровень цен на дату';
COMMENT ON COLUMN estimate.approval_date IS 'Дата утверждения сметы';
COMMENT ON COLUMN estimate.state_at IS 'По состоянию на';
COMMENT ON COLUMN estimate.basis IS 'Основание для разработки';
COMMENT ON COLUMN estimate.book_cipher IS 'Шифр тома СД';
COMMENT ON COLUMN estimate.load_date IS 'Дата загрузки в систему';
COMMENT ON COLUMN estimate.tm_from IS 'Дата начала действия';
COMMENT ON COLUMN estimate.tm_to IS 'Дата окончания действия';

INSERT INTO sys.acl_function(name, descr) VALUES
    ('est.Estimates.c', 'Создание смет'),
    ('est.Estimates.r', 'Чтение смет'),
    ('est.Estimates.u', 'Изменение смет'),
    ('est.Estimates.d', 'Удаление смет');

