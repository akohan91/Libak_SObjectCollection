public with sharing class SObjectCollection {
	private List<SObject> records;

	public SObjectCollection(List<SObject> records) {
		this.records = records;
	}

	public List<SObject> filter(FilterBlock condition) {
		List<SObject> filteredList = new List<SObject>();
		Integer i = this.records.size();
		while (i > 0) {
			i -=1;
			if (condition.match(this.records.get(i))) {
				filteredList.add(this.records.get(i));
			}
		}
		return filteredList;
	}
}