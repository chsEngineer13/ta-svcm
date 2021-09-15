package ru.gazpromproject.ta.svcm.stream;

import java.util.ArrayList;
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

import ru.gazpromproject.ta.svcm.base.AbstractSvcmEdm;
import ru.gazpromproject.ta.svcm.service.SvcmEdmProvider;

public class SvcmEdmStream extends AbstractSvcmEdm {

    public static final String ET_STREAM_CONTRACT_NAME = "StreamContract";
    public static final String ES_STREAM_CONTRACTS_NAME = "StreamContracts";

    public static final String ET_STREAM_CONSTRUCTION_NAME = "StreamConstruction";
    public static final String ES_STREAM_CONSTRUCTIONS_NAME = "StreamConstructions";

    public static final String ET_STREAM_CONSTRPART_NAME = "StreamConstrPart";
    public static final String ES_STREAM_CONSTRPARTS_NAME = "StreamConstrParts";

    public static final String ET_STREAM_BUILDING_NAME = "StreamBuilding";
    public static final String ES_STREAM_BUILDINGS_NAME = "StreamBuildings";

    public static final String ET_STREAM_DOCSET_NAME = "StreamDocset";
    public static final String ES_STREAM_DOCSETS_NAME = "StreamDocsets";

    public static final FullQualifiedName ET_STREAM_CONTRACT_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_STREAM_CONTRACT_NAME);
    public static final FullQualifiedName ET_STREAM_CONSTRUCTION_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_STREAM_CONSTRUCTION_NAME);
    public static final FullQualifiedName ET_STREAM_CONSTRPART_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_STREAM_CONSTRPART_NAME);
    public static final FullQualifiedName ET_STREAM_BUILDING_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_STREAM_BUILDING_NAME);
    public static final FullQualifiedName ET_STREAM_DOCSET_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_STREAM_DOCSET_NAME);

    public static final CsdlProperty STREAM_PROPERTY_NAME = new CsdlProperty()
            .setName("Name")
            .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
            .setMapping(new CsdlMapping().setInternalName("name"));
    public static final CsdlProperty STREAM_PROPERTY_CODE = new CsdlProperty()
            .setName("Code")
            .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
            .setMapping(new CsdlMapping().setInternalName("code"));
    public static final CsdlProperty STREAM_PROPERTY_NUMBER = new CsdlProperty()
            .setName("Number")
            .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
            .setMapping(new CsdlMapping().setInternalName("number"));
    public static final CsdlProperty STREAM_PROPERTY_GIP = new CsdlProperty()
            .setName("Gip")
            .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
            .setMapping(new CsdlMapping().setInternalName("gip"));

    @Override
    public CsdlEntityType getEntityType(FullQualifiedName entityTypeName) throws ODataException {
        if (entityTypeName.equals(ET_STREAM_CONTRACT_FQN))
            return getContractEntityType();
        if (entityTypeName.equals(ET_STREAM_CONSTRUCTION_FQN))
            return getConstructionEntityType();
        if (entityTypeName.equals(ET_STREAM_CONSTRPART_FQN))
            return getConstrPartEntityType();
        if (entityTypeName.equals(ET_STREAM_BUILDING_FQN))
            return getBuildingEntityType();
        if (entityTypeName.equals(ET_STREAM_DOCSET_FQN))
            return getDocsetEntityType();
        return null;
    }

    @Override
    public List<CsdlEntityType> getEntityTypeList() throws ODataException {
        List<CsdlEntityType> entityTypes = new ArrayList<CsdlEntityType>();
        entityTypes.add(getEntityType(ET_STREAM_CONTRACT_FQN));
        entityTypes.add(getEntityType(ET_STREAM_CONSTRUCTION_FQN));
        entityTypes.add(getEntityType(ET_STREAM_CONSTRPART_FQN));
        entityTypes.add(getEntityType(ET_STREAM_BUILDING_FQN));
        entityTypes.add(getEntityType(ET_STREAM_DOCSET_FQN));
        return entityTypes;
    }

    @Override
    public CsdlEntitySet getEntitySet(FullQualifiedName entityContainer, String entitySetName) throws ODataException {
        if (entityContainer.equals(SvcmEdmProvider.CNT_FQN)) {
            if (entitySetName.equals(ES_STREAM_CONTRACTS_NAME))
                return getStandardEntitySet(ES_STREAM_CONTRACTS_NAME, ET_STREAM_CONTRACT_FQN);
            if (entitySetName.equals(ES_STREAM_CONSTRUCTIONS_NAME))
                return getStandardEntitySet(ES_STREAM_CONSTRUCTIONS_NAME, ET_STREAM_CONSTRUCTION_FQN);
            if (entitySetName.equals(ES_STREAM_CONSTRPARTS_NAME))
                return getStandardEntitySet(ES_STREAM_CONSTRPARTS_NAME, ET_STREAM_CONSTRPART_FQN);
            if (entitySetName.equals(ES_STREAM_BUILDINGS_NAME))
                return getStandardEntitySet(ES_STREAM_BUILDINGS_NAME, ET_STREAM_BUILDING_FQN);
            if (entitySetName.equals(ES_STREAM_DOCSETS_NAME))
                return getStandardEntitySet(ES_STREAM_DOCSETS_NAME, ET_STREAM_DOCSET_FQN);
        }
        return null;
    }

    @Override
    public List<CsdlEntitySet> getEntitySetList() throws ODataException {
        List<CsdlEntitySet> entitySets = new ArrayList<CsdlEntitySet>();
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_STREAM_CONTRACTS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_STREAM_CONSTRUCTIONS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_STREAM_CONSTRPARTS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_STREAM_BUILDINGS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_STREAM_DOCSETS_NAME));
        return entitySets;
    }

    @Override
    public CsdlSingleton getSingleton(FullQualifiedName entityContainer, String singletonName) throws ODataException {
        return null;
    }

    @Override
    public List<CsdlSingleton> getSingletonList() throws ODataException {
        return null;
    }

    @Override
    public CsdlEnumType getEnumType(FullQualifiedName enumTypeName) throws ODataException {
        return null;
    }

    @Override
    public List<CsdlEnumType> getEnumTypeList() throws ODataException {
        return null;
    }

    private CsdlEntityType getContractEntityType() {
        CsdlProperty customerCode = new CsdlProperty()
                .setName("CustomerCode")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("customerCode"));
        CsdlProperty contractDate = new CsdlProperty()
                .setName("ContractDate")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("contractDate"));
        List<CsdlProperty> specificProperties = Arrays.asList(STREAM_PROPERTY_NAME, customerCode,
                STREAM_PROPERTY_NUMBER, contractDate, STREAM_PROPERTY_GIP);
        return makeStreamBaseEntityType(ET_STREAM_CONTRACT_NAME, specificProperties, false);
    }

    private CsdlEntityType getConstructionEntityType() {
        List<CsdlProperty> specificProperties = Arrays.asList(STREAM_PROPERTY_NAME, STREAM_PROPERTY_CODE,
                STREAM_PROPERTY_GIP);
        return makeStreamBaseEntityType(ET_STREAM_CONSTRUCTION_NAME, specificProperties, false);
    }

    private CsdlEntityType getConstrPartEntityType() {
        List<CsdlProperty> specificProperties = Arrays.asList(STREAM_PROPERTY_NAME, STREAM_PROPERTY_CODE,
                STREAM_PROPERTY_NUMBER, STREAM_PROPERTY_GIP);
        return makeStreamBaseEntityType(ET_STREAM_CONSTRPART_NAME, specificProperties, true);
    }

    private CsdlEntityType getBuildingEntityType() {
        List<CsdlProperty> specificProperties = new ArrayList<CsdlProperty>();
        String[][] contractIdents = new String[][] {
            { "HContractId", "hcontractId" },
            { "HContractGuid", "hcontractIdGuid" },
            { "HContractIdStr", "hcontractIdStr" }
        };
        specificProperties.addAll(getStreamIdentProperties(contractIdents));
        specificProperties.addAll(Arrays.asList(STREAM_PROPERTY_NAME, STREAM_PROPERTY_CODE,
                STREAM_PROPERTY_NUMBER, STREAM_PROPERTY_GIP));
        return makeStreamBaseEntityType(ET_STREAM_BUILDING_NAME, specificProperties, true);
    }

    private CsdlEntityType getDocsetEntityType() {
        CsdlProperty cipher = new CsdlProperty()
                .setName("Cipher")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cipher"));
        CsdlProperty devDep = new CsdlProperty()
                .setName("DevDep")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("devDep"));
        CsdlProperty oipKs = new CsdlProperty()
                .setName("OipKs")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("oipKs"));
        CsdlProperty customerCode = new CsdlProperty()
                .setName("CustomerCode")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("customerCode"));
        CsdlProperty contractNumber = new CsdlProperty()
                .setName("ContractNumber")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("contractNumber"));
        CsdlProperty cipherStage = new CsdlProperty()
                .setName("CipherStage")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cipherStage"));
        CsdlProperty developer = new CsdlProperty()
                .setName("Developer")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("developer"));
        CsdlProperty cpCode = new CsdlProperty()
                .setName("ConstrPartCode")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("constrPartCode"));        
        CsdlProperty cpNum = new CsdlProperty()
                .setName("ConstrPartNumber")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("constrPartNumber"));
        CsdlProperty bCode = new CsdlProperty()
                .setName("BuildingCode")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("buildingCode"));
        CsdlProperty bNum = new CsdlProperty()
                .setName("BuildingNumber")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("buildingNumber"));
        CsdlProperty mark = new CsdlProperty()
                .setName("Mark")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("mark"));
        CsdlProperty markPath = new CsdlProperty()
                .setName("MarkPath")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("markPath"));
        CsdlProperty stage = new CsdlProperty()
                .setName("Stage")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("stage"));
        CsdlProperty contractStage = new CsdlProperty()
                .setName("ContractStage")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("contractStage"));
        CsdlProperty changeset = new CsdlProperty()
                .setName("Changeset")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("changeset"));
        CsdlProperty status = new CsdlProperty()
                .setName("Status")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("status"));

        List<CsdlProperty> specificProperties = Arrays.asList(STREAM_PROPERTY_NAME, cipher, devDep, oipKs, customerCode,
                contractNumber, cipherStage, developer, cpCode, cpNum, bCode, bNum, mark, markPath, stage,
                contractStage, changeset, status, STREAM_PROPERTY_GIP);
        return makeStreamBaseEntityType(ET_STREAM_DOCSET_NAME, specificProperties, true);
    }

    private CsdlEntityType makeStreamBaseEntityType(String entityTypeName, List<CsdlProperty> specificProperties,
            boolean hasParent) {
        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(entityTypeName);
        ArrayList<CsdlProperty> allProperties = new ArrayList<CsdlProperty>();
        allProperties.addAll(getStreamBaseProperties());
        if (hasParent)
            allProperties.addAll(getStreamParentProperties());
        allProperties.addAll(specificProperties);
        entityType.setProperties(allProperties);
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private List<CsdlProperty> getStreamBaseProperties() {
        CsdlProperty id = new CsdlProperty()
                .setName(SvcmEdmProvider.GEN_ID_NAME)
                .setType(EdmPrimitiveTypeKind.Int64.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("id"));
        ArrayList<CsdlProperty> baseProperties = new ArrayList<CsdlProperty>();
        baseProperties.add(id);

        String[][] baseIdents = new String[][] {
            { "Hid", "hid" },
            { "Hguid", "hidGuid" },
            { "HidStr", "hidStr" }
        };
        baseProperties.addAll(getStreamIdentProperties(baseIdents));

        CsdlProperty timeModified = new CsdlProperty()
                .setName("TimeModified")
                .setType(EdmPrimitiveTypeKind.DateTimeOffset.getFullQualifiedName())
                .setPrecision(super.SVCM_SECOND_PRECISION)
                .setMapping(new CsdlMapping().setInternalName("timeModified"));
        baseProperties.add(timeModified);
        return baseProperties;
    }

    private List<CsdlProperty> getStreamParentProperties() {
        CsdlProperty parentType = new CsdlProperty()
                .setName("HParentType")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("parentType"));
        String[][] parentIdents = new String[][] {
            { "HPid", "hpid" },
            { "HPguid", "hpid_guid" },
            { "HPidStr", "hpid_str" }
        };
        ArrayList<CsdlProperty> parentProperties = new ArrayList<CsdlProperty>();
        parentProperties.add(parentType);
        parentProperties.addAll(getStreamIdentProperties(parentIdents));
        return parentProperties;
    }
    
    private List<CsdlProperty> getStreamIdentProperties(String[][] idNames) {
        CsdlProperty id_int = new CsdlProperty()
                .setName(idNames[0][0])
                .setType(EdmPrimitiveTypeKind.Int64.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName(idNames[0][1]));
        CsdlProperty id_guid = new CsdlProperty()
                .setName(idNames[1][0])
                .setType(EdmPrimitiveTypeKind.Guid.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName(idNames[1][1]));
        CsdlProperty id_str = new CsdlProperty()
                .setName(idNames[2][0])
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName(idNames[2][1]));
        return Arrays.asList(id_int, id_guid, id_str);
    }
}
