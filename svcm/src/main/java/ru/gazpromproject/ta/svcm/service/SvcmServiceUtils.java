package ru.gazpromproject.ta.svcm.service;

import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.edm.EdmBindingTarget;
import org.apache.olingo.commons.api.edm.EdmEntitySet;
import org.apache.olingo.commons.api.edm.EdmNavigationProperty;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriInfoResource;
import org.apache.olingo.server.api.uri.UriResource;
import org.apache.olingo.server.api.uri.UriResourceEntitySet;
import org.apache.olingo.server.api.uri.UriResourceNavigation;

public class SvcmServiceUtils {

    public static EdmEntitySet getEdmEntitySet(UriInfoResource uriInfo) throws ODataApplicationException {
        List<UriResource> resourcePaths = uriInfo.getUriResourceParts();
        // To get the entity set we have to interpret all URI segments
        if (!(resourcePaths.get(0) instanceof UriResourceEntitySet)) {
            throw new ODataApplicationException("Invalid resource type for first segment.",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
        }
        UriResourceEntitySet uriResource = (UriResourceEntitySet) resourcePaths.get(0);
        return uriResource.getEntitySet();
    }

    public static EdmEntitySet getNavigationTargetEntitySet(final UriInfoResource uriInfo)
            throws ODataApplicationException {

        EdmEntitySet entitySet;
        final List<UriResource> resourcePaths = uriInfo.getUriResourceParts();

        // First must be entity set (hence function imports are not supported here).
        if (resourcePaths.get(0) instanceof UriResourceEntitySet) {
            entitySet = ((UriResourceEntitySet) resourcePaths.get(0)).getEntitySet();
        } else {
            throw new ODataApplicationException("Invalid resource type.",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
        }

        int navigationCount = 0;
        while (entitySet != null && ++navigationCount < resourcePaths.size()
                && resourcePaths.get(navigationCount) instanceof UriResourceNavigation) {
            final UriResourceNavigation uriResourceNavigation = (UriResourceNavigation) resourcePaths
                    .get(navigationCount);
            final EdmBindingTarget target = entitySet
                    .getRelatedBindingTarget(uriResourceNavigation.getProperty().getName());
            if (target instanceof EdmEntitySet) {
                entitySet = (EdmEntitySet) target;
            } else {
                throw new ODataApplicationException("Singletons not supported",
                        HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ROOT);
            }
        }

        return entitySet;
    }

    /**
     * Example: For the following navigation: DemoService.svc/Categories(1)/Products
     * we need the EdmEntitySet for the navigation property "Products"
     *
     * This is defined as follows in the metadata: <code>
     * 
     * <EntitySet Name="Categories" EntityType="OData.Demo.Category">
    * <NavigationPropertyBinding Path="Products" Target="Products"/>
     * </EntitySet>
     * </code> The "Target" attribute specifies the target EntitySet Therefore we
     * need the startEntitySet "Categories" in order to retrieve the target
     * EntitySet "Products"
     */
    public static EdmEntitySet getNavigationTargetEntitySet(EdmEntitySet startEdmEntitySet,
            EdmNavigationProperty edmNavigationProperty) throws ODataApplicationException {

        EdmEntitySet navigationTargetEntitySet = null;

        String navPropName = edmNavigationProperty.getName();
        EdmBindingTarget edmBindingTarget = startEdmEntitySet.getRelatedBindingTarget(navPropName);
        if (edmBindingTarget == null) {
            throw new ODataApplicationException("Not supported.", HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(),
                    Locale.ROOT);
        }

        if (edmBindingTarget instanceof EdmEntitySet) {
            navigationTargetEntitySet = (EdmEntitySet) edmBindingTarget;
        } else {
            throw new ODataApplicationException("Not supported.", HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(),
                    Locale.ROOT);
        }

        return navigationTargetEntitySet;
    }
}
