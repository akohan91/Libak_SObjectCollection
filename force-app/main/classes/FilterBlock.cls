public with sharing class FilterBlock implements ISObjectMatchable {
	private List<ISObjectMatchable> conditions = new List<ISObjectMatchable>();
	private String operator;

	public FilterBlock(String operator) {
		this.operator = operator;
	}

	public FilterBlock add(ISObjectMatchable condition) {
		this.conditions.add(condition);
		return this;
	}

	public Boolean match(SObject record) {
		return this.operator == '&&'
			? this.matchAnd(record)
			: this.matchOR(record);
	}

	private Boolean matchAnd(SObject record) {
		Integer i = this.conditions.size();
		while (i > 0) {
			i-= 1;
			if (!this.conditions.get(i).match(record)) {
				return false;
			}
		}
		return true;
	}
	
	private Boolean matchOR(SObject record) {
		Integer i = this.conditions.size();
		while (i > 0) {
			i-= 1;
			if (conditions.get(i).match(record)) {
				return true;
			}
		}
		return true;
	}
}