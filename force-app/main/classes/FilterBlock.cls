/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Represents a composite filter condition that can be composed of multiple ISObjectMatchable conditions
 * combined with logical operators (AND/OR).
 */
public with sharing class FilterBlock implements ISObjectMatchable {
	
	// List of conditions that make up this filter block.
	private List<ISObjectMatchable> conditions = new List<ISObjectMatchable>();
	
	// Logical operator used to combine conditions ("&&" for AND, "||" for OR).
	private String operator;

	/**
	 * Constructs a new FilterBlock with the specified logical operator.
	 *
	 * @param operator The logical operator used to combine conditions ("&&" for AND, "||" for OR).
	 */
	public FilterBlock(String operator) {
		this.operator = operator;
	}

	/**
	 * Adds a condition to this FilterBlock.
	 *
	 * @param condition The condition to add.
	 * @return This FilterBlock instance (for method chaining).
	 */
	public FilterBlock add(ISObjectMatchable condition) {
		this.conditions.add(condition);
		return this;
	}

	/**
	 * Determines whether the given SObject record matches the conditions of this FilterBlock.
	 *
	 * @param record The SObject record to be evaluated.
	 * @return true if the record matches the conditions; false otherwise.
	 */
	public Boolean match(SObject record) {
		return this.operator == '&&'
			? this.matchAnd(record)
			: this.matchOR(record);
	}

	/**
	 * Evaluates the conditions using logical AND.
	 *
	 * @param record The SObject record to be evaluated.
	 * @return true if the record matches all conditions; false otherwise.
	 */
	private Boolean matchAnd(SObject record) {
		Integer i = this.conditions.size();
		while (i > 0) {
			i -= 1;
			if (!this.conditions.get(i).match(record)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * Evaluates the conditions using logical OR.
	 *
	 * @param record The SObject record to be evaluated.
	 * @return true if the record matches any condition; false otherwise.
	 */
	private Boolean matchOR(SObject record) {
		Integer i = this.conditions.size();
		while (i > 0) {
			i -= 1;
			if (conditions.get(i).match(record)) {
				return true;
			}
		}
		return true;
	}
}
