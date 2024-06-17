/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Abstract class representing a field comparator used to compare SObject field values against specified values.
 */
public abstract class FieldComparator {

	/**
	 * Compares the value of a specified field in an SObject record against a given value.
	 *
	 * @param fieldName The name of the field to compare.
	 * @param value The value to compare the field against.
	 * @param record The SObject record containing the field.
	 * @return true if the comparison is successful; false otherwise.
	 */
	abstract public Boolean compare(String fieldName, Object value, SObject record);
	
	/**
	 * Retrieves the value of a specified field from an SObject record. Supports nested field names (e.g., "ParentField.ChildField").
	 *
	 * @param record The SObject record containing the field.
	 * @param fieldName The name of the field to retrieve.
	 * @return The value of the field.
	 */
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

	/**
	 * Comparator for equality comparison.
	 */
	public class Equal extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return this.fieldValue(record, fieldName) == value;
		}
	}

	/**
	 * Comparator for inequality comparison.
	 */
	public class NotEqual extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return this.fieldValue(record, fieldName) != value;
		}
	}

	/**
	 * Comparator for greater than comparison.
	 */
	public class Greater extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value) == 1;
		}
	}

	/**
	 * Comparator for greater than or equal to comparison.
	 */
	public class GreaterOrEqual extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			Integer result = new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value);
			return result == 0 || result == 1;
		}
	}

	/**
	 * Comparator for less than comparison.
	 */
	public class Less extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value) == -1;
		}
	}

	/**
	 * Comparator for less than or equal to comparison.
	 */
	public class LessOrEqual extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			Integer result = new ComparableValue(this.fieldValue(record, fieldName)).compareTo(value);
			return result == 0 || result == -1;
		}
	}

	/**
	 * Comparator for inclusion comparison.
	 */
	public class Includes extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return ((List<Object>)value).contains(this.fieldValue(record, fieldName));
		}
	}

	/**
	 * Comparator for exclusion comparison.
	 */
	public class NotIncludes extends FieldComparator {
		override public Boolean compare(String fieldName, Object value, SObject record) {
			return !((List<Object>)value).contains(this.fieldValue(record, fieldName));
		}
	}

	/**
	 * Wrapper class to handle comparison of various data types.
	 */
	public class ComparableValue implements Comparable {
	
		// The value of the SObject field to be compared.
		public Object sObjectValue;
		
		/**
		 * Constructs a new ComparableValue with the specified SObject field value.
		 *
		 * @param sObjectValue The value of the SObject field.
		 */
		public ComparableValue(Object sObjectValue) {
			this.sObjectValue = sObjectValue;
		}
		
		/**
		 * Compares this value against the specified filter value.
		 *
		 * @param filterValue The value to compare against.
		 * @return 0 if the values are equal, 1 if this value is greater, -1 if this value is less.
		 * @throws FieldComparatorException If the data type is not supported.
		 */
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

	/**
	 * Exception thrown for unsupported types in field comparisons.
	 */
	public class FieldComparatorException extends Exception {}
}
