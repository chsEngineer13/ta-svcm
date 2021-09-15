package ru.gazpromproject.ta.svcm.core.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartGroupRef;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartRef;

public interface ConstrPartRefRepo extends IAbstractRepoId<ConstrPartRef> {
    List<ConstrPartRef> getByGroup(ConstrPartGroupRef group);
}
