package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartGroupRef;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartRef;
import ru.gazpromproject.ta.svcm.core.repo.ConstrPartRefRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class ConstrPartRefRepoPg extends AbstractRepoId<ConstrPartRef> implements ConstrPartRefRepo {
    public ConstrPartRefRepoPg(Class<ConstrPartRef> cls) {
        super(cls);
    }

    @Override
    public List<ConstrPartRef> getByGroup(ConstrPartGroupRef group) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        List<ConstrPartRef> result = session
                .createQuery("select itm from " + tableName + " itm" + " where itm.groupId = :group_id", type)
                .setParameter("group_id", group.getId()).getResultList();
        session.close();
        return result;
    }
}
