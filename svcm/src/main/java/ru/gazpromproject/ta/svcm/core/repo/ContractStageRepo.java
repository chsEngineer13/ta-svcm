package ru.gazpromproject.ta.svcm.core.repo;

import java.util.List;

import ru.gazpromproject.ta.svcm.base.repo.IAbstractReadRepoId;
import ru.gazpromproject.ta.svcm.core.model.Contract;
import ru.gazpromproject.ta.svcm.core.model.ContractStage;

public interface ContractStageRepo extends IAbstractReadRepoId<ContractStage> {
    List<ContractStage> getByContract(Contract contract);

}
