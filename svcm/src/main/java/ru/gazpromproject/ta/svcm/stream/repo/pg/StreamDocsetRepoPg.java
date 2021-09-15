package ru.gazpromproject.ta.svcm.stream.repo.pg;

import ru.gazpromproject.ta.svcm.stream.model.StreamDocset;
import ru.gazpromproject.ta.svcm.stream.repo.StreamDocsetRepo;

public class StreamDocsetRepoPg extends StreamRepoParentPg<StreamDocset> implements StreamDocsetRepo {
    public StreamDocsetRepoPg() {
        super(StreamDocset.class);
    }
}
