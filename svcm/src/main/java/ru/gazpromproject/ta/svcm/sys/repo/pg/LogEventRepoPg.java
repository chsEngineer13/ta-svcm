package ru.gazpromproject.ta.svcm.sys.repo.pg;

import java.sql.SQLException;
import java.util.List;

import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.hibernate.type.LongType;
import org.hibernate.type.StringType;
import org.hibernate.type.TimestampType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.LogEvent;
import ru.gazpromproject.ta.svcm.sys.repo.LogEventRepo;

public class LogEventRepoPg extends AbstractRepoId<LogEvent> implements LogEventRepo {

    public LogEventRepoPg(Class<LogEvent> cls) {
        super(cls);
    }

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(AclAccountRepoPg.class);

    @Override
    public List<LogEvent> getByAclAccount(AclAccount account) {
        if (account == null)
            return null;
        List<LogEvent> result = null;
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm where itm.accountId = :id";
        Long id = account.getId();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        try {
            result = session.createQuery(sql, type).setParameter("id", id).getResultList();
        } finally {
            session.close();
        }
        return result;
    }

    @Override
    public Integer addEvent(LogEvent event) throws SQLException {
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        Integer result = 0;

        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();

        String sql = "insert into " + tableName
                + " (account_id, eventtype_id, eventtime, schema_name, operation_name, operation_pk_id, operation_pk_time, details, descr)"
                + " values"
                + "(:account_id, :eventtype_id, CURRENT_TIMESTAMP, :schema_name, :operation_name, :operation_pk_id, :operation_pk_time, cast(:details as json), :descr)";
        Transaction tx = null;
        try {
            tx = session.beginTransaction();

            String details = event.getDetails();
            if (details.trim() == "")
                details = null;

            Query<LogEvent> qry = session.createNativeQuery(sql, type);
            qry.setParameter("account_id", event.getAccountId());
            qry.setParameter("eventtype_id", event.getEventTypeId());
            qry.setParameter("schema_name", event.getSchemaName());
            qry.setParameter("operation_name", event.getOperationName());
            qry.setParameter("operation_pk_id", event.getOperationPKId(), LongType.INSTANCE);
            qry.setParameter("operation_pk_time", event.getOperationPKTime(), TimestampType.INSTANCE);
            qry.setParameter("details", details, StringType.INSTANCE);
            qry.setParameter("descr", event.getDescr());

            result = qry.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive())
                tx.rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }

}
