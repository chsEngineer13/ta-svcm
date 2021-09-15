package ru.gazpromproject.ta.svcm.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.olingo.commons.api.edm.FullQualifiedName;
import org.apache.olingo.commons.api.edm.provider.CsdlAbstractEdmProvider;
import org.apache.olingo.commons.api.edm.provider.CsdlEntityContainer;
import org.apache.olingo.commons.api.edm.provider.CsdlEntityContainerInfo;
import org.apache.olingo.commons.api.edm.provider.CsdlEntitySet;
import org.apache.olingo.commons.api.edm.provider.CsdlEntityType;
import org.apache.olingo.commons.api.edm.provider.CsdlEnumType;
import org.apache.olingo.commons.api.edm.provider.CsdlSchema;
import org.apache.olingo.commons.api.edm.provider.CsdlSingleton;
import org.apache.olingo.commons.api.ex.ODataException;

import ru.gazpromproject.ta.svcm.base.AbstractSvcmEdm;
import ru.gazpromproject.ta.svcm.core.SvcmEdmCore;
import ru.gazpromproject.ta.svcm.stream.SvcmEdmStream;
import ru.gazpromproject.ta.svcm.sys.SvcmEdmSys;

public class SvcmEdmProvider extends CsdlAbstractEdmProvider {

    // private static final Logger logger =
    // LoggerFactory.getLogger(SvcmEdmProvider.class);

    // Service Namespace
    public static final String NAMESPACE = "svcm";

    // EDM Container
    public static final String CNT_NAME = "Container";
    public static final FullQualifiedName CNT_FQN = new FullQualifiedName(NAMESPACE, CNT_NAME);

    //
    public static final String GEN_ID_NAME = "Id";
    public static final String NAV_GROUP_NAME = "group";
    public static final String NAV_GROUPITEMS_NAME = "items";
    public static final String NAV_PARENT_NAME = "parent";
    public static final String NAV_CHILDREN_NAME = "children";

    private List<AbstractSvcmEdm> edm_providers;

    public SvcmEdmProvider() {
        AbstractSvcmEdm sys = new SvcmEdmSys();
        AbstractSvcmEdm core = new SvcmEdmCore();
        AbstractSvcmEdm stream = new SvcmEdmStream();
        edm_providers = new ArrayList<AbstractSvcmEdm>();
        edm_providers.addAll(Arrays.asList(sys, core, stream));
    }

    @Override
    public CsdlEntityType getEntityType(FullQualifiedName entityTypeName) throws ODataException {
        for (AbstractSvcmEdm provider : edm_providers) {
            CsdlEntityType et = provider.getEntityType(entityTypeName);
            if (et != null)
                return et;
        }
        return null;
    }

    @Override
    public CsdlEntitySet getEntitySet(FullQualifiedName entityContainer, String entitySetName) throws ODataException {
        for (AbstractSvcmEdm provider : edm_providers) {
            CsdlEntitySet es = provider.getEntitySet(entityContainer, entitySetName);
            if (es != null)
                return es;
        }
        return null;
    }

    @Override
    public CsdlSingleton getSingleton(FullQualifiedName entityContainer, String singletonName) throws ODataException {
        for (AbstractSvcmEdm provider : edm_providers) {
            CsdlSingleton st = provider.getSingleton(entityContainer, singletonName);
            if (st != null)
                return st;
        }
        return null;
    }

    @Override
    public CsdlEnumType getEnumType(FullQualifiedName enumTypeName) throws ODataException {
        for (AbstractSvcmEdm provider : edm_providers) {
            CsdlEnumType et = provider.getEnumType(enumTypeName);
            if (et != null)
                return et;
        }
        return null;
    }

    @Override
    public CsdlEntityContainer getEntityContainer() throws ODataException {
        // create EntitySets
        List<CsdlEntitySet> entitySets = new ArrayList<CsdlEntitySet>();
        for (AbstractSvcmEdm provider : edm_providers) {
            List<CsdlEntitySet> es = provider.getEntitySetList();
            if (es != null)
                entitySets.addAll(es);
        }
        ;

        List<CsdlSingleton> singletones = new ArrayList<CsdlSingleton>();
        for (AbstractSvcmEdm provider : edm_providers) {
            List<CsdlSingleton> st = provider.getSingletonList();
            if (st != null)
                singletones.addAll(st);
        }
        ;

        // create EntityContainer
        CsdlEntityContainer entityContainer = new CsdlEntityContainer();
        entityContainer.setName(CNT_NAME);
        entityContainer.setEntitySets(entitySets);
        entityContainer.setSingletons(singletones);
        return entityContainer;
    }

    @Override
    public CsdlEntityContainerInfo getEntityContainerInfo(FullQualifiedName entityContainerName) throws ODataException {
        // This method is invoked when displaying the Service Document at e.g.
        // http://localhost:8080/DemoService/DemoService.svc
        if (entityContainerName == null || entityContainerName.equals(CNT_FQN)) {
            CsdlEntityContainerInfo entityContainerInfo = new CsdlEntityContainerInfo();
            entityContainerInfo.setContainerName(CNT_FQN);
            return entityContainerInfo;
        }
        return null;
    }

    @Override
    public List<CsdlSchema> getSchemas() throws ODataException {
        CsdlSchema schema = new CsdlSchema();
        schema.setNamespace(NAMESPACE);
        schema.setEntityTypes(getEntityTypes());
        schema.setEnumTypes(getEnumTypes());
        schema.setEntityContainer(getEntityContainer());

        List<CsdlSchema> schemas = new ArrayList<CsdlSchema>();
        schemas.add(schema);
        return schemas;
    }

    private List<CsdlEntityType> getEntityTypes() throws ODataException {
        List<CsdlEntityType> entityTypes = new ArrayList<CsdlEntityType>();
        for (AbstractSvcmEdm provider : edm_providers) {
            entityTypes.addAll(provider.getEntityTypeList());
        }
        return entityTypes;
    }

    private List<CsdlEnumType> getEnumTypes() throws ODataException {
        List<CsdlEnumType> enumTypes = new ArrayList<CsdlEnumType>();
        for (AbstractSvcmEdm provider : edm_providers) {
            List<CsdlEnumType> ent = provider.getEnumTypeList();
            if (ent != null)
                enumTypes.addAll(ent);
        }
        // logger.info(String.format("Entity types size %s", enumTypes.size()));
        return enumTypes;
    }
}
