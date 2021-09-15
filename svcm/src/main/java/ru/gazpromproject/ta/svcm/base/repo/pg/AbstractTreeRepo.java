package ru.gazpromproject.ta.svcm.base.repo.pg;

import java.util.List;
import javax.persistence.Table;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.NativeQuery;

import ru.gazpromproject.ta.svcm.base.model.AbstractTreeModel;
import ru.gazpromproject.ta.svcm.base.repo.IAbstractTreeRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public abstract class AbstractTreeRepo<T extends AbstractTreeModel> extends AbstractRepoId<T>
        implements IAbstractTreeRepo<T> {

    public AbstractTreeRepo(Class<T> cls) {
        super(cls);
    }

    @Override
    public T getParent(T child) {
        T result = null;
        Long parentId = child.getParentId();
        if (parentId != null)
            result = getById(parentId);
        return result;
    }

    @Override
    public List<T> getChilds(T parent) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm" + " where itm.parentId = :parent_id";
        List<T> result = session.createQuery(sql, type).setParameter("parent_id", parent.getId()).getResultList();
        session.close();
        return result;
    }

    @Override
    public List<T> getChildsTree(T parent, int depth) {
        String schema = type.getAnnotation(Table.class).schema();
        String table = type.getAnnotation(Table.class).name();
        String tableName = schema != "" ? schema + "." + table : table;
        String queryTxt = "WITH RECURSIVE tree AS (" + "    SELECT id" + "         , parent_id"
                + "	 	    , 0 AS depth" + "	     FROM " + tableName + "	    WHERE id = :parent_id" + "	    UNION"
                + "	   SELECT o.id" + "	        , o.parent_id" + "	  	    , tree.depth + 1" + "      FROM "
                + tableName + " o " + "        JOIN tree ON o.parent_id = tree.id" + ") " + "SELECT o.*"
                + "  FROM tree ot" + "  INNER JOIN " + tableName + " o " + "          ON ot.id = o.id"
                + "	 WHERE o.id <> :parent_id" + "	   AND depth <= :depth";
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        NativeQuery<T> query = session.createNativeQuery(queryTxt, type).setParameter("parent_id", parent.getId())
                .setParameter("depth", depth);
        List<T> result = query.list();
        session.close();
        return result;
    }
}
