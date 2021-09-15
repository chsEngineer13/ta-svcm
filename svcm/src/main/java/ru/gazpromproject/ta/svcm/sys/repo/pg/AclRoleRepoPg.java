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
import ru.gazpromproject.ta.svcm.sys.repo.AclRoleRepo;

public class AclRoleRepoPg extends AbstractRepoId<AclRole> implements AclRoleRepo {
    
    public AclRoleRepoPg(Class<AclRole> cls) {
        super(cls);
    }

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(AclRoleRepoPg.class);

    @Override
    public List<AclRole> getRolesByAccount(AclAccount parent) {
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String sql = "select itm.* from " + tableName + " itm"
                + " inner join sys.acl_account_role ar on ar.role_id = itm.id where (ar.account_id = :acc_id)";
        List<AclRole> result = session.createNativeQuery(sql, type).setParameter("acc_id", parent.getId())
                .getResultList();
        session.close();
        return result;
    }

    @Override
    public List<AclRole> getRolesByFunction(AclFunction parent) {
        String tableName = type.getAnnotation(Table.class).schema() + '.' + type.getAnnotation(Table.class).name();
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String sql = "select itm.* from " + tableName + " itm"
                + " inner join sys.acl_role_function rf on rf.role_id = itm.id"
                + " where (rf.function_id = :function_id)";
        List<AclRole> result = session.createNativeQuery(sql, type).setParameter("function_id", parent.getId())
                .getResultList();
        session.close();
        return result;
    }

}
