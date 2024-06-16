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

	public class Greater extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value) == 1;
		}
	}

	public class GreaterOrEqual extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			Integer result = new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value);
			return result == 0 || result == 1;
		}
	}

	public class Less extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value) == -1;
		}
	}

	public class LessOrEqual extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			Integer result = new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value);
			return result == 0 || result == -1;
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
	
	public class ComparableValue implements Comparable {
	
		public Object sObjectValue;
		
		public ComparableValue(Object sObjectValue) {
			this.sObjectValue = sObjectValue;
		}
		
		public Integer compareTo(Object filterValue) {
			if (this.sObjectValue instanceOf Date) {
				Date value1 = (Date)this.sObjectValue;
				Date value2 = (Date)filterValue;
				
				if (value1 == value2) return 0;
				if (value1 > value2) return 1;
				return -1;
			} else if (this.sObjectValue instanceOf Datetime) {
				Datetime value1 = (Datetime)this.sObjectValue;
				Datetime value2 = (Datetime)filterValue;
				
				if (value1 == value2) return 0;
				if (value1 > value2) return 1;
				return -1;
			} else if (this.sObjectValue instanceOf Double) {
				Double value1 = (Double)this.sObjectValue;
				Double value2 = (Double)filterValue;
				
				if (value1 == value2) return 0;
				if (value1 > value2) return 1;
				return -1;
			} else if (this.sObjectValue instanceOf Id) {
				Id value1 = (Id)this.sObjectValue;
				Id value2 = (Id)filterValue;
				
				if (value1 == value2) return 0;
				if (value1 > value2) return 1;
				return -1;
			} else if (this.sObjectValue instanceOf Integer) {
				Integer value1 = (Integer)this.sObjectValue;
				Integer value2 = (Integer)filterValue;
				
				if (value1 == value2) return 0;
				if (value1 > value2) return 1;
				return -1;
			} else if (this.sObjectValue instanceOf String) {
				String value1 = (String)this.sObjectValue;
				String value2 = (String)filterValue;
				
				if (value1 == value2) return 0;
				if (value1 > value2) return 1;
				return -1;
			} else if (this.sObjectValue instanceOf Time) {
				Time value1 = (Time)this.sObjectValue;
				Time value2 = (Time)filterValue;
				
				if (value1 == value2) return 0;
				if (value1 > value2) return 1;
				return -1;
			} else {
				throw new FieldComparatorException('Unsupported type for comparison. Supported types are: Date, Datetime, Double, Id, Integer, String, Time');
			}
		}
	}

	public class FieldComparatorException extends Exception{}
}