package ru.gazpromproject.ta.svcm.sys.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.model.LogEvent;

public interface AclAccountRepo extends IAbstractRepoId<AclAccount> {

    AclAccount getByLogin(String login);

    List<AclAccount> getAccountsByRole(AclRole parent);

    List<AclAccount> getAccountsByFunction(AclFunction parent);

    AclAccount getAccountByLogEvent(LogEvent parent);

    Boolean hasFunction(String functionName, String accountName);
}
