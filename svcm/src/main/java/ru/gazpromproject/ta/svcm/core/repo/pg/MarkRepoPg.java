package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Mark;
import ru.gazpromproject.ta.svcm.core.repo.MarkRepo;

public class MarkRepoPg extends AbstractRepoId<Mark> implements MarkRepo {
    public MarkRepoPg(Class<Mark> cls) {
        super(cls);
    }
}
