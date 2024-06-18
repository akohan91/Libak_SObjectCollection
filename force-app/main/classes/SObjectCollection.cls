/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Represents a collection of SObjects and provides functionality to filter them based on custom conditions.
 */
public with sharing class SObjectCollection {
	
	// The list of SObject records in the collection.
	private List<SObject> records;

	/**
	 * Constructs a new SObjectCollection with the given list of SObject records.
	 *
	 * @param records The list of SObject records to be managed by this collection.
	 */
	public SObjectCollection(List<SObject> records) {
		this.records = records;
	}

	/**
	 * Filters the SObject records in this collection based on the specified condition.
	 *
	 * @param condition The filter condition to be applied to the SObject records.
	 * @return A list of SObject records that match the specified filter condition.
	 */
	public List<SObject> filter(ICondition condition) {
		List<SObject> filteredList = new List<SObject>();
		Integer i = this.records.size();
		while (i > 0) {
			i -= 1;
			if (condition.match(this.records.get(i))) {
				filteredList.add(this.records.get(i));
			}
		}
		return filteredList;
	}
}
