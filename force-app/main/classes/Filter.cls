public with sharing class Filter implements ISObjectMatchable {
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
	private String fieldName;
	private Object value;
	private FieldComparator matcher;

	public Filter(String fieldName, String operator, Object value) {
		this.fieldName = fieldName;
		this.value = value;
		this.matcher = (FieldComparator)this.operatorToMatcher.get(operator).newInstance();
	}

	public Boolean match(SObject record) {
		return this.matcher.compare(this.fieldName, this.value, record);
	}
}