package ru.gazpromproject.ta.svcm.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apache.olingo.commons.api.edm.EdmEnumType;
import org.apache.olingo.commons.api.edm.EdmPrimitiveType;
import org.apache.olingo.commons.api.edm.EdmProperty;
import org.apache.olingo.commons.api.edm.EdmType;
import org.apache.olingo.commons.api.http.HttpStatusCode;
import org.apache.olingo.commons.core.edm.primitivetype.EdmBoolean;
import org.apache.olingo.commons.core.edm.primitivetype.EdmDate;
import org.apache.olingo.commons.core.edm.primitivetype.EdmInt64;
import org.apache.olingo.commons.core.edm.primitivetype.EdmString;
import org.apache.olingo.server.api.ODataApplicationException;
import org.apache.olingo.server.api.uri.UriResource;
import org.apache.olingo.server.api.uri.UriResourcePrimitiveProperty;
import org.apache.olingo.server.api.uri.queryoption.expression.BinaryOperatorKind;
import org.apache.olingo.server.api.uri.queryoption.expression.Expression;
import org.apache.olingo.server.api.uri.queryoption.expression.ExpressionVisitException;
import org.apache.olingo.server.api.uri.queryoption.expression.ExpressionVisitor;
import org.apache.olingo.server.api.uri.queryoption.expression.Literal;
import org.apache.olingo.server.api.uri.queryoption.expression.Member;
import org.apache.olingo.server.api.uri.queryoption.expression.MethodKind;
import org.apache.olingo.server.api.uri.queryoption.expression.UnaryOperatorKind;

public class SvcmFilterExpressionVisitor implements ExpressionVisitor<Object> {

    public SvcmFilterExpressionVisitor() {
    }

    @Override
    public Object visitBinaryOperator(BinaryOperatorKind operator, Object left, Object right)
            throws ExpressionVisitException, ODataApplicationException {        
        // Binary Operators are split up in three different kinds. Up to the kind of the
        // operator it can be applied to different types
        //   - Arithmetic operations like add, minus, modulo, etc. are allowed on numeric
        //     types like Edm.Int32
        //   - Logical operations are allowed on numeric types and also Edm.String
        //   - Boolean operations like and, or are allowed on Edm.Boolean
        // A detailed explanation can be found in OData Version 4.0 Part 2: URL Conventions

        if (operator == BinaryOperatorKind.ADD
            || operator == BinaryOperatorKind.MOD
            || operator == BinaryOperatorKind.MUL
            || operator == BinaryOperatorKind.DIV
            || operator == BinaryOperatorKind.SUB) {            
          return evaluateArithmeticOperation(operator, left, right);
        } else if (operator == BinaryOperatorKind.EQ
            || operator == BinaryOperatorKind.NE
            || operator == BinaryOperatorKind.GE
            || operator == BinaryOperatorKind.GT
            || operator == BinaryOperatorKind.LE
            || operator == BinaryOperatorKind.LT) {
          return evaluateComparisonOperation(operator, left, right);
        } else if (operator == BinaryOperatorKind.AND
            || operator == BinaryOperatorKind.OR) {
          return evaluateBooleanOperation(operator, left, right);
          } else {
            throw new ODataApplicationException("Binary operation " + operator.name() + " is not implemented",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
          }
    }

    private Object evaluateBooleanOperation(BinaryOperatorKind operator, Object left, Object right) {
        String result = left.toString() + " " + operator.toString() + " " + right.toString();
        return result;
    }

    private Object evaluateComparisonOperation(BinaryOperatorKind operator, Object left, Object right)
            throws ODataApplicationException {
        if (operator == BinaryOperatorKind.EQ) {
            return buildBinaryOperation("=", left, right);
        } else if (operator == BinaryOperatorKind.NE) {
            return buildBinaryOperation("<>", left, right);
        } else if (operator == BinaryOperatorKind.GT) {
            return buildBinaryOperation(">", left, right);
        } else if (operator == BinaryOperatorKind.GE) {
            return buildBinaryOperation(">=", left, right);
        } else if (operator == BinaryOperatorKind.LE) {
            return buildBinaryOperation("<=", left, right);
        } else if (operator == BinaryOperatorKind.LT) {
            return buildBinaryOperation("<", left, right);
        } else {
            String errMsg = String.format("Comparison operator '%s' not supported", operator.toString());
            throw new ODataApplicationException(errMsg, HttpStatusCode.BAD_REQUEST.getStatusCode(), Locale.ENGLISH);
        }
    }

    private Object evaluateArithmeticOperation(BinaryOperatorKind operator, Object left, Object right) {
        // TODO Auto-generated method stub
        return null;
    }
    
    private String buildBinaryOperation(String operator, Object left, Object right) throws ODataApplicationException {
        StringBuilder resBuilder = new StringBuilder(32);
        resBuilder.append(prepareSQLOperand(left));
        resBuilder.append(String.format(" %s ", operator));
        resBuilder.append(prepareSQLOperand(right));        
        return resBuilder.toString();
    }
    
    private String prepareSQLOperand(Object operand) throws ODataApplicationException {
        if (operand instanceof Long) {
            return ((Long) operand).toString();
        } else if (operand instanceof String) {
            return String.format("'%s'", ((String) operand).toString());
        } else if (operand instanceof Boolean) {
            return ((String) operand).toString();
        } else if (operand instanceof Date) {
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            String sDate = df.format((Date) operand);
            return String.format("'%s'", sDate);
        } else if (operand instanceof EdmProperty) {
            return ((EdmProperty) operand).getMapping().getInternalName().toString();
        } else {
            throw new ODataApplicationException("Class " + operand.getClass().getCanonicalName() + " not expected",
                    HttpStatusCode.INTERNAL_SERVER_ERROR.getStatusCode(), Locale.ENGLISH);
        }
    }

    @Override
    public Object visitUnaryOperator(UnaryOperatorKind operator, Object operand)
            throws ExpressionVisitException, ODataApplicationException {
        throw new ODataApplicationException("Unary operators are not implemented",
                HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public Object visitMethodCall(MethodKind methodCall, List<Object> parameters)
            throws ExpressionVisitException, ODataApplicationException {
        throw new ODataApplicationException("Method calls are not implemented",
                HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public Object visitLambdaExpression(String lambdaFunction, String lambdaVariable, Expression expression)
            throws ExpressionVisitException, ODataApplicationException {
        throw new ODataApplicationException("Lambda expressions are not implemented",
                HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public Object visitLiteral(Literal literal) throws ExpressionVisitException, ODataApplicationException {
        // To keep this tutorial simple, our filter expression visitor supports only
        // Edm.Int32 and Edm.String
        // In real world scenarios it can be difficult to guess the type of an literal.
        // We can be sure, that the literal is a valid OData literal because the URI
        // Parser checks
        // the lexicographical structure

        // String literals start and end with an single quotation mark
        String literalAsString = literal.getText();
        if (literal.getType() instanceof EdmString) {
            String stringLiteral = "";
            if (literal.getText().length() > 2) {
                stringLiteral = literalAsString.substring(1, literalAsString.length() - 1);
            }
            return stringLiteral;
        } else if (literal.getType() instanceof EdmDate) {
            try {
                DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                Date date = format.parse(literalAsString);
                return date;
            } catch (ParseException e) {
                String errMsg = String.format("Error convertion %s to date. e.Message: %s", literalAsString, e.getMessage());
                throw new ODataApplicationException(errMsg, HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(),
                        Locale.ENGLISH);
            }
        } else if (EdmInt64.getInstance().isCompatible((EdmPrimitiveType) literal.getType())) {
            try {
                return Long.parseLong(literalAsString);
            } catch (NumberFormatException e) {
                String errMsg = String.format("Error convertion '%s' to Long. e.Message: %s", literalAsString, e.getLocalizedMessage());
                throw new ODataApplicationException(errMsg, HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(),
                        Locale.ENGLISH);
            }
        } else if (literal.getType() instanceof EdmBoolean) {
                return literalAsString;
        } else {
            String errMsg = String.format("Type %s not implemented", literal.getType().toString());
            throw new ODataApplicationException(errMsg, HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
        }
    }

    @Override
    public Object visitMember(Member member) throws ExpressionVisitException, ODataApplicationException {
        // To keeps things simple, this tutorial allows only primitive properties.
        // We have faith that the java type of Edm.Int32 is Integer
        final List<UriResource> uriResourceParts = member.getResourcePath().getUriResourceParts();

        // Make sure that the resource path of the property contains only a single
        // segment and a
        // primitive property has been addressed. We can be sure, that the property
        // exists because
        // the UriParser checks if the property has been defined in service metadata
        // document.

        if (uriResourceParts.size() == 1 && uriResourceParts.get(0) instanceof UriResourcePrimitiveProperty) {
            UriResourcePrimitiveProperty uriResourceProperty = (UriResourcePrimitiveProperty) uriResourceParts.get(0);
            return uriResourceProperty.getProperty();
        } else {
            // The OData specification allows in addition complex properties and navigation
            // properties with a target cardinality 0..1 or 1.
            // This means any combination can occur e.g. Supplier/Address/City
            // -> Navigation properties Supplier
            // -> Complex Property Address
            // -> Primitive Property City
            // For such cases the resource path returns a list of UriResourceParts
            throw new ODataApplicationException("Only primitive properties are implemented in filter expressions",
                    HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
        }
    }
    
    @Override
    public String visitAlias(String aliasName) throws ExpressionVisitException, ODataApplicationException {
        throw new ODataApplicationException("Aliases are not implemented",
                HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public String visitTypeLiteral(EdmType type) throws ExpressionVisitException, ODataApplicationException {
        throw new ODataApplicationException("Type literals are not implemented",
                HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public String visitLambdaReference(String variableName) throws ExpressionVisitException, ODataApplicationException {
        throw new ODataApplicationException("Lambda references are not implemented",
                HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
    }

    @Override
    public String visitEnum(EdmEnumType type, List<String> enumValues)
            throws ExpressionVisitException, ODataApplicationException {
        throw new ODataApplicationException("Enums are not implemented",
                HttpStatusCode.NOT_IMPLEMENTED.getStatusCode(), Locale.ENGLISH);
    }    
}
