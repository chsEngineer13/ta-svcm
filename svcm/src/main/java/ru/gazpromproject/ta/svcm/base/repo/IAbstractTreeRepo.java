package ru.gazpromproject.ta.svcm.base.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.model.AbstractTreeModel;

public interface IAbstractTreeRepo<T extends AbstractTreeModel> extends IAbstractRepoId<T> {
    T getParent(T child);
    List<T> getChilds(T parent);
    List<T> getChildsTree(T parent, final int depth);
}
