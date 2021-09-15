package ru.gazpromproject.ta.svcm.base.repo;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

public interface IAbstractRepoId<T extends AbstractModelId> extends IAbstractReadRepoId<T> {
    T create(T modelObject);
    void update(long Id, T modelObject);
    void delete(long Id);
}
