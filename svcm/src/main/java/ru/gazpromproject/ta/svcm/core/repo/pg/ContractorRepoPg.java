package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Contractor;
import ru.gazpromproject.ta.svcm.core.repo.ContractorRepo;

public class ContractorRepoPg extends AbstractRepoId<Contractor> implements ContractorRepo {
    public ContractorRepoPg(Class<Contractor> cls) {
        super(cls);
    }
}
