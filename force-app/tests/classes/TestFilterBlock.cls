@IsTest
private class TestFilterBlock {
	@IsTest
	static void testMatchAnd(){
		Account acc = new Account(Name = 'Account Name', NumberOfEmployees = 3);

		Test.startTest();
		
		Assert.isTrue(
			new FilterBlock('&&')
			.add(new Filter('Name', '==', 'Account Name'))
			.add(new Filter('NumberOfEmployees', '==', 3))
			.match(acc)
		);

		Test.stopTest();
	}

	@IsTest
	static void testMatchOr(){
		Account acc = new Account(NumberOfEmployees = 3);

		Test.startTest();
		
		Assert.isTrue(
			new FilterBlock('||')
			.add(new Filter('NumberOfEmployees', '==', 2))
			.add(new Filter('NumberOfEmployees', '==', 3))
			.match(acc)
		);

		Test.stopTest();
	}
}