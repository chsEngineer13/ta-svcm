package ru.gazpromproject.ta.svcm.core.repo;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartGroupRef;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartRef;

public interface ConstrPartGroupRefRepo extends IAbstractRepoId<ConstrPartGroupRef> {
    ConstrPartGroupRef getByItem(ConstrPartRef item);
}
