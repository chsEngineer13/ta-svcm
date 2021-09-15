package ru.gazpromproject.ta.svcm.stream.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.stream.model.StreamBuilding;
import ru.gazpromproject.ta.svcm.stream.model.StreamConstrPart;
import ru.gazpromproject.ta.svcm.stream.model.StreamConstruction;
import ru.gazpromproject.ta.svcm.stream.model.StreamContract;
import ru.gazpromproject.ta.svcm.stream.model.StreamDocset;
import ru.gazpromproject.ta.svcm.stream.model.StreamModelBase;
import ru.gazpromproject.ta.svcm.stream.model.StreamStatus;
import ru.gazpromproject.ta.svcm.stream.repo.StreamRepo;

public class StreamRepoPg<T extends StreamModelBase> extends AbstractRepoId<T> implements StreamRepo<T> {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(StreamRepoPg.class);
    
    public StreamRepoPg(Class<T> cls) {
        super(cls);
    }

    @Override
    public List<T> getAllByStatus(StreamStatus streamStatus) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();        
        List<T> result = session
                .createQuery("select itm from " + tableName + " itm where itm.streamStatus = :status", type)
                .setParameter("status", streamStatus.getId())
                .getResultList();
        session.close();
        return result;
    }

    @Override
    public List<T> getByHidStr(String hidStr) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();        
        List<T> result = session
                .createQuery("select itm from " + tableName + " itm where itm.hidStr = :hidStr", type)
                .setParameter("hidStr", hidStr)
                .getResultList();
        session.close();
        return result;
    }
    
    @SuppressWarnings("unchecked")
    public <P extends StreamModelBase> Class<P> getStreamType(String code) {
        final String lowerCode = code.toLowerCase();
        if (lowerCode.equals("construction")) {
            return (Class<P>) StreamConstruction.class;
        } else if (lowerCode.equals("constrpart")) {
            return (Class<P>) StreamConstrPart.class;
        } else if (lowerCode.equals("building")) {
            return (Class<P>)StreamBuilding.class;
        } else if (lowerCode.equals("contract")) {
            return (Class<P>)StreamContract.class;
        } else if (lowerCode.equals("docset")) {
            return (Class<P>)StreamDocset.class;
        }
        return null;
    }
}
