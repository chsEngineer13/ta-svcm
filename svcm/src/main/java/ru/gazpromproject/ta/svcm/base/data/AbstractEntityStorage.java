package ru.gazpromproject.ta.svcm.base.data;

import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.data.EntityStorageData;

public abstract class AbstractEntityStorage {
    public abstract EntityStorageData getEntityStorage(EdmEntitySet edmEntitySet) throws ODataApplicationException;
}
