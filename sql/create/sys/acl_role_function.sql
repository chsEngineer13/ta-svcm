-- Таблица присвоения функций ролям
CREATE TABLE sys.acl_role_function (
  id            BIGSERIAL PRIMARY KEY,
  role_id       INTEGER NOT NULL REFERENCES sys.acl_role(id),
  function_id   INTEGER NOT NULL REFERENCES sys.acl_function(id),
  CONSTRAINT acl_role_function_rf_key UNIQUE(role_id, function_id)
);

COMMENT ON TABLE sys.acl_role_function IS 'acl_role <-> acl_function';

COMMENT ON COLUMN sys.acl_role_function.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_role_function.role_id IS '-> acl_role';
COMMENT ON COLUMN sys.acl_role_function.function_id IS '-> acl_function';

