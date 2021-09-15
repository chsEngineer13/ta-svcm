package ru.gazpromproject.ta.svcm.sys.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;

public interface AclRoleRepo extends IAbstractRepoId<AclRole> {

    List<AclRole> getRolesByAccount(AclAccount parent);

    List<AclRole> getRolesByFunction(AclFunction parent);
}
