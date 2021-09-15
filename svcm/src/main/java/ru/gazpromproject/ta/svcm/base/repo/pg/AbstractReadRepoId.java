package ru.gazpromproject.ta.svcm.base.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;
import ru.gazpromproject.ta.svcm.base.repo.IAbstractReadRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class AbstractReadRepoId<T extends AbstractModelId> implements IAbstractReadRepoId<T> {
    public Class<T> type;

    public AbstractReadRepoId(Class<T> cls) {
        type = cls;
    }

    @Override
    public Class<T> getModelType() {
        return this.type;
    }

    @Override
    public List<T> getAll() {
        return getAll(null, null, 0, 0);
    }

    @Override
    public List<T> getAll(String whereClause, String orderbyClause, int firstClause, int topClause) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        StringBuilder sqlQuery = new StringBuilder("from " + tableName);
        if (whereClause != null)
            sqlQuery.append(whereClause);
        if (orderbyClause != null)
            sqlQuery.append(orderbyClause);
        Query<T> query = session.createQuery(sqlQuery.toString(), type);
        if (firstClause > 0)
            query.setFirstResult(firstClause);
        if (topClause > 0)
            query.setMaxResults(topClause);
        List<T> result = query.getResultList();
        session.close();
        return result;
    }

    @Override
    public T getById(long Id) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        Query<T> query = session
                .createQuery("select itm from " + tableName + " itm where itm.id = :id", type)
                .setParameter("id", Id);
        List<T> resultList = query.getResultList();
        session.close();
        if (resultList != null) {
            if (resultList.size() == 1) {
                return resultList.get(0);
            } else {
                // REFACT: more than one item for id - throw BIG Exception
            }
        }
        return null;
    }
}
