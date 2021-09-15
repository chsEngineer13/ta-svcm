package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.SummaryConstruction;
import ru.gazpromproject.ta.svcm.core.repo.SummaryConstructionRepo;

public class SummaryConstructionRepoPg extends AbstractRepoId<SummaryConstruction> implements SummaryConstructionRepo {

    public SummaryConstructionRepoPg(Class<SummaryConstruction> cls) {
        super(cls);
    }

}
