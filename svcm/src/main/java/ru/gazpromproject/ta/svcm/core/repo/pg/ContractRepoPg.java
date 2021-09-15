package ru.gazpromproject.ta.svcm.core.repo.pg;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Contract;
import ru.gazpromproject.ta.svcm.core.model.ContractStage;
import ru.gazpromproject.ta.svcm.core.repo.ContractRepo;

public class ContractRepoPg extends AbstractRepoId<Contract> implements ContractRepo {

    public ContractRepoPg(Class<Contract> cls) {
        super(cls);
    }

    @Override
    public Contract getByContractStage(ContractStage contractStage) {
        Contract result = null;
        Long id = contractStage.getContractId();
        if (id != null)
            result = getById(id);
        return result;
    }

}
