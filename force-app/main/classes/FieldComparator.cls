public abstract class FieldComparator {
	
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


	public class Equal extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return this.fieldValue(record, fieldName) == value;
		}
	}

	public class NotEqual extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return this.fieldValue(record, fieldName) != value;
		}
	}

	public class Includes extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return ((LIST<Object>)value).contains(this.fieldValue(record, fieldName));
		}
	}

	public class NotIncludes extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return !((LIST<Object>)value).contains(this.fieldValue(record, fieldName));
		}
	}
}