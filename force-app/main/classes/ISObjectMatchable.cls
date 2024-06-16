/**
 * @author Andrei Kakhanouski <akohan91@gmail.com>
 * 
 * Defines a contract for matching SObjects against a specific condition.
 */
public interface ISObjectMatchable {

	/**
	 * Determines whether the given SObject record matches the specified condition.
	 *
	 * @param record The SObject record to be evaluated.
	 * @return true if the record matches the condition; false otherwise.
	 */
	Boolean match(SObject record);
}
