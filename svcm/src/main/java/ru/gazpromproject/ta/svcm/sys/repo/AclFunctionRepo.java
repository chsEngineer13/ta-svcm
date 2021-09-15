package ru.gazpromproject.ta.svcm.sys.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;

public interface AclFunctionRepo extends IAbstractRepoId<AclFunction> {
    List<AclFunction> getFunctionsByAccount(AclAccount parent);
    List<AclFunction> getFunctionsByRole(AclRole parent);
    AclFunction getByName(String name);
}
