package ru.gazpromproject.ta.svcm.sys.repo;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclAccountRole;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;

public interface AclAccountRoleRepo extends IAbstractRepoId<AclAccountRole> {

    AclAccountRole getByAccountRole(AclAccount accountItem, AclRole roleItem);

}
