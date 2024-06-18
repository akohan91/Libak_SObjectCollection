![LibAK logo](assets/small_logo.png)

# Libak SObject Collection

This library provides classes and interfaces for filtering Salesforce SObject records based on specified conditions.

## Usage Example

Here is an example of how to use the library:

```java
List<SObject> records = /* some list of SObjects */;
List<SObject> filteredRecords = new SObjectCollection(records)
.filter(new FilterBlock('AND', new List<ICondition>{
	new Filter('Name', 'IN', new List<String>{'Acme', 'Acme 1', 'Acme 2'}),
	new Filter('Industry', '!=', 'Retail')
}));
```

Here is an example with nested conditions:
```java
List<SObject> records = /* some list of SObjects */;
List<SObject> filteredRecords = new SObjectCollection(cases)
.filter(new FilterBlock('AND', new List<ICondition>{
	new FilterBlock('||', new List<ICondition>{
		new Filter('Origin', '==', 'Email'),
		new Filter('Origin', '==', 'Phone')
	}),
	new Filter('Type', '==', 'Mechanical'),
	new Filter('Account.Name', 'IN', new List<String>{'Wong and Sons','Lane and Sons'})
}));
```

## Classes and Interfaces

### SObjectCollection

The SObjectCollection class manages a collection of SObject records and provides a method to filter these records based on specified conditions.

#### Constructor
`public SObjectCollection(List<SObject> records)`

- Parameters:

`records` - List of SObject records to be managed by this collection.

- Methods

`public List<SObject> filter(ICondition condition)`

Description: Filters the SObject records in the collection based on the specified condition.

-  Parameters:

`condition` - A ICondition object representing the condition to filter the records.

- Returns: 

A list of filtered SObject records.

### ICondition

The ICondition interface defines a method for matching SObject records against specified conditions.

- Methods

`Boolean match(SObject record)`

- Description:
Determines whether the specified SObject record matches the condition.
- Parameters:

`record` - The SObject record to be matched.

- Returns: true if the record matches the condition; false otherwise.

### FilterBlock

The FilterBlock class implements the ICondition interface and represents a composite condition that can contain multiple ICondition conditions combined with a logical operator.

#### Constructor

`public FilterBlock(String operator, List<ICondition> conditions)`

- Parameters:
`operator` - The logical operator to combine the conditions (AND, OR).
`conditions` - The list of ICondition condition to be added.


`public Boolean match(SObject record)`

- Description: Determines whether the specified SObject record matches all conditions in the filter block.

- Parameters:

`record` - The SObject record to be matched.

- Returns: true if the record matches the conditions; false otherwise.

### Filter

The Filter class implements the ICondition interface and represents a condition to compare a field value in an SObject record against a specified value.

#### Constructor

`public Filter(String fieldName, String operator, Object value)`

- Parameters:

`fieldName` - The name of the field to compare.

`operator` - The comparison operator (==, !=, >, >=, <, <=, IN, NOT IN).

`value` - The value to compare the field against.

- Methods

`public Boolean match(SObject record)`

- Description: Determines whether the specified SObject record matches the filter condition.

- Parameters:

`record` - The SObject record to be matched.

- Returns: true if the record matches the condition; false otherwise.

### FieldComparator

The FieldComparator abstract class defines a method for comparing field values in an SObject record against specified values.

- Methods

`abstract public Boolean compare(String fieldName, Object value, SObject record)`

- Description: Compares the value of a specified field in an SObject record against a given value.

- Parameters:

`fieldName` - The name of the field to compare.

`value` - The value to compare the field against.

`record` - The SObject record containing the field.

- Returns: true if the comparison is successful; false otherwise.

- Nested Classes

`Equal`: Compares for equality (==).

`NotEqual`: Compares for inequality (!=).

`Greater`: Compares if greater than (>).

`GreaterOrEqual`: Compares if greater than or equal to (>=).

`Less`: Compares if less than (<).

`LessOrEqual`: Compares if less than or equal to (<=).

`Includes`: Compares if the field value is in a list (IN).

`NotIncludes`: Compares if the field value is not in a list (NOT IN).

`ComparableValue`: The ComparableValue class handles comparisons for various data types.

- Constructor

`public ComparableValue(Object sObjectValue)`

- Parameters:

`sObjectValue` - The value of the SObject field to be compared.

- Methods

`public Integer compareTo(Object filterValue)`

- Description: Compares this value against the specified filter value.

- Parameters:

`filterValue` - The value to compare against.

- Returns: 0 if the values are equal, 1 if this value is greater, -1 if this value is less.

- Throws: FieldComparatorException if the data type is not supported.

`FieldComparatorException`

The FieldComparatorException class is thrown for unsupported types in field comparisons.
