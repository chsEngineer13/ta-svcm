package ru.gazpromproject.ta.svcm.service;

import java.io.InputStream;
import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.ContextURL;
import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmEntityType;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.edm.EdmSingleton;
import org.apache.olingo.commons.api.format.ContentType;
import org.apache.olingo.commons.api.http.HttpHeader;
import org.apache.olingo.commons.api.http.HttpMethod;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.OData;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.ODataRequest;
import org.apache.olingo.server.api.ODataResponse;
import org.apache.olingo.server.api.ServiceMetadata;
import org.apache.olingo.server.api.deserializer.DeserializerException;
import org.apache.olingo.server.api.deserializer.DeserializerResult;
import org.apache.olingo.server.api.deserializer.ODataDeserializer;
import org.apache.olingo.server.api.processor.EntityProcessor;
import org.apache.olingo.server.api.serializer.EntitySerializerOptions;
import org.apache.olingo.server.api.serializer.ODataSerializer;
import org.apache.olingo.server.api.serializer.SerializerException;
import org.apache.olingo.server.api.serializer.SerializerResult;
import org.apache.olingo.server.api.uri.UriInfo;
import org.apache.olingo.server.api.uri.UriParameter;
import org.apache.olingo.server.api.uri.UriResource;
import org.apache.olingo.server.api.uri.UriResourceEntitySet;
import org.apache.olingo.server.api.uri.UriResourceNavigation;
import org.apache.olingo.server.api.uri.UriResourceSingleton;
import org.apache.olingo.server.api.uri.queryoption.ExpandOption;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.data.SvcmEntityStorage;

public class SvcmEntityProcessor implements EntityProcessor {
    private static final Logger logger = LoggerFactory.getLogger(SvcmEntityProcessor.class);

    private OData odata;
    private ServiceMetadata serviceMetadata;
    private SvcmEntityStorage storage;

    @Override
    public void init(OData odata, ServiceMetadata serviceMetadata) {
        this.odata = odata;
        this.serviceMetadata = serviceMetadata;
        this.storage = new SvcmEntityStorage(odata, serviceMetadata.getEdm());
    }

    @Override
    public void createEntity(ODataRequest request, ODataResponse response, UriInfo uriInfo, ContentType requestFormat,
            ContentType responseFormat) throws ODataApplicationException, DeserializerException, SerializerException {
        // 1. Retrieve the entity type from the URI
        EdmEntitySet edmEntitySet = SvcmServiceUtils.getEdmEntitySet(uriInfo);
        EdmEntityType edmEntityType = edmEntitySet.getEntityType();

        // 2. create the data in backend
        // 2.1. retrieve the payload from the POST request for the entity to create and
        // deserialize it
        InputStream requestInputStream = request.getBody();
        ODataDeserializer deserializer = this.odata.createDeserializer(requestFormat);
        DeserializerResult result = deserializer.entity(requestInputStream, edmEntityType);
         Entity requestEntity = result.getEntity();
        // 2.2 do the creation in backend, which returns the newly created entity
        // SvcmEntityStorage entityRepository = new SvcmEntityStorage();
        Entity createdEntity = storage.createEntityData(edmEntitySet, requestEntity, request, uriInfo);

        // 3. serialize the response (we have to return the created entity)
        ContextURL contextUrl = ContextURL.with().entitySet(edmEntitySet).build();
        // expand and select currently not supported
        EntitySerializerOptions options = EntitySerializerOptions.with().contextURL(contextUrl).build();

        ODataSerializer serializer = this.odata.createSerializer(responseFormat);
        SerializerResult serializedResponse = serializer.entity(serviceMetadata, edmEntityType, createdEntity, options);

        // 4. configure the response object
        response.setContent(serializedResponse.getContent());
        response.setStatusCode(HttpStatusCode.CREATED.getStatusCode());
        response.setHeader(HttpHeader.CONTENT_TYPE, responseFormat.toContentTypeString());
    }

    @Override
    public void deleteEntity(ODataRequest request, ODataResponse response, UriInfo uriInfo)
            throws ODataApplicationException {
        // 1. Retrieve the entity set which belongs to the requested entity
        List<UriResource> resourcePaths = uriInfo.getUriResourceParts();
        // Note: only in our example we can assume that the first segment is the
        // EntitySet
        UriResourceEntitySet uriResourceEntitySet = (UriResourceEntitySet) resourcePaths.get(0);
        EdmEntitySet edmEntitySet = uriResourceEntitySet.getEntitySet();

        // 2. delete the data in backend
        List<UriParameter> keyPredicates = uriResourceEntitySet.getKeyPredicates();
        // SvcmEntityStorage entityRepository = new SvcmEntityStorage();
        storage.deleteEntityData(edmEntitySet, keyPredicates);

        // 3. configure the response object
        response.setStatusCode(HttpStatusCode.NO_CONTENT.getStatusCode());
    }

    @Override
    public void updateEntity(ODataRequest request, ODataResponse response, UriInfo uriInfo, ContentType requestFormat,
            ContentType responseFormat) throws ODataApplicationException, DeserializerException, SerializerException {
        // 1. Retrieve the entity set which belongs to the requested entity
        List<UriResource> resourcePaths = uriInfo.getUriResourceParts();
        // Note: only in our example we can assume that the first segment is the
        // EntitySet
        UriResourceEntitySet uriResourceEntitySet = (UriResourceEntitySet) resourcePaths.get(0);
        EdmEntitySet edmEntitySet = uriResourceEntitySet.getEntitySet();
        EdmEntityType edmEntityType = edmEntitySet.getEntityType();
        // 2. update the data in backend
        // 2.1. retrieve the payload from the PUT request for the entity to be updated
        InputStream requestInputStream = request.getBody();
        ODataDeserializer deserializer = this.odata.createDeserializer(requestFormat);
        DeserializerResult result = deserializer.entity(requestInputStream, edmEntityType);
        Entity requestEntity = result.getEntity();
        // 2.2 do the modification in backend
        List<UriParameter> keyPredicates = uriResourceEntitySet.getKeyPredicates();
        // Note that this updateEntity()-method is invoked for both PUT or PATCH
        // operations
        HttpMethod httpMethod = request.getMethod();
        // SvcmEntityStorage entityRepository = new SvcmEntityStorage();
        storage.updateEntityData(edmEntitySet, keyPredicates, requestEntity, httpMethod);
        // 3. configure the response object
        response.setStatusCode(HttpStatusCode.NO_CONTENT.getStatusCode());
    }

    /*
     * @Override public void readEntity(ODataRequest request, ODataResponse
     * response, UriInfo uriInfo, ContentType responseFormat) throws
     * ODataApplicationException, SerializerException { final UriResource
     * firstResourceSegment = uriInfo.getUriResourceParts().get(0);
     * 
     * if (firstResourceSegment instanceof UriResourceEntitySet) {
     * readEntitySetResource(request, response, uriInfo, responseFormat); } else if
     * (firstResourceSegment instanceof UriResourceSingleton) {
     * readEntitySingletonResource(request, response, uriInfo, responseFormat); }
     * else { throw new ODataApplicationException("Not implemented",
     * HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH); } }
     */

    @Override
    public void readEntity(ODataRequest request, ODataResponse response, UriInfo uriInfo, ContentType responseFormat)
            throws ODataApplicationException, SerializerException {
        // logger.info("in readEntity");

        EdmEntitySet responseEntitySet = null;
        EdmEntityType responseEntityType = null;
        Entity responseEntity = null;
        ContextURL responseContextUrl = null;

        List<UriResource> resourceParts = uriInfo.getUriResourceParts();
        UriResource startResource = resourceParts.get(0);

        EdmEntitySet startEntitySet = null;
        EdmEntityType startEntityType = null;
        Entity startEntity = null;
        ContextURL startContextUrl = null;

        if (startResource instanceof UriResourceEntitySet) {
            UriResourceEntitySet entitySetResource = (UriResourceEntitySet) startResource;
            startEntitySet = entitySetResource.getEntitySet();

            List<UriParameter> keyPredicates = entitySetResource.getKeyPredicates();
            startEntity = storage.readEntityData(startEntitySet, keyPredicates);

            startEntityType = startEntitySet.getEntityType();
            startContextUrl = ContextURL.with().entitySet(startEntitySet).build();
        } else if (startResource instanceof UriResourceSingleton) {
            UriResourceSingleton singletonResource = (UriResourceSingleton) startResource;
            EdmSingleton edmSingleton = singletonResource.getSingleton();
            startEntityType = edmSingleton.getEntityType();
            final EdmEntityType singletoneEntityType = edmSingleton.getEntityType();
            startEntitySet = edmSingleton.getEntityContainer().getEntitySets().stream()
                    .filter(etset -> etset.getEntityType().equals(singletoneEntityType)).findFirst().get();

            startEntity = storage.readSingletoneData(edmSingleton);
            startContextUrl = ContextURL.with().entitySetOrSingletonOrType(edmSingleton.getName()).build();
        } else {
            throw new ODataApplicationException("Only EntitySet & Singleton is supported.",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
        }

        if (startEntity == null) {
            throw new ODataApplicationException("Entity not found.", HttpStatusCode.NOT_FOUND.getStatusCode(),
                    Locale.ROOT);
        }

        int segmentCount = resourceParts.size();
        if (segmentCount == 1) {
            // logger.info("One segment");
            responseEntityType = startEntityType;
            responseEntity = startEntity;
            responseEntitySet = startEntitySet;
            storage.applySystemOptions(responseEntitySet, uriInfo, responseEntity);
            responseContextUrl = startContextUrl;
        } else if (segmentCount == 2) {
            // logger.info("Two segments");
            UriResource navSegment = resourceParts.get(1);
            if (navSegment instanceof UriResourceNavigation) {
                UriResourceNavigation navResource = (UriResourceNavigation) navSegment;
                EdmNavigationProperty navProperty = navResource.getProperty();
                // responseEntityType = navProperty.getType();
                // logger.info("Nav - startEntitySet: %s", startEntitySet.getName());
                // logger.info("Nav - navProperty: %s", navProperty.getName());
                if (!navProperty.containsTarget()) {
                    // contextURL displays the last segment
                    responseEntitySet = SvcmServiceUtils.getNavigationTargetEntitySet(startEntitySet, navProperty);
                } else {
                    responseEntitySet = startEntitySet;
                }

                // logger.info("ResponseEntitySet.Name: %s", responseEntitySet.getName());
                List<UriParameter> navKeyPredicates = navResource.getKeyPredicates();

                if (navKeyPredicates.isEmpty()) {
                    responseEntity = storage.getRelatedEntity(startEntitySet, startEntity, responseEntitySet);
                } else {
                    responseEntity = storage.getRelatedEntity(startEntitySet, startEntity, responseEntitySet,
                            navKeyPredicates, uriInfo);
                }

                if (responseEntity == null) {
                    throw new ODataApplicationException("Entity not found.", HttpStatusCode.NOT_FOUND.getStatusCode(),
                            Locale.ROOT);
                } else {
                    logger.info("Got NON null related item.");
                }

                responseContextUrl = ContextURL.with().entitySet(responseEntitySet).build();
                responseEntityType = responseEntitySet.getEntityType();
            }
        } else {
            throw new ODataApplicationException("Not supported", HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(),
                    Locale.ROOT);
        }

        ExpandOption expandOption = uriInfo.getExpandOption();

        ODataSerializer serializer = odata.createSerializer(responseFormat);

        // Prepare response
        // ContextURL contextUrl =
        // ContextURL.with().entitySetOrSingletonOrType(edmSingleton.getName()).build();
        EntitySerializerOptions opts = EntitySerializerOptions.with().contextURL(responseContextUrl)
                .expand(expandOption).build();
        SerializerResult serializerResult = serializer.entity(serviceMetadata, responseEntityType, responseEntity,
                opts);

        // Make response
        response.setContent(serializerResult.getContent());
        response.setStatusCode(HttpStatusCode.OK.getStatusCode());
        response.setHeader(HttpHeader.CONTENT_TYPE, responseFormat.toContentTypeString());
    }

    /*
     * public void readEntitySetResource(ODataRequest request, ODataResponse
     * response, UriInfo uriInfo, ContentType responseFormat) throws
     * ODataApplicationException, SerializerException { // 1. retrieve the Entity
     * Type List<UriResource> resourcePaths = uriInfo.getUriResourceParts(); //
     * Note: only in our example we can assume that the first segment is the
     * EntitySet UriResourceEntitySet uriResourceEntitySet = (UriResourceEntitySet)
     * resourcePaths.get(0); EdmEntitySet edmEntitySet =
     * uriResourceEntitySet.getEntitySet();
     * 
     * // 2. retrieve the data from backend List<UriParameter> keyPredicates =
     * uriResourceEntitySet.getKeyPredicates(); SvcmEntityStorage entityRepository =
     * new SvcmEntityStorage(); Entity entity =
     * entityRepository.readEntityData(edmEntitySet, keyPredicates);
     * 
     * // 3. serialize EdmEntityType entityType = edmEntitySet.getEntityType();
     * 
     * ContextURL contextUrl = ContextURL.with().entitySet(edmEntitySet).build(); //
     * expand and select currently not supported EntitySerializerOptions options =
     * EntitySerializerOptions.with().contextURL(contextUrl).build();
     * 
     * ODataSerializer serializer = odata.createSerializer(responseFormat);
     * SerializerResult serializerResult = serializer.entity(serviceMetadata,
     * entityType, entity, options); InputStream entityStream =
     * serializerResult.getContent();
     * 
     * //4. configure the response object response.setContent(entityStream);
     * response.setStatusCode(HttpStatusCode.OK.getStatusCode());
     * response.setHeader(HttpHeader.CONTENT_TYPE,
     * responseFormat.toContentTypeString()); }
     * 
     * public void readEntitySingletonResource(ODataRequest request, ODataResponse
     * response, UriInfo uriInfo, ContentType responseFormat) throws
     * ODataApplicationException, SerializerException { // 1st we have retrieve the
     * requested EntitySet from the uriInfo object (representation of the parsed
     * service URI) List<UriResource> resourcePaths = uriInfo.getUriResourceParts();
     * UriResourceSingleton uriResourceSingleton = (UriResourceSingleton)
     * resourcePaths.get(0); EdmSingleton edmSingleton =
     * uriResourceSingleton.getSingleton();
     * 
     * // 2nd: fetch the data from backend for this requested EntitySetName // it
     * has to be delivered as EntitySet object
     * 
     * SvcmEntityStorage repository = new SvcmEntityStorage(); Entity resultEntity =
     * repository.readSingletoneData(edmSingleton); // 3rd: create a serializer
     * based on the requested format (json) ODataSerializer serializer =
     * odata.createSerializer(responseFormat);
     * 
     * // 4th: Now serialize the content: transform from the EntitySet object to
     * InputStream EdmEntityType edmEntityType = edmSingleton.getEntityType();
     * ContextURL contextUrl =
     * ContextURL.with().entitySetOrSingletonOrType(edmSingleton.getName()).build();
     * 
     * EntitySerializerOptions opts =
     * EntitySerializerOptions.with().contextURL(contextUrl).build();
     * SerializerResult serializerResult = serializer.entity(serviceMetadata,
     * edmEntityType, resultEntity, opts); InputStream serializedContent =
     * serializerResult.getContent();
     * 
     * // Finally: configure the response object: set the body, headers and status
     * code response.setContent(serializedContent);
     * response.setStatusCode(HttpStatusCode.OK.getStatusCode());
     * response.setHeader(HttpHeader.CONTENT_TYPE,
     * responseFormat.toContentTypeString()); }
     */
}
