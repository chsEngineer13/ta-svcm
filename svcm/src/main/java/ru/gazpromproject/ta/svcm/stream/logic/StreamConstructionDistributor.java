package ru.gazpromproject.ta.svcm.stream.logic;

import java.util.List;

import ru.gazpromproject.ta.svcm.core.model.CObject;
import ru.gazpromproject.ta.svcm.core.model.Construction;
import ru.gazpromproject.ta.svcm.core.repo.CObjectRepo;
import ru.gazpromproject.ta.svcm.core.repo.ConstructionRepo;
import ru.gazpromproject.ta.svcm.core.repo.pg.CObjectRepoPg;
import ru.gazpromproject.ta.svcm.core.repo.pg.ConstructionRepoPg;
import ru.gazpromproject.ta.svcm.stream.model.StreamConstruction;
import ru.gazpromproject.ta.svcm.stream.model.StreamStatus;
import ru.gazpromproject.ta.svcm.stream.repo.StreamConstructionRepo;
import ru.gazpromproject.ta.svcm.stream.repo.pg.StreamConstructionRepoPg;

public class StreamConstructionDistributor implements StreamDistributor {
   
    @Override
    public void distributeNew() {
        StreamConstructionRepo repo = new StreamConstructionRepoPg();
        List<StreamConstruction> newItems = repo.getAllByStatus(StreamStatus.NEW);
        ConstructionRepo contructionRepo = new ConstructionRepoPg(Construction.class);
        CObjectRepo cobjectRepo = new CObjectRepoPg(CObject.class);
        for (StreamConstruction streamItem: newItems) {
            Construction construction = consturctionFromStream(streamItem);
            Construction newConstruction = contructionRepo.create(construction);
            CObject cobject = cobjectFromConstruction(newConstruction);            
            cobjectRepo.create(cobject);
            streamItem.setStreamStatus(StreamStatus.DISTRIBUTED_SUCCESSFULLY.getId());
            streamItem.setSuccessorId(cobject.getId());
            repo.update(streamItem.getId(), streamItem);
        }        
    }

    protected Construction consturctionFromStream(StreamConstruction streamItem) {
        Construction result = new Construction();
        String code = streamItem.getCode();
        if (code != null)
            result.setCode(code);
        String name = streamItem.getName();
        if (name != null)
            result.setName(name);        
        return result;
    }
    
    protected CObject cobjectFromConstruction(Construction constrItem) {
        CObject result = new CObject();
        String code = constrItem.getCode();
        if (code != null)
            result.setCode(code);
        String descr = constrItem.getName();
        if (descr != null)
            result.setDescr(descr);
        result.setCObjectTypeId(1);
        result.setConstructionId(constrItem.getId());
        result.setParentId(null);
        result.setNumber(null);
        return result;
    }
}
