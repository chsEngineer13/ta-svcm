package ru.gazpromproject.ta.svcm.data;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import ru.gazpromproject.ta.svcm.base.data.AbstractEntityStorage;
import ru.gazpromproject.ta.svcm.core.data.CoreEntityStorage;

import ru.gazpromproject.ta.svcm.service.*;
import ru.gazpromproject.ta.svcm.stream.data.StreamEntityStorage;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;
import ru.gazpromproject.ta.svcm.sys.data.AclAccountData;
import ru.gazpromproject.ta.svcm.sys.data.LogEventData;
import ru.gazpromproject.ta.svcm.sys.data.SysEntityStorage;
import org.apache.olingo.commons.api.Constants;
import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.data.Link;
import org.apache.olingo.commons.api.edm.Edm;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmEntityType;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.edm.EdmNavigationPropertyBinding;
import org.apache.olingo.commons.api.edm.EdmSingleton;
import org.apache.olingo.commons.api.http.HttpMethod;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.OData;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.ODataRequest;
import org.apache.olingo.server.api.deserializer.DeserializerException;
import org.apache.olingo.server.api.uri.UriInfo;
import org.apache.olingo.server.api.uri.UriParameter;
import org.apache.olingo.server.api.uri.UriResource;
import org.apache.olingo.server.api.uri.UriResourceEntitySet;
import org.apache.olingo.server.api.uri.UriResourceNavigation;
import org.apache.olingo.server.api.uri.queryoption.ExpandItem;
import org.apache.olingo.server.api.uri.queryoption.ExpandOption;
import org.apache.olingo.server.api.uri.queryoption.LevelsExpandOption;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SvcmEntityStorage {

    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(SvcmEntityStorage.class);

    private List<AbstractEntityStorage> storage_providers;
    private OData odata;
    private Edm edm;

    public static final String PERMITION_NAME_READ = "r";
    public static final String PERMITION_NAME_CREATE = "c";
    public static final String PERMITION_NAME_UPDATE = "u";
    public static final String PERMITION_NAME_DELETE = "d";
    public static final String PERMITION_NAME_LINK = "l";

    public SvcmEntityStorage(final OData odata, final Edm edm) {
        this.odata = odata;
        this.edm = edm;

        AbstractEntityStorage sys = new SysEntityStorage();
        AbstractEntityStorage core = new CoreEntityStorage();
        AbstractEntityStorage stream = new StreamEntityStorage();
        storage_providers = new ArrayList<AbstractEntityStorage>();
        storage_providers.addAll(Arrays.asList(sys, core, stream));
    }

    public Entity readEntityData(EdmEntitySet edmEntitySet, List<UriParameter> keyParams)
            throws ODataApplicationException {
        EntityStorageData dataStorage = getEntityStorage(edmEntitySet);
        String functionName = dataStorage.getSchemaName() + "." + edmEntitySet.getName() + "." + PERMITION_NAME_READ;
        checkAccountPermitions(functionName);

        Entity result = dataStorage.getSingleItem(keyParams);
        return result;
    }

    // Get target entity (apply system options)
    public Entity readEntityData(EdmEntitySet edmEntitySet, List<UriParameter> keyParams, UriInfo uriInfo)
            throws ODataApplicationException {
        Entity startEntity = readEntityData(edmEntitySet, keyParams);
        if (startEntity == null || startEntity.getId() == null) {
            return startEntity;
        }
        applySystemOptions(edmEntitySet, uriInfo, startEntity);
        return startEntity;
    }

    public EntityCollection readEntitySetData(EdmEntitySet edmEntitySet, UriInfo uriInfo)
            throws ODataApplicationException {

        EntityStorageData entityStorage = getEntityStorage(edmEntitySet);
        String functionName = entityStorage.getSchemaName() + "." + edmEntitySet.getName() + "." + PERMITION_NAME_READ;
        checkAccountPermitions(functionName);
        
        //EdmEntityType etype = edmEntitySet.getEntityType();        
        EntityCollection entityCollection = entityStorage.getAllItems(uriInfo);
        
        ExpandOption expandOption = uriInfo.getExpandOption();
        if (expandOption != null) {
            for (Entity entity : entityCollection) {
                applySystemOptions(edmEntitySet, uriInfo, entity);
            }
        }
        return entityCollection;
    }

    public EntityCollection getRelatedEntityCollection(EdmEntitySet sourceEntitySet, Entity sourceEntity,
            EdmEntitySet responseEntitySet) throws ODataApplicationException {
        EntityStorageData entityStorage = getEntityStorage(responseEntitySet);
        return entityStorage.getRelatedItems(sourceEntitySet, sourceEntity);
    }

    public EntityCollection getRelatedEntityCollection(EdmEntitySet sourceEntitySet, Entity sourceEntity,
            EdmEntitySet responseEntitySet, UriInfo uriInfo) throws ODataApplicationException {
        EntityCollection entityCollection = getRelatedEntityCollection(sourceEntitySet, sourceEntity, responseEntitySet);
        ExpandOption expandOption = uriInfo.getExpandOption();
        if (expandOption != null) {
            for (Entity entity : entityCollection) {
                applySystemOptions(responseEntitySet, uriInfo, entity);
            }
        }
        return entityCollection;
    }

    public Entity getRelatedEntity(EdmEntitySet sourceEntitySet, Entity sourceEntity, EdmEntitySet responseEntitySet)
            throws ODataApplicationException {
        EntityStorageData storage = getEntityStorage(responseEntitySet);
        return storage.getRelatedSingleItem(sourceEntitySet, sourceEntity);
    }

    public Entity getRelatedEntity(EdmEntitySet sourceEntitySet, Entity sourceEntity, EdmEntitySet responseEntitySet,
            List<UriParameter> keyParams) throws ODataApplicationException {
        EntityStorageData storage = getEntityStorage(responseEntitySet);
        return storage.getRelatedSingleItem(sourceEntitySet, sourceEntity, keyParams);
    }

    public Entity getRelatedEntity(EdmEntitySet sourceEntitySet, Entity sourceEntity, EdmEntitySet responseEntitySet,
            List<UriParameter> keyParams, UriInfo uriInfo) throws ODataApplicationException {
        Entity responseEntity = getRelatedEntity(sourceEntitySet, sourceEntity, responseEntitySet, keyParams);
        if (responseEntity == null || responseEntity.getId() == null) {
            return responseEntity;
        }
        applySystemOptions(responseEntitySet, uriInfo, responseEntity);
        return responseEntity;
    }

    public Entity createEntityData(EdmEntitySet edmEntitySet, Entity requestEntity, ODataRequest request,
            UriInfo uriInfo) throws ODataApplicationException {
        EntityStorageData mainStorage = getEntityStorage(edmEntitySet);

        String functionName = mainStorage.getSchemaName() + "." + edmEntitySet.getName() + "." + PERMITION_NAME_CREATE;
        checkAccountPermitions(functionName);

        final String rawServiceUri = request.getRawBaseUri();

        List<UriResource> resourceParts = uriInfo.getUriResourceParts();
        int segmentCount = resourceParts.size();
        Entity newEntity = null;
        if (segmentCount == 1) {
            newEntity = mainStorage.createItem(requestEntity);
        } else {
            throw new ODataApplicationException("Operation not supported",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
        }

        // Add event
        LogEventData eventData = new LogEventData();
        long tablePKID = mainStorage.getIdFromEntity(newEntity);
        String details = String.format("{\"srcName\":\"%s\",\"srcPK\":\"%s\"}", functionName, tablePKID);
        eventData.addEvent(PERMITION_NAME_CREATE, mainStorage.getSchemaName(), edmEntitySet.getName(), tablePKID, null, details,
                "Create data");

        EdmEntityType requestEntityType = edmEntitySet.getEntityType();
        // Apply binding links
        for (final Link link : requestEntity.getNavigationBindings()) {
            final EdmNavigationProperty navigationProperty = requestEntityType.getNavigationProperty(link.getTitle());
            final EdmEntitySet targetEntitySet = (EdmEntitySet) edmEntitySet.getRelatedBindingTarget(link.getTitle());
            if (navigationProperty.isCollection() && link.getBindingLinks() != null) {
                ArrayList<Entity> relatedEntities = new ArrayList<Entity>();
                for (final String bindingLink : link.getBindingLinks()) {
                    final Entity relatedEntity = readEntityByBindingLink(bindingLink, targetEntitySet, rawServiceUri);
                    relatedEntities.add(relatedEntity);
                }
                setLinks(edmEntitySet, newEntity, navigationProperty.getName(), targetEntitySet, relatedEntities);
            } else if (!navigationProperty.isCollection() && link.getBindingLink() != null) {
                final Entity relatedEntity = readEntityByBindingLink(link.getBindingLink(), targetEntitySet,
                        rawServiceUri);
                // Replace parent with child for tree structure creating requests
                if (targetEntitySet.getName().equals(edmEntitySet.getName())) {
                    setReferenceData(navigationProperty, targetEntitySet, relatedEntity, edmEntitySet, newEntity);
                } else {
                    setReferenceData(navigationProperty, edmEntitySet, newEntity, targetEntitySet, relatedEntity);    
                }                
            }
        }

        // Create nested entities
        for (final Link link : requestEntity.getNavigationLinks()) {
            final EdmNavigationProperty navigationProperty = requestEntityType.getNavigationProperty(link.getTitle());
            final EdmEntitySet nestedEntitySet = (EdmEntitySet) edmEntitySet.getRelatedBindingTarget(link.getTitle());

            if (navigationProperty.isCollection() && link.getInlineEntitySet() != null) {
                ArrayList<Entity> nestedEntities = new ArrayList<Entity>();
                for (final Entity nestedEntity : link.getInlineEntitySet().getEntities()) {
                    final Entity newNestedEntity = createEntityData(nestedEntitySet, nestedEntity, request, uriInfo);
                    nestedEntities.add(newNestedEntity);
                }
                setLinks(edmEntitySet, newEntity, navigationProperty.getName(), nestedEntitySet, nestedEntities);
            } else if (!navigationProperty.isCollection() && link.getInlineEntity() != null) {
                final Entity newNestedEntity = createEntityData(nestedEntitySet, link.getInlineEntity(), request,
                        uriInfo);
                setReferenceData(navigationProperty, edmEntitySet, newEntity, nestedEntitySet, newNestedEntity);
            }
        }
        
        return newEntity;
    }

    public void updateEntityData(EdmEntitySet edmEntitySet, List<UriParameter> keyParams, Entity requestEntity,
            HttpMethod httpMethod) throws ODataApplicationException {
        EntityStorageData dataStorage = getEntityStorage(edmEntitySet);
        String functionName = dataStorage.getSchemaName() + "." + edmEntitySet.getName() + "." + PERMITION_NAME_UPDATE;
        checkAccountPermitions(functionName);
        dataStorage.updateItem(keyParams, requestEntity, httpMethod);

        // Add event
        LogEventData eventData = new LogEventData();
        long tablePKID = dataStorage.getIdFromParams(keyParams);
        String details = String.format("{\"srcName\":\"%s\",\"srcPK\":\"%s\"}", functionName, tablePKID);
        eventData.addEvent(PERMITION_NAME_UPDATE, dataStorage.getSchemaName(), edmEntitySet.getName(), tablePKID, null, details,
                "Update data");
    }

    public void deleteEntityData(EdmEntitySet edmEntitySet, List<UriParameter> keyParams)
            throws ODataApplicationException {
        EntityStorageData dataStorage = getEntityStorage(edmEntitySet);
        String functionName = dataStorage.getSchemaName() + "." + edmEntitySet.getName() + "." + PERMITION_NAME_DELETE;
        checkAccountPermitions(functionName);
        dataStorage.deleteItem(keyParams);

        // Add event
        LogEventData eventData = new LogEventData();
        long tablePKID = dataStorage.getIdFromParams(keyParams);
        String details = String.format("{\"srcName\":\"%s\",\"srcPK\":\"%s\"}", functionName, tablePKID);
        eventData.addEvent(PERMITION_NAME_DELETE, dataStorage.getSchemaName(), edmEntitySet.getName(), tablePKID, null, details,
                "Delete data");

    }

    public Entity readSingletoneData(EdmSingleton singleton) throws ODataApplicationException {
        if (singleton.getName().equals(SvcmEdmSys.ST_ME_NAME)) {
            AclAccountData storage = new AclAccountData();
            return storage.getMe();
        }
        return null;
    }
    
    public void setReferenceData(
            final EdmNavigationProperty navigationProperty,
            final EdmEntitySet srcEntitySet,
            final Entity srcEntity,
            final EdmEntitySet destEntitySet,
            final Entity destEntity
            ) throws ODataApplicationException {

        EntityStorageData srcDataStorage = getEntityStorage(srcEntitySet);
        EntityStorageData destDataStorage = getEntityStorage(destEntitySet);

        String srcFunctionName = srcDataStorage.getSchemaName() + "." + srcEntitySet.getName() + "." + PERMITION_NAME_LINK;
        checkAccountPermitions(srcFunctionName);
        String destFunctionName = srcDataStorage.getSchemaName() + "." + destEntitySet.getName() + "." + PERMITION_NAME_LINK;
        checkAccountPermitions(destFunctionName);

        String srcDetails = "{"
                + "\"Operation\":\"%s\","
                + "\"scrName\":\"%s\","
                + "\"scrPK\":\"%s\","
                + "\"destName\":\"%s\","
                + "\"destPK\":\"%s\""
                + "}";

        String details = String.format(srcDetails,
                "Create link",
                srcFunctionName,
                srcDataStorage.getIdFromEntity(srcEntity),
                destFunctionName,
                destDataStorage.getIdFromEntity(destEntity)
                );

        setLink(srcEntitySet, srcEntity, navigationProperty.getName(), destEntitySet, destEntity);

        final EdmNavigationProperty partnerNavigationProperty = navigationProperty.getPartner();
        if (partnerNavigationProperty != null) {
            setLink(destEntitySet, destEntity, partnerNavigationProperty.getName(), srcEntitySet, srcEntity);
        }
        // Add event
        LogEventData eventData = new LogEventData();
        eventData.addEvent(PERMITION_NAME_LINK, srcDataStorage.getSchemaName(), srcEntitySet.getName(),(long) 0, null, details,
                "Create link");
    }

    public void unsetReferenceData(
            final EdmNavigationProperty navigationProperty,
            final EdmEntitySet parentEntitySet,
            final Entity parentEntity,
            final EdmEntitySet navEntitySet,
            final Entity navEntity
            ) throws ODataApplicationException {

        EntityStorageData srcDataStorage = getEntityStorage(parentEntitySet);
        EntityStorageData destDataStorage = getEntityStorage(navEntitySet);

        String srcFunctionName = srcDataStorage.getSchemaName() + "." + parentEntitySet.getName() + "." + PERMITION_NAME_LINK;
        checkAccountPermitions(srcFunctionName);
        String destFunctionName = destDataStorage.getSchemaName() + "." + navEntitySet.getName() + "." + PERMITION_NAME_LINK;
        checkAccountPermitions(destFunctionName);

        destDataStorage.unsetRelatedLink(parentEntitySet, parentEntity, navigationProperty, navEntity);

        final EdmNavigationProperty partnerNavigationProperty = navigationProperty.getPartner();
        if (partnerNavigationProperty != null) {
            srcDataStorage.unsetRelatedLink(navEntitySet, navEntity, partnerNavigationProperty, parentEntity);
        }

        // Add event
        String srcDetails = "{"
                + "\"Operation\":\"%s\","
                + "\"scrName\":\"%s\","
                + "\"scrPK\":\"%s\","
                + "\"destName\":\"%s\","
                + "\"destPK\":\"%s\""
                + "}";
        String details = String.format(srcDetails,
                "Delete link",
                srcFunctionName,
                srcDataStorage.getIdFromEntity(parentEntity),
                destFunctionName,
                destDataStorage.getIdFromEntity(navEntity)
                );
        LogEventData eventData = new LogEventData();
        eventData.addEvent(PERMITION_NAME_LINK, srcDataStorage.getSchemaName(), parentEntitySet.getName(), (long) 0, null, details,
                "Delete link");
    }

    public void applySystemOptions(EdmEntitySet edmEntitySet, UriInfo uriInfo, Entity entity)
            throws ODataApplicationException {
        ExpandOption expandOption = uriInfo.getExpandOption();
        if (expandOption != null) {
            // logger.info("Process ExpandOption");
            // logger.info(String.format("expandEntitySet: %s", edmEntitySet.getName()));
            List<EdmNavigationPropertyBinding> bindings = edmEntitySet.getNavigationPropertyBindings();
            if (!bindings.isEmpty()) {
                for (ExpandItem expandItem : expandOption.getExpandItems()) {
                    UriResource uriResource = expandItem.getResourcePath().getUriResourceParts().get(0);
                    // logger.info(uriResource.toString());
                    if (uriResource instanceof UriResourceNavigation) {
                        // logger.info("Is navigation instance");
                        EdmNavigationProperty expandProperty = ((UriResourceNavigation) uriResource).getProperty();
                        EdmEntitySet expandEntitySet = SvcmServiceUtils.getNavigationTargetEntitySet(edmEntitySet,
                                expandProperty);
                        // logger.info(String.format("expandEntitySet: %s", expandEntitySet.getName()));

                        if (expandProperty.isCollection()) {
                            LevelsExpandOption levelsOption = expandItem.getLevelsOption();
                            EntityCollection expandEntityCollection = null;
                            if (levelsOption == null || levelsOption.getValue() < 2) {
                                expandEntityCollection = getRelatedEntityCollection(edmEntitySet, entity,
                                        expandEntitySet);
                            } else {
                                EntityStorageData entityStorage = getEntityStorage(edmEntitySet);
                                final int expandLevel = levelsOption.getValue();
                                expandEntityCollection = entityStorage.getRelatedItemsTree(expandProperty, entity,
                                        expandLevel);
                            }
                            if (expandEntityCollection != null) {
                                // logger.info(String.format("Set inline property: %s %d",
                                // expandProperty.getName(), expandEntityCollection.getEntities().size()));
                                Link link = new Link();
                                link.setTitle(expandProperty.getName());
                                link.setInlineEntitySet(expandEntityCollection);
                                entity.getNavigationLinks().add(link);
                            }
                        } else {
                            // logger.info(String.format("expandEntitySet: %s", expandEntitySet.getName()));
                            // logger.info("Expand single");
                            Entity expandEntity = getRelatedEntity(edmEntitySet, entity, expandEntitySet);
                            if (expandEntity != null) {
                                Link link = new Link();
                                link.setTitle(expandProperty.getName());
                                link.setInlineEntity(expandEntity);
                                entity.getNavigationLinks().add(link);
                            }
                        }
                    }
                }
            }
        }
    }

    private void checkAccountPermitions(String functionName) throws ODataApplicationException {
        AclAccountData accountData = new AclAccountData();
        Boolean hasPermition = accountData.hasFunction(functionName);

        if (!hasPermition) {
            throw new ODataApplicationException(String.format("Access denided. Check permitions: %s", functionName),
                    HttpStatusCode.FORBIDDEN.getStatusCode(), Locale.ENGLISH);
        }
    }

    private Entity readEntityByBindingLink(final String entityId, final EdmEntitySet edmEntitySet,
            final String rawServiceUri) throws ODataApplicationException {
        UriResourceEntitySet entitySetResource = null;
        try {
            entitySetResource = odata.createUriHelper().parseEntityId(edm, entityId, rawServiceUri);
            if (!entitySetResource.getEntitySet().getName().equals(edmEntitySet.getName())) {
                throw new ODataApplicationException(
                        "Expected entity-id for entity set " + edmEntitySet.getName() + " but found id for entity set "
                                + entitySetResource.getEntitySet().getName(),
                        HttpStatusCode.BAD_REQUEST.getStatusCode(), Locale.ENGLISH);
            }
        } catch (DeserializerException e) {
            throw new ODataApplicationException(entityId + " is not valid entity-Id",
                    HttpStatusCode.BAD_REQUEST.getStatusCode(), Locale.ENGLISH);
        }
        return readEntityData(entitySetResource.getEntitySet(), entitySetResource.getKeyPredicates());
    }

    private EntityStorageData getEntityStorage(EdmEntitySet edmEntitySet) throws ODataApplicationException {
        for (AbstractEntityStorage provider : storage_providers) {
            EntityStorageData st = provider.getEntityStorage(edmEntitySet);
            if (st != null)
                return st;
        }
        throw new ODataApplicationException(
                String.format("Storage backend for entity set '%s' not implemented.", edmEntitySet.getName()),
                HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
    }

    private void setLink(final EdmEntitySet entitySet, final Entity entity, final String navigationPropertyName,
            final EdmEntitySet targetSet, final Entity target) throws ODataApplicationException {        
        EntityStorageData dataStorage = getEntityStorage(entitySet);
        dataStorage.setRelatedLink(entity, targetSet, target);

        Link link = entity.getNavigationLink(navigationPropertyName);
        if (link == null) {
            link = new Link();
            link.setRel(Constants.NS_NAVIGATION_LINK_REL + navigationPropertyName);
            link.setType(Constants.ENTITY_NAVIGATION_LINK_TYPE);
            link.setTitle(navigationPropertyName);
            link.setHref(target.getId().toASCIIString());

            entity.getNavigationLinks().add(link);
        }
        link.setInlineEntity(target);
    }

    private void setLinks(final EdmEntitySet entitySet, final Entity entity, final String navigationPropertyName,
            final EdmEntitySet targetSet, final List<Entity> targets) throws ODataApplicationException {
        EntityStorageData dataStorage = getEntityStorage(entitySet);
        dataStorage.setRelatedLinks(entity, targetSet, targets);
        
        Link link = entity.getNavigationLink(navigationPropertyName);
        if (link == null) {
            link = new Link();
            link.setRel(Constants.NS_NAVIGATION_LINK_REL + navigationPropertyName);
            link.setType(Constants.ENTITY_SET_NAVIGATION_LINK_TYPE);
            link.setTitle(navigationPropertyName);
            link.setHref(entity.getId().toASCIIString() + "/" + navigationPropertyName);

            EntityCollection target = new EntityCollection();
            target.getEntities().addAll(targets);
            link.setInlineEntitySet(target);

            entity.getNavigationLinks().add(link);
        } else {
            link.getInlineEntitySet().getEntities().addAll(targets);
        }
    }
}
