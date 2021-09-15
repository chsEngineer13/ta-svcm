package ru.gazpromproject.ta.svcm.sys.repo;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.model.AclRoleFunction;

public interface AclRoleFunctionRepo extends IAbstractRepoId<AclRoleFunction> {
    
    AclRoleFunction getByRoleFunction(AclRole roleItem, AclFunction functionItem);

}
