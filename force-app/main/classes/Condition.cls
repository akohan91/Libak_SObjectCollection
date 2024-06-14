public class Condition {
	private Map<String, Type> operatorToMatcher = new Map<String, Type>{
		'==' => Equal.class,
		'!=' => NotEqual.class
	};
	private String fieldName;
	private Object value;
	private IComparable matcher;

	public Condition(String fieldName, String operator, Object value) {
		this.fieldName = fieldName;
		this.value = value;
		this.matcher = (IComparable)this.operatorToMatcher.get(operator).newInstance();
	}

	public Boolean match(SObject record) {
		return this.matcher.compare(this.fieldName, this.value, record);
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