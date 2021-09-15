package ru.gazpromproject.ta.svcm.sys.repo.pg;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.sys.model.AclFunction;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.model.AclRoleFunction;
import ru.gazpromproject.ta.svcm.sys.repo.AclRoleFunctionRepo;

public class AclRoleFunctionRepoPg extends AbstractRepoId<AclRoleFunction> implements AclRoleFunctionRepo {

    public AclRoleFunctionRepoPg(Class<AclRoleFunction> cls) {
        super(cls);
    }

    @Override
    public AclRoleFunction getByRoleFunction(AclRole roleItem, AclFunction functionItem) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm"
                + " where itm.roleId = :role_id and itm.functionId = :function_id";
        AclRoleFunction result = null;
        try {
            result = session.createQuery(sql, type)
                    .setParameter("role_id", roleItem.getId())
                    .setParameter("function_id", functionItem.getId())
                    .getResultStream().findFirst().orElse(null);
        } catch (Exception e) {
            if (session.getTransaction().isActive())
                session.getTransaction().rollback();
            throw e;
        } finally {
            session.close();
        }
        return result;
    }
}
