package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.MFile;
import ru.gazpromproject.ta.svcm.core.repo.MFileRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class MFileRepoPg extends AbstractRepoId<MFile> implements MFileRepo {

    public MFileRepoPg(Class<MFile> cls) {
        super(cls);
    }

    @Override
    public List<MFile> getByParentObjectId(Long id, String objType) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm"
                + " where itm.parentObjectId = :obj_id and itm.parentObjectType = :obj_type";
        List<MFile> result = session
                .createQuery(sql, type)
                .setParameter("obj_id", id)
                .setParameter("obj_type", objType)
                .getResultList();
        return result;
    }

}
