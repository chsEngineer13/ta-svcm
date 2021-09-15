package ru.gazpromproject.ta.svcm.stream.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBaseParent;
import ru.gazpromproject.ta.svcm.stream.repo.StreamRepoParent;

public abstract class StreamRepoParentPg<T extends StreamModelBaseParent> extends StreamRepoPg<T> implements StreamRepoParent<T> {

    public StreamRepoParentPg(Class<T> cls) {
        super(cls);
    }
        
    @Override
    public <P extends StreamModelBase> List<P> getParent(T child) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        Class<P> parentType = super.getStreamType(child.getParentType());
        if (parentType == null)
            return null;
        String tableName = parentType.getSimpleName();
        if (tableName == null)
            return null;
        List<P> result = session
                .createQuery("select itm from " + tableName + " itm where itm.hidStr = :hidStr", parentType)
                .setParameter("hidStr", child.getHpid_str())
                .getResultList();                
        session.close();
        return result;
    }        
}