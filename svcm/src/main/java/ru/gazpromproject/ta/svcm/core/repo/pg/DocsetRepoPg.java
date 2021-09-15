package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.model.Docset;
import ru.gazpromproject.ta.svcm.core.repo.DocsetRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class DocsetRepoPg extends AbstractRepoId<Docset> implements DocsetRepo {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(DocsetRepoPg.class);

    public DocsetRepoPg(Class<Docset> cls) {
        super(cls);
    }

    @Override
    public List<Docset> getByObject(CObject cobject) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm" + " where itm.CObjectId = :cobject_id";
//		logger.info(String.format("DocsetRepo.getByObject sql: %s", sql));
        List<Docset> result = session.createQuery(sql, type).setParameter("cobject_id", cobject.getId())
                .getResultList();
        session.close();
        return result;
    }
}
