package ru.gazpromproject.ta.svcm.stream.repo.pg;

import ru.gazpromproject.ta.svcm.stream.model.StreamContract;
import ru.gazpromproject.ta.svcm.stream.repo.StreamContractRepo;

public class StreamContractRepoPg extends StreamRepoPg<StreamContract> implements StreamContractRepo {
    public StreamContractRepoPg() {
        super(StreamContract.class);
    }
}
