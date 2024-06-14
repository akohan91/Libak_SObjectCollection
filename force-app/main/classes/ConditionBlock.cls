public with sharing class ConditionBlock {
	private Map<String, Type> operatorToMatcher = new Map<String, Type>{
		'&&' => AndImpl.class,
		'||' => OrImpl.class
	};
	private String operator;
	private List<Condition> conditions = new List<Condition>();
	private List<ConditionBlock> blocks = new List<ConditionBlock>();


	public ConditionBlock(String operator) {
		this.operator = operator;
	}

	public ConditionBlock add(ConditionBlock block) {
		this.blocks.add(block);
		return this;
	}

	public ConditionBlock add(Condition condition) {
		this.conditions.add(condition);
		return this;
	}

	public Boolean match(SObject record) {
		IComparable matcher = (IComparable)this.operatorToMatcher.get(this.operator).newInstance();
		return matcher.compare(this.blocks, this.conditions, record);
	}

	public interface IComparable {
		Boolean compare(List<ConditionBlock> blocks, List<Condition> conditions, SObject record);
	}

	public class AndImpl implements IComparable {
		public Boolean compare(List<ConditionBlock> blocks, List<Condition> conditions, SObject record) {
			for (Condition condition : conditions) {
				if (!condition.match(record)) {
					return false;
				}
			}
			for (ConditionBlock block : blocks) {
				if (!block.match(record)) {
					return false;
				}
			}
			return true;
		}
	}

	public class OrImpl implements IComparable {
		public Boolean compare(List<ConditionBlock> blocks, List<Condition> conditions, SObject record) {
			for (Condition condition : conditions) {
				if (condition.match(record)) {
					return true;
				}
			}
			for (ConditionBlock block : blocks) {
				if (block.match(record)) {
					return true;
				}
			}
			return false;
		}
	}
}