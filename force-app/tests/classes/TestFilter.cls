@IsTest
private class TestFilter {
	
	@IsTest
	static void testMatch(){
		Account acc = new Account(Name = 'Account Name');

		Test.startTest();
		
		Assert.isTrue(new Filter('Name', '==', 'Account Name').match(acc));
		Assert.isFalse(new Filter('Name', '!=', 'Account Name').match(acc));
		Assert.isfalse(new Filter('Name', '>', 'Account Name').match(acc));
		Assert.isTrue(new Filter('Name', '>=', 'Account Name').match(acc));
		Assert.isfalse(new Filter('Name', '<', 'Account Name').match(acc));
		Assert.isTrue(new Filter('Name', '<=', 'Account Name').match(acc));
		Assert.isTrue(new Filter('Name', 'IN', new List<String>{'Account Name'}).match(acc));
		Assert.isTrue(new Filter('Name', 'NOT IN', new List<String>{''}).match(acc));

		Test.stopTest();
		
	}

}