package ru.gazpromproject.ta.svcm.service;

import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.ContextURL;
import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.data.EntityCollection;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmEntityType;
import org.apache.olingo.commons.api.format.ContentType;
import org.apache.olingo.commons.api.http.HttpHeader;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.OData;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.ODataRequest;
import org.apache.olingo.server.api.ODataResponse;
import org.apache.olingo.server.api.ServiceMetadata;
import org.apache.olingo.server.api.processor.EntityCollectionProcessor;
import org.apache.olingo.server.api.serializer.EntityCollectionSerializerOptions;
import org.apache.olingo.server.api.serializer.ODataSerializer;
import org.apache.olingo.server.api.serializer.SerializerException;
import org.apache.olingo.server.api.serializer.SerializerResult;
import org.apache.olingo.server.api.uri.UriInfo;
import org.apache.olingo.server.api.uri.UriParameter;
import org.apache.olingo.server.api.uri.UriResource;
import org.apache.olingo.server.api.uri.UriResourceEntitySet;
import org.apache.olingo.server.api.uri.UriResourceNavigation;
import org.apache.olingo.server.api.uri.queryoption.CountOption;
import org.apache.olingo.server.api.uri.queryoption.ExpandOption;
import org.apache.olingo.server.api.uri.queryoption.SelectOption;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.data.SvcmEntityStorage;

public class SvcmCollectionProcessor implements EntityCollectionProcessor {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(SvcmCollectionProcessor.class);

    private OData odata;
    private ServiceMetadata serviceMetadata;
    private SvcmEntityStorage storage;

    public void init(OData odata, ServiceMetadata serviceMetadata) {
        this.odata = odata;
        this.serviceMetadata = serviceMetadata;
        this.storage = new SvcmEntityStorage(odata, serviceMetadata.getEdm());
    }

    public void readEntityCollection(ODataRequest request, ODataResponse response, UriInfo uriInfo,
            ContentType responseFormat) throws ODataApplicationException, SerializerException {

        // logger.info("in readCollection");

        EdmEntitySet responseEdmEntitySet = null; // for building ContextURL
        EntityCollection responseEntityCollection = null; // for the response body

        // 1st retrieve the requested EntitySet from the uriInfo
        List<UriResource> resourceParts = uriInfo.getUriResourceParts();
        int segmentCount = resourceParts.size();

        UriResource uriResource = resourceParts.get(0); // the first segment is the EntitySet
        if (!(uriResource instanceof UriResourceEntitySet)) {
            throw new ODataApplicationException("Only EntitySet is supported",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
        }

        UriResourceEntitySet uriResourceEntitySet = (UriResourceEntitySet) uriResource;
        EdmEntitySet startEdmEntitySet = uriResourceEntitySet.getEntitySet();

        if (segmentCount == 1) { // this is the case for: DemoService/DemoService.svc/Categories
            responseEdmEntitySet = startEdmEntitySet; // first (and only) entitySet
            responseEntityCollection = storage.readEntitySetData(startEdmEntitySet, uriInfo);
        } else if (segmentCount == 2) { // navigation: e.g. DemoService.svc/Categories(3)/Products
            UriResource lastSegment = resourceParts.get(1); // don't support more complex URIs
            if (lastSegment instanceof UriResourceNavigation) {
                // UriResourceNavigation uriResourceNavigation =
                // (UriResourceNavigation)lastSegment;
                // EdmNavigationProperty edmNavigationProperty =
                // uriResourceNavigation.getProperty();
                // EdmEntityType targetEntityType = edmNavigationProperty.getType();
                // responseEdmEntitySet =
                // SvcmServiceUtils.getNavigationTargetEntitySet(startEdmEntitySet,
                // edmNavigationProperty);
                responseEdmEntitySet = SvcmServiceUtils.getNavigationTargetEntitySet(uriInfo);
                // responseEdmEntitySet.getEntityType()

                // 2nd: fetch the data from backend
                // first fetch the entity where the first segment of the URI points to
                // e.g. Categories(3)/Products first find the single entity: Category(3)
                List<UriParameter> keyPredicates = uriResourceEntitySet.getKeyPredicates();
                Entity sourceEntity = storage.readEntityData(startEdmEntitySet, keyPredicates);
                // error handling for e.g. DemoService.svc/Categories(99)/Products
                if (sourceEntity == null) {
                    throw new ODataApplicationException("Entity not found.", HttpStatusCode.NOT_FOUND.getStatusCode(),
                            Locale.ROOT);
                }
                // then fetch the entity collection where the entity navigates to
                // responseEntityCollection = storage.getRelatedEntityCollection(sourceEntity,
                // targetEntityType);
                responseEntityCollection = storage.getRelatedEntityCollection(startEdmEntitySet, sourceEntity,
                        responseEdmEntitySet, uriInfo);
            }
        } else { // this would be the case for e.g. Products(1)/Category/Products
            throw new ODataApplicationException("Not supported", HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(),
                    Locale.ROOT);
        }

        // EntityCollection entityCollection = storage.readEntitySetData(edmEntitySet);
        List<Entity> entityList = responseEntityCollection.getEntities();
        EntityCollection returnEntityCollection = new EntityCollection();

        // Apply query options
        // Count
        CountOption countOption = uriInfo.getCountOption();
        if (countOption != null) {
            boolean isCount = countOption.getValue();
            if (isCount) {
                returnEntityCollection.setCount(entityList.size());
            }
        }
//        // Skip
//        SkipOption skipOption = uriInfo.getSkipOption();
//        if (skipOption != null) {
//            int skipNumber = skipOption.getValue();
//            if (skipNumber >= 0) {
//                if (skipNumber <= entityList.size()) {
//                    entityList = entityList.subList(skipNumber, entityList.size());
//                } else {
//                    // The client skipped all entities
//                    entityList.clear();
//                }
//            } else {
//                throw new ODataApplicationException("Invalid value for $skip",
//                        HttpStatusCode.BAD_REQUEST.getStatusCode(), Locale.ROOT);
//            }
//        }

//        // Top
//        TopOption topOption = uriInfo.getTopOption();
//        if (topOption != null) {
//            int topNumber = topOption.getValue();
//            if (topNumber >= 0) {
//                if (topNumber <= entityList.size()) {
//                    entityList = entityList.subList(0, topNumber);
//                } // else the client has requested more entities than available => return what we
//                  // have
//            } else {
//                throw new ODataApplicationException("Invalid value for $top",
//                        HttpStatusCode.BAD_REQUEST.getStatusCode(), Locale.ROOT);
//            }
//        }

        for (Entity entity : entityList) {
            returnEntityCollection.getEntities().add(entity);
        }

        // 3rd: apply system query options
        SelectOption selectOption = uriInfo.getSelectOption();
        String selectList = odata.createUriHelper().buildContextURLSelectList(responseEdmEntitySet.getEntityType(),
                null, selectOption);

        ExpandOption expandOption = uriInfo.getExpandOption();

        // 3rd: create and configure a serializer
        ContextURL contextUrl = ContextURL.with().entitySet(responseEdmEntitySet).selectList(selectList)
                // .suffix(Suffix.ENTITY)
                .build();
        final String id = request.getRawBaseUri() + "/" + responseEdmEntitySet.getName();
        EntityCollectionSerializerOptions opts = EntityCollectionSerializerOptions.with().contextURL(contextUrl).id(id)
                .count(countOption).select(selectOption).expand(expandOption).build();
        EdmEntityType edmEntityType = responseEdmEntitySet.getEntityType();

        ODataSerializer serializer = odata.createSerializer(responseFormat);
        // SerializerResult serializerResult =
        // serializer.entityCollectionStreamed(serviceMetadata, edmEntityType,
        // returnEntityCollection, opts)

        SerializerResult serializerResult = serializer.entityCollection(serviceMetadata, edmEntityType,
                returnEntityCollection, opts);

        // 4th: configure the response object: set the body, headers and status code
        response.setContent(serializerResult.getContent());
        response.setStatusCode(HttpStatusCode.OK.getStatusCode());
        response.setHeader(HttpHeader.CONTENT_TYPE, responseFormat.toContentTypeString());
    }
    /*
     * public void readEntityCollection1(ODataRequest request, ODataResponse
     * response, UriInfo uriInfo, ContentType responseFormat) throws
     * ODataApplicationException, SerializerException { // 1st we have retrieve the
     * requested EntitySet from the uriInfo object (representation of the parsed
     * service URI) List<UriResource> resourcePaths = uriInfo.getUriResourceParts();
     * UriResourceEntitySet uriResourceEntitySet = (UriResourceEntitySet)
     * resourcePaths.get(0); // in our example, the first segment is the EntitySet
     * EdmEntitySet edmEntitySet = uriResourceEntitySet.getEntitySet();
     * 
     * // 2nd: fetch the data from backend for this requested EntitySetName // it
     * has to be delivered as EntitySet object
     * 
     * //SvcmEntityStorage repository = new SvcmEntityStorage(); EntityCollection
     * entitySet = storage.readEntitySetData(edmEntitySet); // 3rd: create a
     * serializer based on the requested format (json) ODataSerializer serializer =
     * odata.createSerializer(responseFormat);
     * 
     * // 4th: Now serialize the content: transform from the EntitySet object to
     * InputStream EdmEntityType edmEntityType = edmEntitySet.getEntityType();
     * ContextURL contextUrl = ContextURL.with().entitySet(edmEntitySet).build();
     * 
     * final String id = request.getRawBaseUri() + "/" + edmEntitySet.getName();
     * EntityCollectionSerializerOptions opts =
     * EntityCollectionSerializerOptions.with().id(id).contextURL(contextUrl).build(
     * ); SerializerResult serializerResult =
     * serializer.entityCollection(serviceMetadata, edmEntityType, entitySet, opts);
     * InputStream serializedContent = serializerResult.getContent();
     * 
     * // Finally: configure the response object: set the body, headers and status
     * code response.setContent(serializedContent);
     * response.setStatusCode(HttpStatusCode.OK.getStatusCode());
     * response.setHeader(HttpHeader.CONTENT_TYPE,
     * responseFormat.toContentTypeString()); }
     */
}
