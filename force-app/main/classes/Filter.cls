/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Represents a filter condition that can be applied to an SObject field. 
 * Supports various comparison operators.
 */
public with sharing class Filter implements ICondition {

	// Mapping of operator strings to their corresponding FieldComparator classes.
	private Map<String, Type> operatorToMatcher = new Map<String, Type>{
		'=='     => FieldComparator.Equal.class,
		'!='     => FieldComparator.NotEqual.class,
		'>'      => FieldComparator.Greater.class,
		'>='     => FieldComparator.GreaterOrEqual.class,
		'<'      => FieldComparator.Less.class,
		'<='     => FieldComparator.LessOrEqual.class,
		'IN'     => FieldComparator.Includes.class,
		'NOT IN' => FieldComparator.NotIncludes.class
	};
	
	// The name of the field to be compared.
	private String fieldName;
	
	// The value to compare the field against.
	private Object value;
	
	// The comparator used to perform the comparison.
	private FieldComparator matcher;

	/**
	 * Constructs a new Filter with the specified field name, operator, and value.
	 *
	 * @param fieldName The name of the field to be compared.
	 * @param operator The comparison operator (e.g., "==", "!=", ">", "<", ">=", "<=", "IN", "NOT IN").
	 * @param value The value to compare the field against.
	 */
	public Filter(String fieldName, String operator, Object value) {
		this.fieldName = fieldName;
		this.value = value;
		this.matcher = (FieldComparator)this.operatorToMatcher.get(operator).newInstance();
	}

	/**
	 * Determines whether the given SObject record matches the filter condition.
	 *
	 * @param record The SObject record to be evaluated.
	 * @return true if the record matches the filter condition; false otherwise.
	 */
	public Boolean match(SObject record) {
		return this.matcher.compare(this.fieldName, this.value, record);
	}
}
