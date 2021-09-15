package ru.gazpromproject.ta.svcm.sys.repo.pg;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.sys.model.LogEventType;
import ru.gazpromproject.ta.svcm.sys.repo.LogEventTypeRepo;

public class LogEventTypeRepoPg extends AbstractRepoId<LogEventType> implements LogEventTypeRepo {

    public LogEventTypeRepoPg(Class<LogEventType> cls) {
        super(cls);
    }

    @Override
    public LogEventType getByName(String name) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm where itm.name = :name";
        LogEventType result = session.createQuery(sql, type).setParameter("name", name).getResultStream()
                .findFirst().orElse(null);
        session.close();
        return result;
    }

}
