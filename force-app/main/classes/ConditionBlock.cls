public with sharing class ConditionBlock {
	private Map<String, Type> operatorToMatcher = new Map<String, Type>{
		'&&' => AndImpl.class,
		'||' => OrImpl.class
	};
	private List<Condition> conditions = new List<Condition>();
	private List<ConditionBlock> blocks = new List<ConditionBlock>();
	private IComparable matcher;

	public ConditionBlock(String operator) {
		this.matcher = (IComparable)this.operatorToMatcher.get(operator).newInstance();
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
		return this.matcher.compare(this.blocks, this.conditions, record);
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