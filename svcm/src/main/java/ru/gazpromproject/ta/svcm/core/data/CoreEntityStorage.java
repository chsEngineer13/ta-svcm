package ru.gazpromproject.ta.svcm.core.data;

import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityStorage;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public class CoreEntityStorage extends AbstractEntityStorage {

    @Override
    public EntityStorageData getEntityStorage(EdmEntitySet edmEntitySet) throws ODataApplicationException {
        EntityStorageData dataStorage = null;
        String entitySetName = edmEntitySet.getName();
        if (entitySetName.equals(SvcmEdmCore.ES_CONSTRUCTIONS_NAME))
            dataStorage = (EntityStorageData) new ConstructionData();
        else if (entitySetName.equals(SvcmEdmCore.ES_CONSTRPARTREFS_NAME))
            dataStorage = (EntityStorageData) new ConstrPartRefData();
        else if (entitySetName.equals(SvcmEdmCore.ES_CONSTRPARTGROUPREFS_NAME))
            dataStorage = (EntityStorageData) new ConstrPartGroupRefData();
        else if (entitySetName.equals(SvcmEdmCore.ES_BUILDINGS_NAME))
            dataStorage = (EntityStorageData) new BuildingData();
        else if (entitySetName.equals(SvcmEdmCore.ES_BUILDINGGROUPS_NAME))
            dataStorage = (EntityStorageData) new BuildingGroupData();
        else if (entitySetName.equals(SvcmEdmCore.ES_MARKS_NAME))
            dataStorage = (EntityStorageData) new MarkData();
        else if (entitySetName.equals(SvcmEdmCore.ES_DEVELOPERS_NAME))
            dataStorage = (EntityStorageData) new DeveloperData();
        else if (entitySetName.equals(SvcmEdmCore.ES_OBJECTS_NAME))
            dataStorage = (EntityStorageData) new CObjectData();
        else if (entitySetName.equals(SvcmEdmCore.ES_DOCSETS_NAME))
            dataStorage = (EntityStorageData) new DocsetData();
        else if (entitySetName.equals(SvcmEdmCore.ES_CONTRACTORS_NAME))
            dataStorage = (EntityStorageData) new ContractorData();
        else if (entitySetName.equals(SvcmEdmCore.ES_CHAPTERCODES_NAME))
            dataStorage = (EntityStorageData) new ChapterCodeData();
        else if (entitySetName.equals(SvcmEdmCore.ES_DOCCODES_NAME))
            dataStorage = (EntityStorageData) new DocCodeData();
        else if (entitySetName.equals(SvcmEdmCore.ES_PHASES_NAME))
            dataStorage = (EntityStorageData) new PhaseData();
        else if (entitySetName.equals(SvcmEdmCore.ES_SUMMARYCONSTRUCTIONS_NAME))
            dataStorage = (EntityStorageData) new SummaryConstructionData();
        else if (entitySetName.equals(SvcmEdmCore.ES_WAYBILLS_NAME))
            dataStorage = (EntityStorageData) new WaybillData();
        else if (entitySetName.equals(SvcmEdmCore.ES_CONTRACTS_NAME))
            dataStorage = (EntityStorageData) new ContractData();
        else if (entitySetName.equals(SvcmEdmCore.ES_CONTRACTSTAGES_NAME))
            dataStorage = (EntityStorageData) new ContractStageData();
        else if (entitySetName.equals(SvcmEdmCore.ES_DOCUMENTS_NAME))
            dataStorage = (EntityStorageData) new DocumentData();
        else if (entitySetName.equals(SvcmEdmCore.ES_MFILES_NAME))
            dataStorage = (EntityStorageData) new MFileData();
        return dataStorage;
    }
}
