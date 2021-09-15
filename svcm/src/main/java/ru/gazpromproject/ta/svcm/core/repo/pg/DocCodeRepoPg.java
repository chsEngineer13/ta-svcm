package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.DocCode;
import ru.gazpromproject.ta.svcm.core.repo.DocCodeRepo;

public class DocCodeRepoPg extends AbstractRepoId<DocCode> implements DocCodeRepo {

    public DocCodeRepoPg(Class<DocCode> cls) {
        super(cls);
    }
}
