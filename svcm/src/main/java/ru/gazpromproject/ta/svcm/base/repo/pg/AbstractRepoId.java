package ru.gazpromproject.ta.svcm.base.repo.pg;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import ru.gazpromproject.ta.svcm.base.model.AbstractModelId;
import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public abstract class AbstractRepoId<T extends AbstractModelId> extends AbstractReadRepoId<T>
        implements IAbstractRepoId<T> {

    public AbstractRepoId(Class<T> cls) {
        super(cls);
    }

    @Override
    public T create(T modelIdObject) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(modelIdObject);
            tx.commit();
        } catch (RuntimeException e) {
            tx.rollback();
            throw e;
        } finally {
            session.close();
        }
        return modelIdObject;
    }

    @Override
    public void update(long Id, T modelIdObject) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            modelIdObject.setId(Id);
            tx = session.beginTransaction();
            session.update(modelIdObject);
            tx.commit();
        } catch (RuntimeException e) {
            tx.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public void delete(long Id) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            T modelIdObject = (T) session.load(type, Id);
            session.delete(modelIdObject);
            tx.commit();
        } catch (RuntimeException e) {
            tx.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
}
