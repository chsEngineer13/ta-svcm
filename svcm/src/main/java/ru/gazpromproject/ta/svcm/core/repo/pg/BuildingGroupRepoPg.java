package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractTreeRepo;
import ru.gazpromproject.ta.svcm.core.model.BuildingGroup;
import ru.gazpromproject.ta.svcm.core.repo.BuildingGroupRepo;

public class BuildingGroupRepoPg extends AbstractTreeRepo<BuildingGroup> implements BuildingGroupRepo {

    public BuildingGroupRepoPg(Class<BuildingGroup> cls) {
        super(cls);
    }
}
