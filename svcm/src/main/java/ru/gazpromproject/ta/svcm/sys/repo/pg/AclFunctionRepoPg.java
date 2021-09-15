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
import ru.gazpromproject.ta.svcm.sys.repo.AclFunctionRepo;

public class AclFunctionRepoPg extends AbstractRepoId<AclFunction> implements AclFunctionRepo {

    public AclFunctionRepoPg(Class<AclFunction> cls) {
        super(cls);
    }

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(AclRoleRepoPg.class);

    @Override
    public List<AclFunction> getFunctionsByAccount(AclAccount parent) {
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String sql = "select distinct itm.* from " + tableName + " itm"
                + " join sys.acl_role_function rf on rf.function_id = itm.id"
                + " join sys.acl_account_role ar on ar.role_id = rf.role_id where (ar.account_id = :account_id)";
        List<AclFunction> result = session.createNativeQuery(sql, type).setParameter("account_id", parent.getId())
                .getResultList();
        session.close();
        return result;
    }

    @Override
    public List<AclFunction> getFunctionsByRole(AclRole parent) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        String sql = "select itm.* from " + tableName + " itm"
                + " join sys.acl_role_function rf on rf.function_id = itm.id where (rf.role_id = :role_id)";
        List<AclFunction> result = session.createNativeQuery(sql, type).setParameter("role_id", parent.getId())
                .getResultList();
        session.close();
        return result;
    }

    @Override
    public AclFunction getByName(String name) {
//        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        String tableName = type.getSimpleName();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String sql = "select itm from " + tableName + " itm where itm.name = :name";
        AclFunction result = session.createQuery(sql, type).setParameter("name", name).getResultStream().findFirst()
                .orElse(null);
        session.close();
        return result;
    }
}
