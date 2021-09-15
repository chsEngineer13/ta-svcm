package ru.gazpromproject.ta.svcm.core.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.model.Docset;

public interface DocsetRepo extends IAbstractRepoId<Docset> {
    List<Docset> getByObject(CObject cobject);
}
