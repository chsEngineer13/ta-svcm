package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.model.Document;
import ru.gazpromproject.ta.svcm.core.repo.DocumentRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class DocumentRepoPg extends AbstractRepoId<Document> implements DocumentRepo {

    public DocumentRepoPg(Class<Document> cls) {
        super(cls);
    }

    @Override
    public List<Document> getByDocset(Docset docset) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        List<Document> result = session
                .createQuery("select itm from " + tableName + " itm" + " where itm.docsetId = :docset_id", type)
                .setParameter("docset_id", docset.getId()).getResultList();
        session.close();
        return result;
    }

}
