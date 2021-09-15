-- Таблица присвоения ролей пользователю
CREATE TABLE sys.acl_account_role (
  id          BIGSERIAL PRIMARY KEY,
  account_id  INTEGER NOT NULL REFERENCES sys.acl_account(id),
  role_id     INTEGER NOT NULL REFERENCES sys.acl_role(id),
  CONSTRAINT acl_account_role_ar_key UNIQUE(account_id, role_id)
);

COMMENT ON TABLE sys.acl_account_role IS 'acl_account <-> acl_role';

COMMENT ON COLUMN sys.acl_account_role.id IS 'Идентификатор';
COMMENT ON COLUMN sys.acl_account_role.account_id IS '-> acl_account';
COMMENT ON COLUMN sys.acl_account_role.role_id IS '-> acl_role';

