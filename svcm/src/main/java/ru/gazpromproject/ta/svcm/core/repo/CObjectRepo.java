package ru.gazpromproject.ta.svcm.core.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.CObject;

public interface CObjectRepo extends IAbstractRepoId<CObject> {
    CObject getParent(CObject child);

    List<CObject> getChilds(CObject parent);

    List<CObject> getChildsTree(CObject parent, final int depth);
}
