package ru.gazpromproject.ta.svcm.stream.repo.pg;

import ru.gazpromproject.ta.svcm.stream.model.StreamBuilding;
import ru.gazpromproject.ta.svcm.stream.repo.StreamBuildingRepo;

public class StreamBuildingRepoPg extends StreamRepoParentPg<StreamBuilding> implements StreamBuildingRepo {
    public StreamBuildingRepoPg() {
        super(StreamBuilding.class);
    }
}
