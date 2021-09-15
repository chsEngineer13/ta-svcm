package ru.gazpromproject.ta.svcm.sys.repo.pg;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.sys.model.AclAccount;
import ru.gazpromproject.ta.svcm.sys.model.AclAccountRole;
import ru.gazpromproject.ta.svcm.sys.model.AclRole;
import ru.gazpromproject.ta.svcm.sys.repo.AclAccountRoleRepo;

public class AclAccountRoleRepoPg extends AbstractRepoId<AclAccountRole> implements AclAccountRoleRepo {

    public AclAccountRoleRepoPg(Class<AclAccountRole> cls) {
        super(cls);
    }

    @Override
    public AclAccountRole getByAccountRole(AclAccount accountItem, AclRole roleItem) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm"
                + " where itm.accountId = :account_id and itm.roleId = :role_id";
        AclAccountRole result = null;
        try {
            result = session.createQuery(sql, type)
                    .setParameter("account_id", accountItem.getId())
                    .setParameter("role_id", roleItem.getId())
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
