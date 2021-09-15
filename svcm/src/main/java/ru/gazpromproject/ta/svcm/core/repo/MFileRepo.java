package ru.gazpromproject.ta.svcm.core.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.MFile;

public interface MFileRepo extends IAbstractRepoId<MFile> {
    List<MFile> getByParentObjectId(Long id, String objType);
}
