package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Developer;
import ru.gazpromproject.ta.svcm.core.repo.DeveloperRepo;

public class DeveloperRepoPg extends AbstractRepoId<Developer> implements DeveloperRepo {
    public DeveloperRepoPg(Class<Developer> cls) {
        super(cls);
    }
}
