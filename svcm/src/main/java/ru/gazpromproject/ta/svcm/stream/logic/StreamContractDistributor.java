package ru.gazpromproject.ta.svcm.stream.logic;

import java.util.*;
import java.util.function.*;
import java.util.stream.*;

import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.core.model.*;
import ru.gazpromproject.ta.svcm.core.repo.ContractRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.ContractRepoPg;
import ru.gazpromproject.ta.svcm.core.repo.pg.RepoUtilsPg;
import ru.gazpromproject.ta.svcm.stream.model.*;
import ru.gazpromproject.ta.svcm.stream.repo.*;
import ru.gazpromproject.ta.svcm.stream.repo.pg.*;

public class StreamContractDistributor implements StreamDistributor {

    private Map<String, StreamContract> newStreamContracts;
    private Map<String, Contract> newContracts;
    private StreamContractRepo streamContractRepo;
    private ContractRepo contractRepo;
    
    public StreamContractDistributor() {
        streamContractRepo = new StreamContractRepoPg();
        contractRepo = new ContractRepoPg(Contract.class);
    }
   
    @Override
    public void distributeNew() {
        fetchNewStreamContracts();
        fillNewContractsFromStreamContracts();
        distributeNewContracts();
    }
    
    private void fetchNewStreamContracts() {        
        List<StreamContract> newContracts = streamContractRepo.getAllByStatus(StreamStatus.NEW);
        newStreamContracts =  
                newContracts
                .stream()
                .collect(Collectors.toMap(StreamContract::getHidStr, Function.identity()));
    }
    
    private void fillNewContractsFromStreamContracts() {
        newContracts = new HashMap<String, Contract>();
        for (Map.Entry<String, StreamContract> mappedStreamContract: newStreamContracts.entrySet()) {
            Contract contract = contractFromStreamContract(mappedStreamContract.getValue());
            newContracts.put(mappedStreamContract.getKey(), contract);
        }
    }

    private Contract contractFromStreamContract(StreamContract streamContract) {
        Contract contract = new Contract();        
        // conastruction_id
        contract.setOipks(streamContract.getOipks());
        // contractor_id
        // phase_id
        // developer_id
        contract.setInnerNum(streamContract.getInnerNumber());
        contract.setTitle(streamContract.getName());        
        contract.setContractNum(streamContract.getContractSequenceNumber());
        // contract_year
        // contract_date
        contract.setContractStatus(streamContract.getContractStatus());
        contract.setIUSCode(streamContract.getIusCode());
        contract.setTechDirector(streamContract.getTechdirector());
        contract.setGips(streamContract.getGip());
        // TODO: make normal error messages
        try {
            contract.setDateSign(RepoUtilsPg.parseDatePg(streamContract.getDateSign()));
            contract.setWorkStart(RepoUtilsPg.parseDatePg(streamContract.getWorkStart()));
            contract.setWorkFinish(RepoUtilsPg.parseDatePg(streamContract.getWorkFinish()));
            contract.setOrderStart(RepoUtilsPg.parseDatePg(streamContract.getOrderStart()));
            contract.setOrderFinish(RepoUtilsPg.parseDatePg(streamContract.getOrderFinish()));
        } catch (ODataApplicationException e) {
            
        }        
        contract.setWorkTypes(streamContract.getWorkTypes());        
        return contract;
    }
        
    private void distributeNewContracts() {
        for (Map.Entry<String, Contract> mappedContract: newContracts.entrySet()) {
            Contract savedContract = saveNewContract(mappedContract.getValue());
            updateStreamContract(mappedContract.getKey(), savedContract);
        }
    }

    private Contract saveNewContract(Contract contract) {
        Contract newContract = contractRepo.create(contract);
        return newContract;
    }
        
    private void updateStreamContract(String streamContractKey, Contract savedContract) {
        StreamContract streamContract = newStreamContracts.get(streamContractKey);
        streamContract.setSuccessorId(savedContract.getId());
        streamContract.setStreamStatus(StreamStatus.DISTRIBUTED_SUCCESSFULLY.getId());
        streamContractRepo.update(streamContract.getId(), streamContract);
    }

}
