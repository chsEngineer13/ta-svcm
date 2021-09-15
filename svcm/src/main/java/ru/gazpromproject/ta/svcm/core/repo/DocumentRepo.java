package ru.gazpromproject.ta.svcm.core.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractReadRepoId;
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.model.Document;

public interface DocumentRepo extends IAbstractReadRepoId<Document> {
    List<Document> getByDocset(Docset docset);
}
