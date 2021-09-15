package ru.gazpromproject.ta.svcm.service;

import org.apache.olingo.commons.api.format.ContentType;
import org.apache.olingo.server.api.OData;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.ODataLibraryException;
import org.apache.olingo.server.api.ODataRequest;
import org.apache.olingo.server.api.ODataResponse;
import org.apache.olingo.server.api.ServiceMetadata;
import org.apache.olingo.server.api.processor.ReferenceCollectionProcessor;
import org.apache.olingo.server.api.uri.UriInfo;

public class SvcmReferenceCollectionProcessor implements ReferenceCollectionProcessor {

	public SvcmReferenceCollectionProcessor() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void init(OData odata, ServiceMetadata serviceMetadata) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void readReferenceCollection(ODataRequest request, ODataResponse response, UriInfo uriInfo,
			ContentType responseFormat) throws ODataApplicationException, ODataLibraryException {
		// TODO Auto-generated method stub
		
	}

}
