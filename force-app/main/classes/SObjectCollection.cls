public with sharing class SObjectCollection {
	private List<SObject> records;

	public SObjectCollection(List<SObject> records) {
		this.records = records;
	}

	public List<SObject> filter(ConditionBlock condition) {
		List<SObject> filteredList = new List<SObject>();
		for (SObject record : this.records) {
			if (condition.match(record)) {
				filteredList.add(record);
			}
		}
		return filteredList;
	}
}