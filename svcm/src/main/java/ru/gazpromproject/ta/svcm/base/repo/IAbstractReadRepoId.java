package ru.gazpromproject.ta.svcm.base.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;

public interface IAbstractReadRepoId<T extends AbstractModelId> {
    List<T> getAll();
    List<T> getAll(String whereClause, String orderbyClause, int firstClause, int topClause);

    T getById(long Id);

    public Class<T> getModelType();
}
