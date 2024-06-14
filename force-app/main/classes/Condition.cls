public class Condition {
	private Map<String, Type> operatorToMatcher = new Map<String, Type>{
		'==' => Equal.class,
		'!=' => NotEqual.class
	};
	private String fieldName;
	private String operator;
	private Object value;

	public Condition(String fieldName, String operator, Object value) {
		this.fieldName = fieldName;
		this.operator = operator;
		this.value = value;
	}

	public Boolean match(SObject record) {
		return (
			(IComparable)this.operatorToMatcher
			.get(this.operator)
			.newInstance()
		).compare(this.fieldName, this.value, record);
	}

	public interface IComparable {
		Boolean compare(String fieldName, Object value, SObject record);
	}

	public class Equal implements IComparable {
		public Boolean compare(String fieldName, Object value, SObject record) {
			return record.get(fieldName) == value;
		}
	}

	public class NotEqual implements IComparable {
		public Boolean compare(String fieldName, Object value, SObject record) {
			return record.get(fieldName) != value;
		}
	}
}