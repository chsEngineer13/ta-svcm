package ru.gazpromproject.ta.svcm.sys.repo;

import java.sql.SQLException;
import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.LogEvent;

public interface LogEventRepo extends IAbstractRepoId<LogEvent> {

    List<LogEvent> getByAclAccount(AclAccount account);

    Integer addEvent(LogEvent event) throws SQLException;
}
