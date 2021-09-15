package ru.gazpromproject.ta.svcm.core.repo;

import ru.gazpromproject.ta.svcm.base.repo.*;
import ru.gazpromproject.ta.svcm.core.model.Contract;
import ru.gazpromproject.ta.svcm.core.model.ContractStage;


public interface ContractRepo extends IAbstractRepoId<Contract> {
    Contract getByContractStage(ContractStage contractStage);
}
