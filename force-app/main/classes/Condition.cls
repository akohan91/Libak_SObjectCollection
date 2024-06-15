public class Condition {
	private Map<String, Type> operatorToMatcher = new Map<String, Type>{
		'==' => Equal.class,
		'!=' => NotEqual.class,
		'IN' => Includes.class,
		'NOT IN' => NotIncludes.class
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

	public abstract class IComparable {
		abstract public Boolean compare(String fieldName, Object value, SObject record);
		protected Object fieldValue(SObject record, String fieldName) {
			if (!fieldName.contains('.')) {
				return record.get(fieldName);
			}
			List<String> fieldChunks = fieldName.split('\\.');
			while (fieldChunks.size() > 1) {
				record = (SObject)record.getPopulatedFieldsAsMap().get(fieldChunks.remove(0));
			}
			return record.get(fieldChunks.remove(0));
		}
	}

	public class Equal extends IComparable {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return this.fieldValue(record, fieldName) == value;
		}
	}

	public class NotEqual extends IComparable {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return this.fieldValue(record, fieldName) != value;
		}
	}

	public class Includes extends IComparable {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return ((LIST<Object>)value).contains(this.fieldValue(record, fieldName));
		}
	}

	public class NotIncludes extends IComparable {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return !((LIST<Object>)value).contains(this.fieldValue(record, fieldName));
		}
	}
}