package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.ChapterCode;
import ru.gazpromproject.ta.svcm.core.repo.ChapterCodeRepo;

public class ChapterCodeRepoPg extends AbstractRepoId<ChapterCode> implements ChapterCodeRepo {
    public ChapterCodeRepoPg(Class<ChapterCode> cls) {
        super(cls);
    }

}
