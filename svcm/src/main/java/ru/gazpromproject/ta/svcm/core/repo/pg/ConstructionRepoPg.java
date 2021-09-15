package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Construction;
import ru.gazpromproject.ta.svcm.core.repo.ConstructionRepo;

public class ConstructionRepoPg extends AbstractRepoId<Construction> implements ConstructionRepo {
    public ConstructionRepoPg(Class<Construction> cls) {
        super(cls);
    }
}
