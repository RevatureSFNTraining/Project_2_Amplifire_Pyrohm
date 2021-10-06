@isTest
public class PotionCatalogueControllerTest {

@TestSetup
static void makeData() {
//create single base Ingredient
Ingredient__c myIngr = new Ingredient__c(Name = 'TheIngredient', Ingredient_Price__c = 0.6, Type_of_Ingredient__c = 'Base'); 
insert myIngr;

//create a secondary Ingredient
Ingredient__c secIngr = new Ingredient__c(Name='ingr2', Ingredient_Price__c = 0.3, Type_of_Ingredient__c= 'Secondary', Available_Potion__c='Healing');
insert secIngr;

List<Potion__C> testPotions = new List<Potion__c>();
for (Integer i = 0; i < 120; i++) {
    testPotions.add(new Potion__c(name = 'Pot' + i,
    Base_Ingredient__c = myIngr.Id, Type_of_Potion__c = 'Healing'));
}
insert testPotions;
}

@isTest public static void testGettingPotions() {
//see if this method is returning the 100 records we have created earlier

    //getting the single secondary Ingredient from the Setup
    Ingredient__c mySec = [SELECT id, name, Ingredient_Price__c, Type_of_Ingredient__c, Available_Potion__c FROM Ingredient__c WHERE Available_Potion__c = 'Healing'][0];
    Ingredient__c myBase = [SELECT id, name, Ingredient_Price__c, Type_of_Ingredient__c FROM Ingredient__c WHERE Type_of_Ingredient__c = 'Base'][0];

    Potion__c myOne = new Potion__c(Name='myPoo', Base_Ingredient__c = myBase.Id, Secondary_Ingredient__c = mySec.Id, Type_of_Potion__c = 'Healing');
    insert myOne;

    List<Potion__c> myList = PotionCatalogueController.fetchPotionList();

    Test.startTest(); 
    System.assertEquals(121, myList.size());
    Test.stopTest();
}

@isTest public static void testGettingPotionsNegative() {

    //getting the single secondary Ingredient from the Setup
    Ingredient__c mySec = [SELECT id, name, Ingredient_Price__c, Type_of_Ingredient__c, Available_Potion__c FROM Ingredient__c WHERE Available_Potion__c = 'Healing'][0];
    Ingredient__c myBase = [SELECT id, name, Ingredient_Price__c, Type_of_Ingredient__c FROM Ingredient__c WHERE Type_of_Ingredient__c = 'Base'][0];

    Potion__c myWrongOne = new Potion__c ();
    myWrongOne.Name = 'newWrong';
    myWrongOne.Base_Ingredient__c = myBase.Id;
    myWrongOne.Secondary_Ingredient__c = mySec.Id;
    myWrongOne.Type_of_Potion__c = 'Sleep';

    Test.startTest();
    Database.SaveResult res =  Database.insert(myWrongOne, false);
    List<Potion__c> fetchingRes = PotionCatalogueController.fetchPotionList();           
    Test.stopTest();

    System.assertEquals(120 , fetchingRes.size());
    System.assert(! res.isSuccess());
    System.assert(res.getErrors().size() > 0);
    System.assertEquals('Value does not exist or does not match filter criteria.', res.getErrors()[0].getMessage());
}

@isTest public static void  savingPositiveTest() {
        Account myAcc = new Account(Name='myTest');
        insert myAcc;
    
        Potion__c myPotion = [SELECT name, id FROM Potion__c LIMIT 1];

        //create an potion order
        Potion_Order__c myOrder = new Potion_Order__c(Account_Purchasing__c = myAcc.id, Number_of_Potions__c = 2, Potion_Type__c = myPotion.id);

        Test.startTest();
        Potion_Order__c res = PotionCatalogueController.saveOrder(myOrder);
        Test.stopTest();

        System.assertEquals(myOrder, res);
}

@isTest public static void savingNegativeTest() {
        Account myAcc = new Account(Name='myTest');
        insert myAcc;

        Potion__c myPotion = [SELECT name, id FROM Potion__c LIMIT 1];

        //create an potion order
        Potion_Order__c myOrder = new Potion_Order__c(Account_Purchasing__c = myAcc.id, Number_of_Potions__c = 0, Potion_Type__c = myPotion.id);

        String err = '';

        try {
            Potion_Order__c res = PotionCatalogueController.saveOrder(myOrder);
        } catch (Exception e) {
        err = e.getMessage();
        }

        System.assertEquals(err, 'Upsert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, Please enter positive integer between 1 and 9999999: [Number_of_Potions__c]');
}

@isTest public static void savingBulkPositive() {
    //bulk Test
        Account myAcc = new Account(Name='myTest');
        insert myAcc;

        Potion__c myPotion = [SELECT name, id FROM Potion__c LIMIT 1];
        List<Potion_Order__c> myOrders = new List<Potion_Order__c>();

        for (Integer i = 1; i < 130; i++) {
            Potion_Order__c newOrder = new Potion_Order__c(Account_Purchasing__c = myAcc.id, Number_of_Potions__c = i, Potion_Type__c = myPotion.id);
            myOrders.add(newOrder);
        }

        Test.startTest();
        for (Potion_Order__c p : myOrders) {
            Potion_Order__c res = PotionCatalogueController.saveOrder(p);
        }       
        Test.stopTest();

        System.assertEquals( 129 ,[SELECT id FROM Potion_Order__c].size());
}

@isTest public static void getOptions() {
        //getting all the strings in a list from the controller
        String[] options = PotionCatalogueController.getOptions();

        List<String> mockData = new List<String>{'Healing', 'Poison', 'Speed', 'Visions', 'Sleep'};

        System.assertEquals(options.size(), 5);
        System.assertEquals(options, mockData);
}

@isTest public static void getOptionsNegative() {
    //getting all the strings in a list from the controller negative test
    String[] options = PotionCatalogueController.getOptions();

    List<String> mockData = new List<String>{'some', 'Poison', 'Speed', 'Sleep'};

    System.assertEquals(options.size(), 5);
    System.assertNotEquals(options.size(), mockData.size());
    System.assertNotEquals(options, mockData);
    
}

}