package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Waybill;
import ru.gazpromproject.ta.svcm.core.repo.WaybillRepo;

public class WaybillRepoPg extends AbstractRepoId<Waybill> implements WaybillRepo {

    public WaybillRepoPg(Class<Waybill> cls) {
        super(cls);
    }

}
