package ru.gazpromproject.ta.svcm.core.repo.pg;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import ru.gazpromproject.ta.svcm.base.repo.pg.AbstractRepoId;
import ru.gazpromproject.ta.svcm.core.model.Contract;
import ru.gazpromproject.ta.svcm.core.model.ContractStage;
import ru.gazpromproject.ta.svcm.core.repo.ContractStageRepo;
import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;

public class ContractStageRepoPg extends AbstractRepoId<ContractStage> implements ContractStageRepo {

    public ContractStageRepoPg(Class<ContractStage> cls) {
        super(cls);
    }

    @Override
    public List<ContractStage> getByContract(Contract contract) {
        SessionFactory sessionFactory = HeSessionFactory.getSessionFactory();
        Session session = sessionFactory.openSession();
        String tableName = type.getSimpleName();
        List<ContractStage> result = session
                .createQuery("select itm from " + tableName + " itm" + " where itm.contractId = :contract_id", type)
                .setParameter("contract_id", contract.getId()).getResultList();
        session.close();
        return result;
    }

}
