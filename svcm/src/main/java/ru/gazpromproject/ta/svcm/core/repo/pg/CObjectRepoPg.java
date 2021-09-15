package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.util.List;

import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.NativeQuery;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.repo.CObjectRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class CObjectRepoPg extends AbstractRepoId<CObject> implements CObjectRepo {
    public CObjectRepoPg(Class<CObject> cls) {
        super(cls);
    }

    @Override
    public CObject getParent(CObject child) {
        CObject result = null;
        Long parentId = child.getParentId();
        if (parentId != null)
            result = getById(parentId);
        return result;
    }

    @Override
    public List<CObject> getChilds(CObject parent) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm" + " where itm.parentId = :parent_id";
        List<CObject> result = session.createQuery(sql, type).setParameter("parent_id", parent.getId()).getResultList();
        session.close();
        return result;
    }

    @Override
    public List<CObject> getChildsTree(CObject parent, final int depth) {
        Table table = type.getAnnotation(Table.class);
        String tableName = table.schema() + "." + table.name();
        String queryTxt = "WITH RECURSIVE tree AS (" + "    SELECT id" + "         , parent_id"
                + "	 	    , 0 AS depth" + "	     FROM " + tableName + "	    WHERE id = :parent_id" + "	    UNION"
                + "	   SELECT o.id" + "	        , o.parent_id" + "	  	    , tree.depth + 1" + "      FROM "
                + tableName + " o " + "        JOIN tree ON o.parent_id = tree.id" + ") " + "SELECT o.*"
                + "  FROM tree ot" + "  INNER JOIN " + tableName + " o " + "          ON ot.id = o.id"
                + "	 WHERE o.id <> :parent_id" + "	   AND depth <= :depth";
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        NativeQuery<CObject> query = session.createNativeQuery(queryTxt, type).setParameter("parent_id", parent.getId())
                .setParameter("depth", depth);
        List<CObject> result = query.list();
        session.close();
        return result;
    }
}
