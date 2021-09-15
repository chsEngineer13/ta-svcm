package ru.gazpromproject.ta.svcm.base;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.apache.olingo.commons.api.edm.EdmPrimitiveTypeKind;
import org.apache.olingo.commons.api.edm.FullQualifiedName;
import org.apache.olingo.commons.api.edm.provider.CsdlEntitySet;
import org.apache.olingo.commons.api.edm.provider.CsdlEntityType;
import org.apache.olingo.commons.api.edm.provider.CsdlEnumType;
import org.apache.olingo.commons.api.edm.provider.CsdlMapping;
import org.apache.olingo.commons.api.edm.provider.CsdlProperty;
import org.apache.olingo.commons.api.edm.provider.CsdlPropertyRef;
import org.apache.olingo.commons.api.edm.provider.CsdlSingleton;
import org.apache.olingo.commons.api.ex.ODataException;
import org.apache.olingo.server.api.ODataApplicationException;

import ru.gazpromproject.ta.svcm.data.SvcmEnumStorage;
import ru.gazpromproject.ta.svcm.service.SvcmEdmProvider;

public abstract class AbstractSvcmEdm {
    
    public final int SVCM_SECOND_PRECISION = 6;

    public abstract CsdlEntityType getEntityType(FullQualifiedName entityTypeName)
            throws ODataException;

    public abstract List<CsdlEntityType> getEntityTypeList()
            throws ODataException;

    public abstract CsdlEntitySet getEntitySet(FullQualifiedName entityContainer, String entitySetName)
            throws ODataException;

    public abstract List<CsdlEntitySet> getEntitySetList()
            throws ODataException;

    public abstract CsdlSingleton getSingleton(FullQualifiedName entityContainer, String singletonName)
            throws ODataException;

    public abstract List<CsdlSingleton> getSingletonList()
            throws ODataException;

    public abstract CsdlEnumType getEnumType(FullQualifiedName enumTypeName)
            throws ODataException;

    public abstract List<CsdlEnumType> getEnumTypeList()
            throws ODataException;

    protected SvcmEnumStorage enumStorage;

    public static final CsdlProperty BASE_PROPERTY_ID = new CsdlProperty()
            .setName(SvcmEdmProvider.GEN_ID_NAME)
            .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
            .setMapping(new CsdlMapping().setInternalName("id"));
    public static final CsdlProperty BASE_PROPERTY_NAME = new CsdlProperty()
            .setName("Name")
            .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
            .setMapping(new CsdlMapping().setInternalName("name"));
    public static final CsdlProperty BASE_PROPERTY_CODE = new CsdlProperty()
            .setName("Code")
            .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
            .setMapping(new CsdlMapping().setInternalName("code"));

    public AbstractSvcmEdm() {
        enumStorage = new SvcmEnumStorage();
    }

    protected CsdlEntitySet getStandardEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet entitySet = new CsdlEntitySet();
        entitySet.setName(entityTypeName);
        entitySet.setType(fullQualifiedName);
        return entitySet;
    }

    protected CsdlSingleton getStandardSingleton(String singletonName, FullQualifiedName fullQualifiedName) {
        CsdlSingleton stn = new CsdlSingleton();
        stn.setName(singletonName);
        stn.setType(fullQualifiedName);
        return stn;
    }

    protected CsdlEntityType getStandardRefEntityType(String entityTypeName) {
        // create EntityType properties
        CsdlProperty id = new CsdlProperty()
                .setName("Id")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("id"));
        CsdlProperty code = new CsdlProperty()
                .setName("Code")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("code"));
        CsdlProperty name = new CsdlProperty()
                .setName("Name")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("name"));

        // create CsdlPropertyRef for Key element
        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName("Id");

        // configure EntityType
        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(entityTypeName);
        entityType.setProperties(Arrays.asList(id, code, name));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    protected CsdlEnumType getStandardEnumType(FullQualifiedName enumTypeFqn, FullQualifiedName underlyingType)
            throws ODataApplicationException {
        CsdlEnumType ent = new CsdlEnumType()
                .setName(enumTypeFqn.getName())
                .setMembers(enumStorage.readEnumData(enumTypeFqn))
                .setUnderlyingType(underlyingType);
        return ent;
    }
}
