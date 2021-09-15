-- Добавление всех функций в роль 'Super'
INSERT INTO sys.acl_role_function (role_id, function_id)
SELECT
	(SELECT id FROM sys.acl_role WHERE name = 'Super'),
	id
FROM sys.acl_function f1
WHERE NOT EXISTS(
    SELECT 1 FROM sys.acl_role_function rf
    WHERE rf.function_id = f1.id
      and rf.role_id = (SELECT id FROM sys.acl_role WHERE name = 'Super')
)
ORDER BY f1.id;

-- Добавление функций чтения данных в роль 'User'
INSERT INTO sys.acl_role_function (role_id, function_id)
SELECT
	(SELECT id FROM sys.acl_role WHERE name = 'User'),
	id
FROM sys.acl_function f1
WHERE NOT EXISTS(
    SELECT 1 FROM sys.acl_role_function rf
    WHERE rf.function_id = f1.id
      and rf.role_id = (SELECT id FROM sys.acl_role WHERE name = 'User')
)
  AND (f1.name like 'core.%.r')
ORDER BY f1.id;

-- Добавление роли 'Super' к логину 'admin'
INSERT INTO sys.acl_account_role (account_id, role_id)
SELECT
	(SELECT id FROM sys.acl_account WHERE login = 'admin'),
	(SELECT id FROM sys.acl_role WHERE name = 'Super');

