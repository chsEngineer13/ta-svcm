package ru.gazpromproject.ta.svcm.stream.repo.pg;

import ru.gazpromproject.ta.svcm.stream.model.StreamConstruction;
import ru.gazpromproject.ta.svcm.stream.repo.StreamConstructionRepo;

public class StreamConstructionRepoPg extends StreamRepoPg<StreamConstruction> implements StreamConstructionRepo {
    public StreamConstructionRepoPg() {
        super(StreamConstruction.class);
    }
}
