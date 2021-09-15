package ru.gazpromproject.ta.svcm.sys.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.sys.model.AclGroup;
import ru.gazpromproject.ta.svcm.sys.repo.AclGroupRepo;

public class AclGroupRepoPg extends AbstractRepoId<AclGroup> implements AclGroupRepo {
    public AclGroupRepoPg(Class<AclGroup> cls) {
        super(cls);
    }

}
