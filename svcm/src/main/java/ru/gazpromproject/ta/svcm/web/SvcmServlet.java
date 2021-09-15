package ru.gazpromproject.ta.svcm.web;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.olingo.commons.api.edmx.EdmxReference;
import org.apache.olingo.server.api.OData;
import org.apache.olingo.server.api.ODataHttpHandler;
import org.apache.olingo.server.api.ServiceMetadata;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.gazpromproject.ta.svcm.repo.HeSessionFactory;
import ru.gazpromproject.ta.svcm.service.SvcmCollectionProcessor;
import ru.gazpromproject.ta.svcm.service.SvcmEdmProvider;
import ru.gazpromproject.ta.svcm.service.SvcmEntityProcessor;
import ru.gazpromproject.ta.svcm.service.SvcmPrimitiveProcessor;
import ru.gazpromproject.ta.svcm.service.SvcmReferenceProcessor;
import ru.gazpromproject.ta.svcm.sys.AccountHolder;
import ru.gazpromproject.ta.svcm.sys.CredentialsHolder;

public class SvcmServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = LoggerFactory.getLogger(SvcmServlet.class);

    protected void service(final HttpServletRequest req, final HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            // hold credentials
            CredentialsHolder.setBasicCredentils(req);
            AccountHolder.setCurrentAccount(null);
            // create odata handler and configure it with CsdlEdmProvider and Processor
            OData odata = OData.newInstance();
            ServiceMetadata edm = odata.createServiceMetadata(new SvcmEdmProvider(), new ArrayList<EdmxReference>());
            ODataHttpHandler handler = odata.createHandler(edm);
            handler.register(new SvcmCollectionProcessor());
            handler.register(new SvcmEntityProcessor());
            handler.register(new SvcmPrimitiveProcessor());
            handler.register(new SvcmReferenceProcessor());

            // let the handler do the work
            handler.process(req, resp);
        } catch (RuntimeException e) {
            LOG.error("Server Error occurred in svcm servlet", e);
            throw new ServletException(e);
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        HeSessionFactory.closeSessionFactory();
    }
}
