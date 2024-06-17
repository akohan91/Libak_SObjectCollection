@IsTest
private class TestFieldComparator {
	
	@IsTest
	static void testEqual(){
		Account acc = new Account(Name = 'Acount Name');

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.Equal().compare('Name', 'Acount Name', acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.Equal().compare('Name', 'Wrong Account Name', acc),
			'The result of comparison has to be false'
		);

		Test.stopTest();
	}
	
	@IsTest
	static void testNotEqual(){
		Account acc = new Account(Name = 'Acount Name');

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.NotEqual().compare('Name', 'Wrong Account Name', acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.NotEqual().compare('Name', 'Acount Name', acc),
			'The result of comparison has to be false'
		);

		Test.stopTest();
	}
	
	@IsTest
	static void testGreater(){
		Account acc = new Account(NumberOfEmployees = 2);

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.Greater().compare('NumberOfEmployees', 1, acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.Greater().compare('NumberOfEmployees', 3, acc),
			'The result of comparison has to be false'
		);

		Test.stopTest();
	}

	@IsTest
	static void testGreaterOrEqual(){
		Account acc = new Account(NumberOfEmployees = 3);

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.GreaterOrEqual().compare('NumberOfEmployees', 2, acc),
			'The result of comparison has to be True'
		);
		Assert.isTrue(
			new FieldComparator.GreaterOrEqual().compare('NumberOfEmployees', 3, acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.GreaterOrEqual().compare('NumberOfEmployees', 4, acc),
			'The result of comparison has to be false'
		);

		Test.stopTest();
	}
	
	@IsTest
	static void testLess(){
		Account acc = new Account(NumberOfEmployees = 2);

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.Less().compare('NumberOfEmployees', 3, acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.Less().compare('NumberOfEmployees', 1, acc),
			'The result of comparison has to be false'
		);

		Test.stopTest();
	}
	
	@IsTest
	static void testLessOrEqual(){
		Account acc = new Account(NumberOfEmployees = 1);

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.LessOrEqual().compare('NumberOfEmployees', 2, acc),
			'The result of comparison has to be True'
		);
		Assert.isTrue(
			new FieldComparator.LessOrEqual().compare('NumberOfEmployees', 1, acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.LessOrEqual().compare('NumberOfEmployees', 0, acc),
			'The result of comparison has to be false'
		);

		Test.stopTest();
	}
	
	@IsTest
	static void testIncludes(){
		Account acc = new Account(NumberOfEmployees = 1);

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.Includes().compare('NumberOfEmployees', new List<Integer>{1,2}, acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.Includes().compare('NumberOfEmployees', new List<Integer>{2,3}, acc),
			'The result of comparison has to be False'
		);

		Test.stopTest();
	}
	
	@IsTest
	static void testNotIncludes(){
		Account acc = new Account(NumberOfEmployees = 0);

		Test.startTest();
		
		Assert.isTrue(
			new FieldComparator.NotIncludes().compare('NumberOfEmployees', new List<Integer>{1,2}, acc),
			'The result of comparison has to be True'
		);
		Assert.isFalse(
			new FieldComparator.NotIncludes().compare('NumberOfEmployees', new List<Integer>{0,1,2,3}, acc),
			'The result of comparison has to be False'
		);

		Test.stopTest();
	}

	@IsTest
	static void testComparableValueDateType(){
		FieldComparator.ComparableValue instance = new FieldComparator.ComparableValue(Date.today());

		Test.startTest();
		
		Assert.areEqual(-1, instance.compareTo(Date.today().addDays(1)));
		Assert.areEqual(0, instance.compareTo(Date.today()));
		Assert.areEqual(1, instance.compareTo(Date.today().addDays(-1)));

		Test.stopTest();
	}

	@IsTest
	static void testComparableValueDateTimeType(){
		Datetime now = Datetime.now();
		FieldComparator.ComparableValue instance = new FieldComparator.ComparableValue(now);

		Test.startTest();
		
		Assert.areEqual(-1, instance.compareTo(now.addDays(1)));
		Assert.areEqual(0, instance.compareTo(now));
		Assert.areEqual(1, instance.compareTo(now.addDays(-1)));

		Test.stopTest();
	}

	@IsTest
	static void testComparableValueDoubleType(){
		FieldComparator.ComparableValue instance = new FieldComparator.ComparableValue(1.1);

		Test.startTest();
		
		Assert.areEqual(-1, instance.compareTo(1.2));
		Assert.areEqual(0, instance.compareTo(1.1));
		Assert.areEqual(1, instance.compareTo(1.0));

		Test.stopTest();
	}

	@IsTest
	static void testComparableValueIntegerType(){
		FieldComparator.ComparableValue instance = new FieldComparator.ComparableValue((Integer)1);

		Test.startTest();
		
		Assert.areEqual(-1, instance.compareTo(2));
		Assert.areEqual(0, instance.compareTo(1));
		Assert.areEqual(1, instance.compareTo(0));

		Test.stopTest();
	}

	@IsTest
	static void testComparableValueStringType(){
		FieldComparator.ComparableValue instance = new FieldComparator.ComparableValue('1');

		Test.startTest();
		
		Assert.areEqual(-1, instance.compareTo('2'));
		Assert.areEqual(0, instance.compareTo('1'));
		Assert.areEqual(1, instance.compareTo('0'));

		Test.stopTest();
	}

	@IsTest
	static void testComparableValueTimeType(){
		Time t = Time.newInstance(12, 0, 0, 0);
		FieldComparator.ComparableValue instance = new FieldComparator.ComparableValue(t);

		Test.startTest();
		
		Assert.areEqual(-1, instance.compareTo(t.addHours(1)));
		Assert.areEqual(0, instance.compareTo(t));
		Assert.areEqual(1, instance.compareTo(t.addHours(-1)));

		Test.stopTest();
	}

	@IsTest
	static void testComparableIdType(){
		Id mockId_1 = Id.valueOf('001000000000001AAA');
		Id mockId_2 = Id.valueOf('001000000000002AAA');
		Id mockId_3 = Id.valueOf('001000000000003AAA');
		FieldComparator.ComparableValue instance = new FieldComparator.ComparableValue(mockId_2);

		Test.startTest();
		
		Assert.areEqual(-1, instance.compareTo(mockId_3));
		Assert.areEqual(0, instance.compareTo(mockId_2));
		Assert.areEqual(1, instance.compareTo(mockId_1));

		Test.stopTest();
	}

	@IsTest
	static void testRelationFields(){
		Case caseItem = (Case)JSON.deserialize('{ "attributes" : { "type" : "Case", "url" : "/services/data/v61.0/sobjects/Case/500H4000002ua9TIAQ" }, "AccountId" : "001H4000008iMwhIAE", "Id" : "500H4000002ua9TIAQ", "Account" : { "attributes" : { "type" : "Account", "url" : "/services/data/v61.0/sobjects/Account/001H4000008iMwhIAE" }, "Id" : "001H4000008iMwhIAE", "Name" : "Account Name" } }', Case.class);

		Test.startTest();
		
		Assert.isTrue(new FieldComparator.Equal().compare('Account.Name', 'Account Name', caseItem));

		Test.stopTest();
	}
}