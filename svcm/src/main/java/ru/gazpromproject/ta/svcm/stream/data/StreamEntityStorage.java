package ru.gazpromproject.ta.svcm.stream.data;

import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityStorage;
import ru.gazpromproject.ta.svcm.data.EntityStorageData;
import ru.gazpromproject.ta.svcm.stream.SvcmEdmStream;

public class StreamEntityStorage extends AbstractEntityStorage {

    @Override
    public EntityStorageData getEntityStorage(EdmEntitySet edmEntitySet) throws ODataApplicationException {
        EntityStorageData entityStorage = null;
        String entitySetName = edmEntitySet.getName();
        if (entitySetName.equals(SvcmEdmStream.ES_STREAM_CONTRACTS_NAME))
            entityStorage = (EntityStorageData) new StreamContractData();
        if (entitySetName.equals(SvcmEdmStream.ES_STREAM_CONSTRUCTIONS_NAME))
            entityStorage = (EntityStorageData) new StreamConstructionData();
        if (entitySetName.equals(SvcmEdmStream.ES_STREAM_CONSTRPARTS_NAME))
            entityStorage = (EntityStorageData) new StreamConstrPartData();
        if (entitySetName.equals(SvcmEdmStream.ES_STREAM_BUILDINGS_NAME))
            entityStorage = (EntityStorageData) new StreamBuildingData();
        if (entitySetName.equals(SvcmEdmStream.ES_STREAM_DOCSETS_NAME))
            entityStorage = (EntityStorageData) new StreamDocsetData();
        return entityStorage;
    }

}
