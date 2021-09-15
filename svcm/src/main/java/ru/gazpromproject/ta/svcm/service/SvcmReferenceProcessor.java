package ru.gazpromproject.ta.svcm.service;

import java.io.InputStream;
import java.net.URI;
import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.data.Entity;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.format.ContentType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.OData;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.ODataLibraryException;
import org.apache.olingo.server.api.ODataRequest;
import org.apache.olingo.server.api.ODataResponse;
import org.apache.olingo.server.api.ServiceMetadata;
import org.apache.olingo.server.api.deserializer.DeserializerResult;
import org.apache.olingo.server.api.deserializer.ODataDeserializer;
import org.apache.olingo.server.api.processor.ReferenceProcessor;
import org.apache.olingo.server.api.uri.UriHelper;
import org.apache.olingo.server.api.uri.UriInfo;
import org.apache.olingo.server.api.uri.UriParameter;
import org.apache.olingo.server.api.uri.UriResource;
import org.apache.olingo.server.api.uri.UriResourceEntitySet;
import org.apache.olingo.server.api.uri.UriResourceNavigation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.data.SvcmEntityStorage;

public class SvcmReferenceProcessor implements ReferenceProcessor {
	
	@SuppressWarnings("unused")
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
	public void readReference(ODataRequest request, ODataResponse response, UriInfo uriInfo, ContentType responseFormat)
			throws ODataApplicationException, ODataLibraryException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void createReference(ODataRequest request, ODataResponse response, UriInfo uriInfo,
			ContentType requestFormat) throws ODataApplicationException, ODataLibraryException {
        List<UriResource> resourcePaths = uriInfo.getUriResourceParts();
        
        // Check if parent entity exists
        UriResource parentSegment = resourcePaths.get(0);
        EdmEntitySet parentEntitySet = null;
        Entity parentEntity = null;
        if (parentSegment instanceof UriResourceEntitySet) {
            UriResourceEntitySet entitySetResource = (UriResourceEntitySet) parentSegment;
            parentEntitySet = entitySetResource.getEntitySet();

            List<UriParameter> keyPredicates = entitySetResource.getKeyPredicates();
            parentEntity = storage.readEntityData(parentEntitySet, keyPredicates);
        } else {
            throw new ODataApplicationException("Create reference only available for entity set",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
        }
        
        if (parentEntity == null) {
            throw new ODataApplicationException("Entity not found.",
                    HttpStatusCode.NOT_FOUND.getStatusCode(), Locale.ROOT);
        }
        
        // Check if navigation property exists
        UriResource navSegment = resourcePaths.get(1);
        EdmEntitySet navEntitySet = null;
        Entity navEntity = null;
        if (navSegment instanceof UriResourceNavigation) {
            UriResourceNavigation navResource = (UriResourceNavigation) navSegment;
            EdmNavigationProperty navProperty = navResource.getProperty();
            navEntitySet = SvcmServiceUtils.getNavigationTargetEntitySet(parentEntitySet, navProperty);
            
            // Get links
            InputStream requestInputStream = request.getBody();
            ODataDeserializer deserializer = this.odata.createDeserializer(requestFormat);
            DeserializerResult result = deserializer.entityReferences(requestInputStream);
            List<URI> refLinks = result.getEntityReferences();
            
            String emptyString = "";
            UriHelper helper = odata.createUriHelper();            
            for (URI link : refLinks) {
                UriResourceEntitySet navEntitySetResource = helper
                        .parseEntityId(serviceMetadata.getEdm(), link.toString(), emptyString);                
                List<UriParameter> navKeyPredicates = navEntitySetResource.getKeyPredicates();
                navEntity = storage.readEntityData(navEntitySet, navKeyPredicates);
                if (navEntity != null) {
                    storage.setReferenceData(navProperty, parentEntitySet, parentEntity, navEntitySet, navEntity);
                } else {
                    throw new ODataApplicationException("Ref entity not found",
                            HttpStatusCode.NOT_FOUND.getStatusCode(), Locale.ROOT);
                }
            }                      
        } else {
            throw new ODataApplicationException("Navigation segment not found.",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
        }        
        response.setStatusCode(HttpStatusCode.NO_CONTENT.getStatusCode());
	}

	@Override
	public void updateReference(ODataRequest request, ODataResponse response, UriInfo uriInfo,
			ContentType requestFormat) throws ODataApplicationException, ODataLibraryException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReference(ODataRequest request, ODataResponse response, UriInfo uriInfo)
			throws ODataApplicationException, ODataLibraryException {	
		List<UriResource> resourcePaths = uriInfo.getUriResourceParts();
	
		// Check if parent entity exists
		UriResource parentSegment = resourcePaths.get(0);
        EdmEntitySet parentEntitySet = null;
        Entity parentEntity = null;
		if (parentSegment instanceof UriResourceEntitySet) {
            UriResourceEntitySet entitySetResource = (UriResourceEntitySet) parentSegment;
            parentEntitySet = entitySetResource.getEntitySet();

            List<UriParameter> keyPredicates = entitySetResource.getKeyPredicates();
            parentEntity = storage.readEntityData(parentEntitySet, keyPredicates);
		} else {
		    throw new ODataApplicationException("Delete reference only available for entity set.",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
		}
		
        if (parentEntity == null) {
            throw new ODataApplicationException("Entity not found.",
                    HttpStatusCode.NOT_FOUND.getStatusCode(), Locale.ROOT);
        }
        
        // Check if navigation property exists
        UriResource navSegment = resourcePaths.get(1);
        EdmEntitySet navEntitySet = null;
        Entity navEntity = null;
        if (navSegment instanceof UriResourceNavigation) {
            UriResourceNavigation navResource = (UriResourceNavigation) navSegment;
            EdmNavigationProperty navProperty = navResource.getProperty();
            navEntitySet = SvcmServiceUtils.getNavigationTargetEntitySet(parentEntitySet, navProperty);
            List<UriParameter> navKeyPredicates = navResource.getKeyPredicates();
            
            if (navKeyPredicates.isEmpty()) {
                navEntity = storage.getRelatedEntity(parentEntitySet, parentEntity, navEntitySet);
            } else {
                navEntity = storage.getRelatedEntity(parentEntitySet, parentEntity, navEntitySet,
                        navKeyPredicates, uriInfo);
            }

            if (navEntity == null) {
                throw new ODataApplicationException("Reference between entities not found.",
                        HttpStatusCode.NOT_FOUND.getStatusCode(), Locale.ROOT);
            }
            // Actually unset link
            storage.unsetReferenceData(navProperty, parentEntitySet, parentEntity, navEntitySet, navEntity);
        } else {
            throw new ODataApplicationException("Navigation segment not found.",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
        }        
		response.setStatusCode(HttpStatusCode.NO_CONTENT.getStatusCode());
	}
}
