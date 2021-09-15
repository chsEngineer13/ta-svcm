package ru.gazpromproject.ta.svcm.core.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Building;
import ru.gazpromproject.ta.svcm.core.model.BuildingGroup;

public interface BuildingRepo extends IAbstractRepoId<Building> {
    List<Building> getByBuildingGroup(BuildingGroup buildingGroup);
}
