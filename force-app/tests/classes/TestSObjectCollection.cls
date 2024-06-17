@IsTest
private class TestSObjectCollection {
	@IsTest
	static void testFilter(){
		List<Account> accs = new List<Account>{
			new Account(Name = 'Account Name 1'),
			new Account(Name = 'Account Name 2')
		};
		
		Test.startTest();
		
		List<Account> filteredAccs = new SObjectCollection(accs).filter(
			new FilterBlock('||')
			.add(new Filter('Name', '==', 'Account Name 0'))
			.add(new Filter('Name', '==', 'Account Name 1'))
		);
		
		Test.stopTest();
		
		Assert.areEqual(1, filteredAccs.size());
		Assert.areEqual('Account Name 1', filteredAccs.get(0).Name);
	}
}