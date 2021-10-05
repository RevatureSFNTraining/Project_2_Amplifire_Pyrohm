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

}