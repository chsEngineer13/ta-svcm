package ru.gazpromproject.ta.svcm.data;

import java.util.List;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.http.HttpMethod;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriInfo;
import org.apache.olingo.server.api.uri.UriParameter;

public interface EntityStorageData {
    public Entity getSingleItem(List<UriParameter> keyParams) throws ODataApplicationException;

    public Entity getSingleItemOptions(List<UriParameter> keyParams, UriInfo uriInfo) throws ODataApplicationException;

    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity) throws ODataApplicationException;

    public Entity getRelatedSingleItem(EdmEntitySet parentSet, Entity parentEntity, List<UriParameter> keyParams)
            throws ODataApplicationException;

    public long getIdFromEntity(Entity requestEntity) throws ODataApplicationException;

    public long getIdFromParams(List<UriParameter> keyParams);

    public Entity createItem(Entity requestEntity) throws ODataApplicationException;

    public void updateItem(List<UriParameter> keyParams, Entity requestEntity, HttpMethod httpMethod)
            throws ODataApplicationException;

    public void deleteItem(List<UriParameter> keyParams) throws ODataApplicationException;

    public EntityCollection getAllItems(UriInfo uriInfo) throws ODataApplicationException;

    public EntityCollection getRelatedItems(EdmEntitySet parentSet, Entity parentEntity)
            throws ODataApplicationException;

    public EntityCollection getRelatedItemsTree(EdmNavigationProperty navProperty, Entity parentEntity, final int level)
            throws ODataApplicationException;

    public void setRelatedLink(Entity parentEntity, EdmEntitySet targetSet, Entity targetEntity)
            throws ODataApplicationException;

    public void setRelatedLinks(Entity parentEntity, EdmEntitySet targetSet, List<Entity> targetsEntity)
            throws ODataApplicationException;

    public void unsetRelatedLink(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty,
            Entity navEntity) throws ODataApplicationException;

    public void unsetRelatedLinks(EdmEntitySet parentEntitySet, Entity parentEntity, EdmNavigationProperty navProperty)
            throws ODataApplicationException;

    public String getSchemaName();
}
