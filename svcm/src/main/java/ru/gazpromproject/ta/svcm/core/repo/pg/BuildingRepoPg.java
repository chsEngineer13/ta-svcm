package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Building;
import ru.gazpromproject.ta.svcm.core.model.BuildingGroup;
import ru.gazpromproject.ta.svcm.core.repo.BuildingRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class BuildingRepoPg extends AbstractRepoId<Building> implements BuildingRepo {
    public BuildingRepoPg(Class<Building> cls) {
        super(cls);
    }

    @Override
    public List<Building> getByBuildingGroup(BuildingGroup buildingGroup) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        String sql = "select itm from " + tableName + " itm" + " where itm.buildingGroupId = :group_id";
        List<Building> result = session.createQuery(sql, type).setParameter("group_id", buildingGroup.getId())
                .getResultList();
        session.close();
        return result;
    }
}
