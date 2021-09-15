package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Phase;
import ru.gazpromproject.ta.svcm.core.repo.PhaseRepo;

public class PhaseRepoPg extends AbstractRepoId<Phase> implements PhaseRepo {
    public PhaseRepoPg(Class<Phase> cls) {
        super(cls);
    }
}
