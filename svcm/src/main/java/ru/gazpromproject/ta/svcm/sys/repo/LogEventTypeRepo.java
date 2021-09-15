package ru.gazpromproject.ta.svcm.sys.repo;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.LogEventType;

public interface LogEventTypeRepo extends IAbstractRepoId<LogEventType> {

    LogEventType getByName(String name);

}
