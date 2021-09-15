package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartGroupRef;
import ru.gazpromproject.ta.svcm.core.model.ConstrPartRef;
import ru.gazpromproject.ta.svcm.core.repo.ConstrPartGroupRefRepo;

public class ConstrPartGroupRefRepoPg extends AbstractRepoId<ConstrPartGroupRef> implements ConstrPartGroupRefRepo {
    public ConstrPartGroupRefRepoPg(Class<ConstrPartGroupRef> cls) {
        super(cls);
    }

    @Override
    public ConstrPartGroupRef getByItem(ConstrPartRef item) {
        ConstrPartGroupRef result = null;
        Long id = item.getGroupId();
        if (id != null)
            result = getById(id);
        return result;
    }
}
