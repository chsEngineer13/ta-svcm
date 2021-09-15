package ru.gazpromproject.ta.svcm.sys.repo.pg;

import java.util.List;

import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.model.LogEvent;
import ru.gazpromproject.ta.svcm.sys.repo.AclAccountRepo;

public class AclAccountRepoPg extends AbstractRepoId<AclAccount> implements AclAccountRepo {

    public AclAccountRepoPg(Class<AclAccount> cls) {
        super(cls);
    }

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(AclAccountRepoPg.class);

    @Override
    public AclAccount getByLogin(String login) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm where itm.login = :login";
        AclAccount result = session.createQuery(sql, type).setParameter("login", login).getResultStream()
                .findFirst().orElse(null);
        session.close();
        return result;
    }

    @Override
    public List<AclAccount> getAccountsByFunction(AclFunction parent) {
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String sql = "select distinct itm.* from " + tableName + " itm"
                + " join sys.acl_account_role ar on ar.account_id = itm.id"
                + " join sys.acl_role_function rf on rf.role_id = ar.role_id "
                + "where (rf.function_id = :function_id)";
        List<AclAccount> result = session.createNativeQuery(sql, type).setParameter("function_id", parent.getId())
                .getResultList();
        session.close();
        return result;
    }

    @Override
    public List<AclAccount> getAccountsByRole(AclRole parent) {
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String sql = "select itm.* from " + tableName + " itm"
                + " inner join sys.acl_account_role ar on ar.account_id = itm.id where (ar.role_id = :role_id)";
        List<AclAccount> result = session.createNativeQuery(sql, type).setParameter("role_id", parent.getId())
                .getResultList();
        session.close();
        return result;
    }

    @Override
    public Boolean hasFunction(String functionName, String accountName) {
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String sql = "select distinct itm.* from " + tableName + " itm"
                + " join sys.acl_account_role ar on ar.account_id = itm.id"
                + " join sys.acl_role_function rf on rf.role_id = ar.role_id"
                + " join sys.acl_function f on f.id = rf.function_id"
                + " where (f.name = :function_name) and (itm.login = :account_name)";
        List<AclAccount> result = session.createNativeQuery(sql, type).setParameter("account_name", accountName)
                .setParameter("function_name", functionName).getResultList();
        session.close();
        return !result.isEmpty();
    }

    @Override
    public AclAccount getAccountByLogEvent(LogEvent parent) {
        // TODO Auto-generated getAccountByLogEvent
        return null;
    }
}
