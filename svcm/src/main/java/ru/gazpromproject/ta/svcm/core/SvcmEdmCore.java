package ru.gazpromproject.ta.svcm.core;

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
import org.apache.olingo.commons.api.edm.provider.CsdlNavigationProperty;
import org.apache.olingo.commons.api.edm.provider.CsdlNavigationPropertyBinding;
import org.apache.olingo.commons.api.edm.provider.CsdlProperty;
import org.apache.olingo.commons.api.edm.provider.CsdlPropertyRef;
import org.apache.olingo.commons.api.edm.provider.CsdlSingleton;
import org.apache.olingo.commons.api.ex.ODataException;

import ru.gazpromproject.ta.svcm.base.AbstractSvcmEdm;
import ru.gazpromproject.ta.svcm.service.SvcmEdmProvider;

public class SvcmEdmCore extends AbstractSvcmEdm {

    public static final String EM_OBJECTTYPE_NAME = "CObjectType";
    public static final FullQualifiedName ET_OBJECTTYPE_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, EM_OBJECTTYPE_NAME);

    public static final String ET_CONSTRUCTION_NAME = "Construction";
    public static final FullQualifiedName ET_CONSTRUCTION_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_CONSTRUCTION_NAME);
    public static final String ES_CONSTRUCTIONS_NAME = "Constructions";

    public static final String ET_CONSTRPARTREF_NAME = "RefConstrPart";
    public static final FullQualifiedName ET_CONSTRPARTREF_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_CONSTRPARTREF_NAME);
    public static final String ES_CONSTRPARTREFS_NAME = "RefConstrParts";

    public static final String ET_CONSTRPARTGROUPREF_NAME = "RefConstrPartGroup";
    public static final FullQualifiedName ET_CONSTRPARTGROUPREF_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_CONSTRPARTGROUPREF_NAME);
    public static final String ES_CONSTRPARTGROUPREFS_NAME = "RefConstrPartGroups";

    public static final String ET_BUILDING_NAME = "RefBuilding";
    public static final FullQualifiedName ET_BUILDING_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_BUILDING_NAME);
    public static final String ES_BUILDINGS_NAME = "RefBuildings";

    public static final String ET_BUILDINGGROUP_NAME = "RefBuildingGroup";
    public static final FullQualifiedName ET_BUILDINGGROUP_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_BUILDINGGROUP_NAME);
    public static final String ES_BUILDINGGROUPS_NAME = "RefBuildingGroups";

    public static final String ET_MARK_NAME = "RefMark";
    public static final FullQualifiedName ET_MARK_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_MARK_NAME);
    public static final String ES_MARKS_NAME = "RefMarks";

    public static final String ET_DEVELOPER_NAME = "RefDeveloper";
    public static final FullQualifiedName ET_DEVELOPER_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_DEVELOPER_NAME);
    public static final String ES_DEVELOPERS_NAME = "RefDevelopers";

    public static final String ET_OBJECT_NAME = "CObject";
    public static final FullQualifiedName ET_OBJECT_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_OBJECT_NAME);
    public static final String ES_OBJECTS_NAME = "CObjects";

    public static final String ET_DOCSET_NAME = "Docset";
    public static final FullQualifiedName ET_DOCSET_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_DOCSET_NAME);
    public static final String ES_DOCSETS_NAME = "Docsets";

    public static final String ET_CONTRACTOR_NAME = "RefContractor";
    public static final FullQualifiedName ET_CONTRACTOR_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_CONTRACTOR_NAME);
    public static final String ES_CONTRACTORS_NAME = "RefContractors";

    public static final String ET_CHAPTERCODE_NAME = "RefChapterCode";
    public static final FullQualifiedName ET_CHAPTERCODE_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_CHAPTERCODE_NAME);
    public static final String ES_CHAPTERCODES_NAME = "RefChapterCodes";

    public static final String ET_DOCCODE_NAME = "RefDocCode";
    public static final FullQualifiedName ET_DOCCODE_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_DOCCODE_NAME);
    public static final String ES_DOCCODES_NAME = "RefDocCodes";

    public static final String ET_PHASE_NAME = "RefPhase";
    public static final FullQualifiedName ET_PHASE_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_PHASE_NAME);
    public static final String ES_PHASES_NAME = "RefPhases";

    public static final String ET_SUMMARYCONSTRUCTION_NAME = "SummaryConstruction";
    public static final FullQualifiedName ET_SUMMARYCONSTRUCTION_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_SUMMARYCONSTRUCTION_NAME);
    public static final String ES_SUMMARYCONSTRUCTIONS_NAME = "SummaryConstructions";

    public static final String ET_WAYBILL_NAME = "WayBill";
    public static final FullQualifiedName ET_WAYBILL_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_WAYBILL_NAME);
    public static final String ES_WAYBILLS_NAME = "Waybills";

    public static final String ET_CONTRACT_NAME = "Contract";
    public static final FullQualifiedName ET_CONTRACT_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_CONTRACT_NAME);
    public static final String ES_CONTRACTS_NAME = "Contracts";

    public static final String ET_CONTRACTSTAGE_NAME = "ContractStage";
    public static final FullQualifiedName ET_CONTRACTSTAGE_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_CONTRACTSTAGE_NAME);
    public static final String ES_CONTRACTSTAGES_NAME = "ContractStages";

    public static final String ET_DOCUMENT_NAME = "Document";
    public static final FullQualifiedName ET_DOCUMENT_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_DOCUMENT_NAME);
    public static final String ES_DOCUMENTS_NAME = "Documents";

    public static final String ET_MFILE_NAME = "MFile";
    public static final FullQualifiedName ET_MFILE_FQN =
            new FullQualifiedName(SvcmEdmProvider.NAMESPACE, ET_MFILE_NAME);
    public static final String ES_MFILES_NAME = "MFiles";

    @Override
    public CsdlEntityType getEntityType(FullQualifiedName entityTypeName) throws ODataException {
        if (entityTypeName.equals(ET_CONSTRUCTION_FQN))
            return getConstructionEntityType();
        else if (entityTypeName.equals(ET_CONSTRPARTREF_FQN))
            return getConstrPartRefEntityType();
        else if (entityTypeName.equals(ET_CONSTRPARTGROUPREF_FQN))
            return getConstrPartGroupRefEntityType();
        else if (entityTypeName.equals(ET_BUILDING_FQN))
            return getBuildingEntityType();
        else if (entityTypeName.equals(ET_BUILDINGGROUP_FQN))
            return getBuildingGroupEntityType();
        else if (entityTypeName.equals(ET_MARK_FQN))
            return getMarkEntityType();
        else if (entityTypeName.equals(ET_DEVELOPER_FQN))
            return getDeveloperEntityType();
        else if (entityTypeName.equals(ET_OBJECT_FQN))
            return getObjectEntityType();
        else if (entityTypeName.equals(ET_DOCSET_FQN))
            return getDocsetEntityType();
        else if (entityTypeName.equals(ET_CONTRACTOR_FQN))
            return getContractorEntityType();
        else if (entityTypeName.equals(ET_CHAPTERCODE_FQN))
            return getChapterCodeEntityType();
        else if (entityTypeName.equals(ET_DOCCODE_FQN))
            return getDocCodeEntityType();
        else if (entityTypeName.equals(ET_PHASE_FQN))
            return getPhaseEntityType();
        else if (entityTypeName.equals(ET_SUMMARYCONSTRUCTION_FQN))
            return getSummaryConstructionEntityType();
        else if (entityTypeName.equals(ET_WAYBILL_FQN))
            return getWaybillEntityType();
        else if (entityTypeName.equals(ET_CONTRACT_FQN))
            return getContractEntityType();
        else if (entityTypeName.equals(ET_CONTRACTSTAGE_FQN))
            return getContractStageEntityType();
        else if (entityTypeName.equals(ET_DOCUMENT_FQN))
            return getDocumentEntityType();
        else if (entityTypeName.equals(ET_MFILE_FQN))
            return getMFileEntityType();
        return null;
    }

    @Override
    public List<CsdlEntityType> getEntityTypeList() throws ODataException {
        List<CsdlEntityType> entityTypes = new ArrayList<CsdlEntityType>();
        entityTypes.add(getEntityType(ET_CONSTRUCTION_FQN));
        entityTypes.add(getEntityType(ET_CONSTRPARTREF_FQN));
        entityTypes.add(getEntityType(ET_CONSTRPARTGROUPREF_FQN));
        entityTypes.add(getEntityType(ET_BUILDING_FQN));
        entityTypes.add(getEntityType(ET_BUILDINGGROUP_FQN));
        entityTypes.add(getEntityType(ET_MARK_FQN));
        entityTypes.add(getEntityType(ET_DEVELOPER_FQN));
        entityTypes.add(getEntityType(ET_OBJECT_FQN));
        entityTypes.add(getEntityType(ET_DOCSET_FQN));
        entityTypes.add(getEntityType(ET_CONTRACTOR_FQN));
        entityTypes.add(getEntityType(ET_CHAPTERCODE_FQN));
        entityTypes.add(getEntityType(ET_DOCCODE_FQN));
        entityTypes.add(getEntityType(ET_PHASE_FQN));
        entityTypes.add(getEntityType(ET_SUMMARYCONSTRUCTION_FQN));
        entityTypes.add(getEntityType(ET_WAYBILL_FQN));
        entityTypes.add(getEntityType(ET_CONTRACT_FQN));
        entityTypes.add(getEntityType(ET_CONTRACTSTAGE_FQN));
        entityTypes.add(getEntityType(ET_DOCUMENT_FQN));
        entityTypes.add(getEntityType(ET_MFILE_FQN));
        return entityTypes;
    }

    @Override
    public CsdlEntitySet getEntitySet(FullQualifiedName entityContainer, String entitySetName) throws ODataException {
        if (entityContainer.equals(SvcmEdmProvider.CNT_FQN)) {
            if (entitySetName.equals(ES_CONSTRUCTIONS_NAME))
                return getStandardEntitySet(ES_CONSTRUCTIONS_NAME, ET_CONSTRUCTION_FQN);
            else if (entitySetName.equals(ES_CONSTRPARTREFS_NAME))
                return getConstrPartRefEntitySet(ES_CONSTRPARTREFS_NAME, ET_CONSTRPARTREF_FQN);
            else if (entitySetName.equals(ES_CONSTRPARTGROUPREFS_NAME))
                return getConstrPartGroupRefEntitySet(ES_CONSTRPARTGROUPREFS_NAME, ET_CONSTRPARTGROUPREF_FQN);
            else if (entitySetName.equals(ES_BUILDINGS_NAME))
                return getBuildingEntitySet(ES_BUILDINGS_NAME, ET_BUILDING_FQN);
            else if (entitySetName.equals(ES_BUILDINGGROUPS_NAME))
                return getBuildingGroupEntitySet(ES_BUILDINGGROUPS_NAME, ET_BUILDINGGROUP_FQN);
            else if (entitySetName.equals(ES_MARKS_NAME))
                return getStandardEntitySet(ES_MARKS_NAME, ET_MARK_FQN);
            else if (entitySetName.equals(ES_DEVELOPERS_NAME))
                return getStandardEntitySet(ES_DEVELOPERS_NAME, ET_DEVELOPER_FQN);
            else if (entitySetName.equals(ES_OBJECTS_NAME))
                return getObjectEntitySet(ES_OBJECTS_NAME, ET_OBJECT_FQN);
            else if (entitySetName.equals(ES_DOCSETS_NAME))
                return getDocsetEntitySet(ES_DOCSETS_NAME, ET_DOCSET_FQN);
            else if (entitySetName.equals(ES_CONTRACTORS_NAME))
                return getStandardEntitySet(ES_CONTRACTORS_NAME, ET_CONTRACTOR_FQN);
            else if (entitySetName.equals(ES_CHAPTERCODES_NAME))
                return getChapterCodeEntitySet(ES_CHAPTERCODES_NAME, ET_CHAPTERCODE_FQN);
            else if (entitySetName.equals(ES_DOCCODES_NAME))
                return getDocCodeEntitySet(ES_DOCCODES_NAME, ET_DOCCODE_FQN);
            else if (entitySetName.equals(ES_PHASES_NAME))
                return getPhaseEntitySet(ES_PHASES_NAME, ET_PHASE_FQN);
            else if (entitySetName.equals(ES_SUMMARYCONSTRUCTIONS_NAME))
                return getSummaryConstructionEntitySet(ES_SUMMARYCONSTRUCTIONS_NAME, ET_SUMMARYCONSTRUCTION_FQN);
            else if (entitySetName.equals(ES_WAYBILLS_NAME))
                return getWaybillEntitySet(ES_WAYBILLS_NAME, ET_WAYBILL_FQN);
            else if (entitySetName.equals(ES_CONTRACTS_NAME))
                return getContractEntitySet(ES_CONTRACTS_NAME, ET_CONTRACT_FQN);
            else if (entitySetName.equals(ES_CONTRACTSTAGES_NAME))
                return getContractStageEntitySet(ES_CONTRACTSTAGES_NAME, ET_CONTRACTSTAGE_FQN);
            else if (entitySetName.equals(ES_DOCUMENTS_NAME))
                return getDocumentEntitySet(ES_DOCUMENTS_NAME, ET_DOCUMENT_FQN);
            else if (entitySetName.equals(ES_MFILES_NAME))
                return getMFileEntitySet(ES_MFILES_NAME, ET_MFILE_FQN);
        }
        return null;
    }

    @Override
    public List<CsdlEntitySet> getEntitySetList() throws ODataException {
        List<CsdlEntitySet> entitySets = new ArrayList<CsdlEntitySet>();
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_CONSTRUCTIONS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_CONSTRPARTREFS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_CONSTRPARTGROUPREFS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_BUILDINGS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_BUILDINGGROUPS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_MARKS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_DEVELOPERS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_OBJECTS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_DOCSETS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_CONTRACTORS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_CHAPTERCODES_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_DOCCODES_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_PHASES_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_SUMMARYCONSTRUCTIONS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_WAYBILLS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_CONTRACTS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_CONTRACTSTAGES_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_DOCUMENTS_NAME));
        entitySets.add(getEntitySet(SvcmEdmProvider.CNT_FQN, ES_MFILES_NAME));
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
        if (enumTypeName.equals(ET_OBJECTTYPE_FQN))
            return getStandardEnumType(ET_OBJECTTYPE_FQN, EdmPrimitiveTypeKind.Byte.getFullQualifiedName());
        return null;
    }

    @Override
    public List<CsdlEnumType> getEnumTypeList() throws ODataException {
        List<CsdlEnumType> enumTypes = new ArrayList<CsdlEnumType>();
        enumTypes.add(getEnumType(ET_OBJECTTYPE_FQN));
        return enumTypes;
    }

    private CsdlEntityType getConstructionEntityType() {
        return getStandardRefEntityType(ET_CONSTRUCTION_NAME);
    }

    private CsdlEntityType getConstrPartRefEntityType() {
        CsdlNavigationProperty group_nav = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_GROUP_NAME)
                .setType(ET_CONSTRPARTGROUPREF_FQN)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_GROUPITEMS_NAME);                

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_CONSTRPARTREF_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, BASE_PROPERTY_CODE, BASE_PROPERTY_NAME));
        entityType.setNavigationProperties(Arrays.asList(group_nav));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getConstrPartRefEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        CsdlNavigationPropertyBinding itemBinding = new CsdlNavigationPropertyBinding();
        itemBinding.setPath(SvcmEdmProvider.NAV_GROUP_NAME);
        itemBinding.setTarget(ES_CONSTRPARTGROUPREFS_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(itemBinding));
        return set;
    }

    private CsdlEntityType getConstrPartGroupRefEntityType() {
        CsdlProperty codeRange = new CsdlProperty()
                .setName("CodeRange")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("codeRange"));

        CsdlNavigationProperty cprefs = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_GROUPITEMS_NAME)
                .setType(ET_CONSTRPARTREF_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_GROUP_NAME);                

        CsdlPropertyRef propertyRef = new CsdlPropertyRef().setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_CONSTRPARTGROUPREF_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, codeRange, BASE_PROPERTY_NAME));
        entityType.setNavigationProperties(Arrays.asList((cprefs)));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getConstrPartGroupRefEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        CsdlNavigationPropertyBinding groupBinding = new CsdlNavigationPropertyBinding();
        groupBinding.setPath(SvcmEdmProvider.NAV_GROUPITEMS_NAME);
        groupBinding.setTarget(ES_CONSTRPARTREFS_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(groupBinding));
        return set;
    }

    private CsdlEntityType getBuildingEntityType() {
        CsdlNavigationProperty buildingGroup = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_GROUP_NAME)
                .setType(ET_BUILDINGGROUP_FQN)
                .setCollection(false)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_GROUPITEMS_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_BUILDING_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, BASE_PROPERTY_CODE, BASE_PROPERTY_NAME));
        entityType.setNavigationProperties(Arrays.asList(buildingGroup));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getBuildingEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {

        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding itemBinding = new CsdlNavigationPropertyBinding();
        itemBinding.setPath(SvcmEdmProvider.NAV_GROUP_NAME);
        itemBinding.setTarget(ES_BUILDINGGROUPS_NAME);

        set.setNavigationPropertyBindings(Arrays.asList(itemBinding));
        return set;
    }

    private CsdlEntityType getBuildingGroupEntityType() {
        CsdlProperty codeRange = new CsdlProperty()
                .setName("CodeRange")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("codeRange"));

        CsdlNavigationProperty parent = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_PARENT_NAME)
                .setType(ET_BUILDINGGROUP_FQN)
                .setCollection(false)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_CHILDREN_NAME);
        CsdlNavigationProperty children = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_CHILDREN_NAME)
                .setType(ET_BUILDINGGROUP_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_PARENT_NAME);
        CsdlNavigationProperty buildingIems = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_GROUPITEMS_NAME)
                .setType(ET_BUILDING_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_GROUP_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_BUILDINGGROUP_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, codeRange, BASE_PROPERTY_NAME));
        entityType.setNavigationProperties(Arrays.asList(parent, children, buildingIems));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getBuildingGroupEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding parentBinding = new CsdlNavigationPropertyBinding();
        parentBinding.setPath(SvcmEdmProvider.NAV_PARENT_NAME);
        parentBinding.setTarget(ES_BUILDINGGROUPS_NAME);

        CsdlNavigationPropertyBinding childrenBinding = new CsdlNavigationPropertyBinding();
        childrenBinding.setPath(SvcmEdmProvider.NAV_CHILDREN_NAME);
        childrenBinding.setTarget(ES_BUILDINGGROUPS_NAME);

        CsdlNavigationPropertyBinding groupBinding = new CsdlNavigationPropertyBinding();
        groupBinding.setPath(SvcmEdmProvider.NAV_GROUPITEMS_NAME);
        groupBinding.setTarget(ES_BUILDINGS_NAME);

        set.setNavigationPropertyBindings(Arrays.asList(parentBinding, childrenBinding, groupBinding));
        return set;
    }

    private CsdlEntityType getDeveloperEntityType() {
        CsdlProperty shortName = new CsdlProperty()
                .setName("ShortName")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("shortName"));

        CsdlEntityType entityType = getStandardRefEntityType(ET_DEVELOPER_NAME);
        List<CsdlProperty> stndProperties = entityType.getProperties();
        ArrayList<CsdlProperty> currProperties = new ArrayList<CsdlProperty>();
        currProperties.addAll(stndProperties);
        currProperties.add(shortName);
        entityType.setProperties(currProperties);
        return entityType;
    }

    private CsdlEntityType getMarkEntityType() {
        CsdlProperty comment = new CsdlProperty()
                .setName("Comment")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("comment"));
        CsdlProperty isAdditional = new CsdlProperty()
                .setName("IsAdditional")
                .setType(EdmPrimitiveTypeKind.Boolean.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("isAdditional"));

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_MARK_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, BASE_PROPERTY_CODE, BASE_PROPERTY_NAME, comment, isAdditional));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntityType getObjectEntityType() {
        CsdlProperty cobjectType = new CsdlProperty()
                .setName("Type")
                .setType(ET_OBJECTTYPE_FQN);
        CsdlProperty number = new CsdlProperty()
                .setName("Number")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("number"));
        CsdlProperty descr = new CsdlProperty()
                .setName("Descr")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("descr"));               

        CsdlNavigationProperty parent = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_PARENT_NAME)
                .setType(ET_OBJECT_FQN)
                .setCollection(false)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_CHILDREN_NAME);
        CsdlNavigationProperty children = new CsdlNavigationProperty()
                .setName(SvcmEdmProvider.NAV_CHILDREN_NAME)
                .setType(ET_OBJECT_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(SvcmEdmProvider.NAV_PARENT_NAME);
        CsdlNavigationProperty docsets = new CsdlNavigationProperty()
                .setName(ES_DOCSETS_NAME)
                .setType(ET_DOCSET_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ET_OBJECT_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_OBJECT_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, cobjectType, BASE_PROPERTY_CODE, number, descr));
        entityType.setNavigationProperties(Arrays.asList(parent, children, docsets));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getObjectEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        CsdlNavigationPropertyBinding parentBinding = new CsdlNavigationPropertyBinding()
                .setPath(SvcmEdmProvider.NAV_PARENT_NAME)
                .setTarget(ES_OBJECTS_NAME);
        CsdlNavigationPropertyBinding childrenBinding = new CsdlNavigationPropertyBinding()
                .setPath(SvcmEdmProvider.NAV_CHILDREN_NAME)
                .setTarget(ES_OBJECTS_NAME);
        CsdlNavigationPropertyBinding docsetBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_DOCSETS_NAME)
                .setTarget(ES_DOCSETS_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(parentBinding, childrenBinding, docsetBinding));
        return set;
    }

    private CsdlEntitySet getDocsetEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        CsdlNavigationPropertyBinding markBinding = new CsdlNavigationPropertyBinding()
                .setPath(ET_MARK_NAME)
                .setTarget(ES_MARKS_NAME);
        CsdlNavigationPropertyBinding objectBinding = new CsdlNavigationPropertyBinding()
                .setPath(ET_OBJECT_NAME)
                .setTarget(ES_OBJECTS_NAME);
        CsdlNavigationPropertyBinding documentsBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_DOCUMENTS_NAME)
                .setTarget(ES_DOCUMENTS_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(markBinding, objectBinding, documentsBinding));
        return set;
    }

    private CsdlEntityType getDocsetEntityType() {
        CsdlProperty sign = new CsdlProperty()
                .setName("Sign")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("sign"));
        CsdlProperty dateStart = new CsdlProperty()
                .setName("DateStart")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("dateStart"));
        CsdlProperty dateFinish = new CsdlProperty()
                .setName("DateFinish")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("dateFinish"));

        CsdlNavigationProperty mark_nav = new CsdlNavigationProperty()
                .setName(ET_MARK_NAME)
                .setType(ET_MARK_FQN)
                .setCollection(false)
                .setNullable(true);
        CsdlNavigationProperty object_nav = new CsdlNavigationProperty()
                .setName(ET_OBJECT_NAME)
                .setType(ET_OBJECT_FQN)
                .setCollection(false)
                .setNullable(true)
                .setPartner(ES_DOCSETS_NAME);
        CsdlNavigationProperty navDocuments = new CsdlNavigationProperty()
                .setName(ES_DOCUMENTS_NAME)
                .setType(ET_DOCUMENT_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ET_DOCSET_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_DOCSET_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, sign, BASE_PROPERTY_NAME, dateStart, dateFinish));
        entityType.setNavigationProperties(Arrays.asList(mark_nav, object_nav, navDocuments));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntityType getContractorEntityType() {
        CsdlProperty customerCode = new CsdlProperty()
                .setName("CustomerCode")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("customerCode"));

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_CONTRACTOR_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, customerCode, BASE_PROPERTY_NAME));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntityType getChapterCodeEntityType() {
        CsdlProperty chapter = new CsdlProperty()
                .setName("Chapter")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("chapter"));
        CsdlProperty subChapter = new CsdlProperty()
                .setName("SubChapter")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("subChapter"));

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_CHAPTERCODE_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, chapter, subChapter, BASE_PROPERTY_CODE, BASE_PROPERTY_NAME));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getChapterCodeEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        return set;
    }

    private CsdlEntityType getDocCodeEntityType() {
        CsdlProperty additional = new CsdlProperty()
                .setName("Additional")
                .setType(EdmPrimitiveTypeKind.Boolean.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("additional"));
        CsdlProperty numericPart = new CsdlProperty()
                .setName("NumericPart")
                .setType(EdmPrimitiveTypeKind.Boolean.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("numericPart"));        

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_DOCCODE_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, BASE_PROPERTY_CODE, BASE_PROPERTY_NAME, additional, numericPart));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getDocCodeEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        return set;
    }

    private CsdlEntityType getPhaseEntityType() {
        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_PHASE_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, BASE_PROPERTY_CODE, BASE_PROPERTY_NAME));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getPhaseEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        return set;
    }

    private CsdlEntityType getSummaryConstructionEntityType() {
        CsdlProperty cObjectId = new CsdlProperty()
                .setName("CObjectId")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cObjectId"));
        CsdlProperty cntId = new CsdlProperty()
                .setName("CntId")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cntId"));        
        CsdlProperty cntStart = new CsdlProperty()
                .setName("CntStart")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cntStart"));
        CsdlProperty cntFinish = new CsdlProperty()
                .setName("CntFinish")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cntFinish"));
        CsdlProperty cntInvoice = new CsdlProperty()
                .setName("CntInvoice")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cntInvoice"));

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_SUMMARYCONSTRUCTION_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, cObjectId, BASE_PROPERTY_CODE, BASE_PROPERTY_NAME,
                cntId, cntStart, cntFinish, cntInvoice));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getSummaryConstructionEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        return set;
    }

    private CsdlEntityType getWaybillEntityType() {
        CsdlProperty wbNum = new CsdlProperty()
                .setName("WaybillNum")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("waybillNum"));
        CsdlProperty wbDate = new CsdlProperty()
                .setName("WaybillDate")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("waybillDate"));
        CsdlProperty descr = new CsdlProperty()
                .setName("Descr")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("waybillDescr"));

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_WAYBILL_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, wbNum, wbDate, descr));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getWaybillEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);
        return set;
    }

    private CsdlEntityType getContractEntityType() {
        CsdlProperty pContractNum = new CsdlProperty()
                .setName("ContractNum")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("contractNum"));
        CsdlProperty pContractDate = new CsdlProperty()
                .setName("ContractDate")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("contractDate"));
        CsdlProperty pContractStatus = new CsdlProperty()
                .setName("ContractStatus")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("contractStatus"));
        CsdlProperty pContractYear = new CsdlProperty()
                .setName("ContractYear")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("contractYear"));
        CsdlProperty pDateSign = new CsdlProperty()
                .setName("DateSign")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("dateSign"));
        CsdlProperty pGIPs = new CsdlProperty()
                .setName("GIPs")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("gips"));
        CsdlProperty pInnerNum = new CsdlProperty()
                .setName("InnerNum")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("innerNum"));
        CsdlProperty pIUSCode = new CsdlProperty()
                .setName("IUSCode")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("iusCode"));
        CsdlProperty pTitle = new CsdlProperty()
                .setName("Title")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("title"));
        CsdlProperty pOIPKS = new CsdlProperty()
                .setName("OIPKS")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("oipks"));
        CsdlProperty pTechDirector = new CsdlProperty()
                .setName("TechDirector")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("techDirector"));
        CsdlProperty pOrderStart = new CsdlProperty()
                .setName("OrderStart")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("orderStart"));
        CsdlProperty pOrderFinish = new CsdlProperty()
                .setName("OrderFinish")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("orderFinish"));
        CsdlProperty pWorkStart = new CsdlProperty()
                .setName("WorkStart")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("workStart"));
        CsdlProperty pWorkFinish = new CsdlProperty()
                .setName("WorkFinish")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("workFinish"));
        CsdlProperty pWorkTypes = new CsdlProperty()
                .setName("WorkTypes")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("workTypes"));

        CsdlNavigationProperty stages_nav = new CsdlNavigationProperty()
                .setName(ES_CONTRACTSTAGES_NAME)
                .setType(ET_CONTRACTSTAGE_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ET_CONTRACT_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_CONTRACT_NAME);
        entityType.setProperties(Arrays.asList(BASE_PROPERTY_ID, pContractNum, pContractDate, pContractStatus, pContractYear,
                pDateSign, pGIPs, pInnerNum, pIUSCode, pTitle, pOIPKS, pTechDirector, pOrderStart, pOrderFinish,
                pWorkStart, pWorkFinish, pWorkTypes));
        entityType.setNavigationProperties(Arrays.asList(stages_nav));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getContractEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding contractStagesBinding = new CsdlNavigationPropertyBinding()
                .setPath(ES_CONTRACTSTAGES_NAME)
                .setTarget(ES_CONTRACTSTAGES_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(contractStagesBinding));

        return set;
    }

    private CsdlEntityType getContractStageEntityType() {
        CsdlProperty pStatus = new CsdlProperty()
                .setName("Status")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("status"));
        CsdlProperty pStageNum = new CsdlProperty()
                .setName("StageNum")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("stageNum"));
        CsdlProperty pStageName = new CsdlProperty()
                .setName("StageName")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("stageName"));
        CsdlProperty pPlanStart = new CsdlProperty()
                .setName("PlanStart")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("planStart"));
        CsdlProperty pPlanFinish = new CsdlProperty()
                .setName("PlanFinish")
                .setType(EdmPrimitiveTypeKind.Date.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("planFinish"));
        CsdlProperty pWorkTypes = new CsdlProperty()
                .setName("WorkTypes")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("workTypes"));

        CsdlNavigationProperty contract_nav = new CsdlNavigationProperty()
                .setName(ET_CONTRACT_NAME)
                .setType(ET_CONTRACT_FQN)
                .setCollection(false)
                .setNullable(true)
                .setPartner(ES_CONTRACTSTAGES_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_CONTRACTSTAGE_NAME);
        entityType.setProperties(
                Arrays.asList(BASE_PROPERTY_ID, pStatus, pStageNum, pStageName, pPlanStart, pPlanFinish, pWorkTypes));
        entityType.setNavigationProperties(Arrays.asList(contract_nav));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getContractStageEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding contractBinding = new CsdlNavigationPropertyBinding()
                .setPath(ET_CONTRACT_NAME)
                .setTarget(ES_CONTRACTS_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(contractBinding));

        return set;
    }

    private CsdlEntityType getDocumentEntityType() {
        CsdlProperty pCipher = new CsdlProperty()
                .setName("Cipher")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("cipher"));
        CsdlProperty pDeveloperDep = new CsdlProperty()
                .setName("DeveloperDep")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("developerDep"));
        CsdlProperty pIzmNum = new CsdlProperty()
                .setName("IzmNum")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("izmNum"));
        CsdlProperty pStatus = new CsdlProperty()
                .setName("Status")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("status"));
        CsdlProperty pIsActual = new CsdlProperty()
                .setName("IsActual")
                .setType(EdmPrimitiveTypeKind.Boolean.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("actual"));

        CsdlNavigationProperty navDocset = new CsdlNavigationProperty()
                .setName(ET_DOCSET_NAME)
                .setType(ET_DOCSET_FQN)
                .setCollection(false)
                .setNullable(true)
                .setPartner(ES_DOCUMENTS_NAME);

        CsdlNavigationProperty navMFiles = new CsdlNavigationProperty()
                .setName(ES_MFILES_NAME)
                .setType(ET_MFILE_FQN)
                .setCollection(true)
                .setNullable(true)
                .setPartner(ET_DOCUMENT_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_DOCUMENT_NAME);
        entityType.setProperties(
                Arrays.asList(BASE_PROPERTY_ID, pCipher, BASE_PROPERTY_NAME, pDeveloperDep, pIzmNum, pStatus, pIsActual));
        entityType.setNavigationProperties(Arrays.asList(navDocset, navMFiles));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getDocumentEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding bindingDocset = new CsdlNavigationPropertyBinding()
                .setPath(ET_DOCSET_NAME)
                .setTarget(ES_DOCSETS_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(bindingDocset));

        CsdlNavigationPropertyBinding bindingMFiles = new CsdlNavigationPropertyBinding()
                .setPath(ES_MFILES_NAME)
                .setTarget(ES_MFILES_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(bindingDocset, bindingMFiles));

        return set;
    }

    private CsdlEntityType getMFileEntityType() {
        CsdlProperty pParentObjectType = new CsdlProperty()
                .setName("ParentObjectType")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("parentObjectType"));
        CsdlProperty pParentObjectId = new CsdlProperty()
                .setName("ParentObjectId")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("parentObjectId"));
        CsdlProperty pSize = new CsdlProperty()
                .setName("Size")
                .setType(EdmPrimitiveTypeKind.Int32.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("size"));
        CsdlProperty pModifyTime = new CsdlProperty()
                .setName("ModifyTime")
                .setType(EdmPrimitiveTypeKind.DateTimeOffset.getFullQualifiedName())
                .setPrecision(super.SVCM_SECOND_PRECISION)
                .setMapping(new CsdlMapping().setInternalName("modifyTime"));
        CsdlProperty pFileTypeId = new CsdlProperty()
                .setName("FileTypeId")
                .setType(EdmPrimitiveTypeKind.String.getFullQualifiedName())
                .setMapping(new CsdlMapping().setInternalName("fileTypeId"));

        CsdlNavigationProperty navDocument = new CsdlNavigationProperty()
                .setName(ET_DOCUMENT_NAME)
                .setType(ET_DOCUMENT_FQN)
                .setCollection(false)
                .setNullable(true)
                .setPartner(ES_MFILES_NAME);

        CsdlPropertyRef propertyRef = new CsdlPropertyRef();
        propertyRef.setName(SvcmEdmProvider.GEN_ID_NAME);

        CsdlEntityType entityType = new CsdlEntityType();
        entityType.setName(ET_MFILE_NAME);
        entityType.setProperties(
                Arrays.asList(BASE_PROPERTY_ID, pParentObjectType, pParentObjectId, BASE_PROPERTY_NAME, pSize, pModifyTime, pFileTypeId));
        entityType.setNavigationProperties(Arrays.asList(navDocument));
        entityType.setKey(Collections.singletonList(propertyRef));

        return entityType;
    }

    private CsdlEntitySet getMFileEntitySet(String entityTypeName, FullQualifiedName fullQualifiedName) {
        CsdlEntitySet set = getStandardEntitySet(entityTypeName, fullQualifiedName);

        CsdlNavigationPropertyBinding bindingDocument = new CsdlNavigationPropertyBinding()
                .setPath(ET_DOCUMENT_NAME)
                .setTarget(ES_DOCUMENTS_NAME);
        set.setNavigationPropertyBindings(Arrays.asList(bindingDocument));

        return set;
    }

}
