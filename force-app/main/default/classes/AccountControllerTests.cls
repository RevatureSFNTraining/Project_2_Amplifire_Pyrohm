@isTest
private class AccountControllerTests {
    @TestSetup
    static void makeData() {
        Ingredient__c testIngredient = new Ingredient__c(Name = 'Test',Ingredient_Price__c = 5, Type_of_Ingredient__c = 'Base');
        insert testIngredient;
        testIngredient = [SELECT Id, Name FROM Ingredient__c WHERE Name='Test' LIMIT 1];
        Potion__c testPotion = new Potion__c(Name = 'TestPot', Base_Ingredient__c = testIngredient.Id, Type_of_Potion__c = 'Healing');
        insert testPotion;
        testPotion = [SELECT Id, Name FROM Potion__c WHERE Name='TestPot' LIMIT 1];
        
        List<Potion_Review__c> reviews = new List<Potion_Review__c>();
        for(Integer i = 1; i < 101; i++) {
            reviews.add(new Potion_Review__c(Reviewer_Name__c = 'Reviewer' + i, Review_Message__c = 'This is a Review', Review_Rating__c = Math.mod(i, 6), Potion_Type__c = testPotion.Id));
        }
        
        Insert reviews;
        
        List<Potion__c> potions = new List<Potion__c>();
        for(Integer i = 0; i < 100; i++) {
            potions.add(new Potion__c(Name = ('TestPot' + Math.mod(i, 6)), Base_Ingredient__c = testIngredient.Id, Type_of_Potion__c = 'Healing'));
        }
        
        Insert potions;
    }
    
    @isTest static void testGetReviews() {
        Test.startTest();
        System.assertEquals(100, DisplayReviewsController.getReviews().size());
        Test.stopTest();
    }
    
    @isTest static void testFilterByPotion() {
        Test.startTest();
        Id testPot = [SELECT Id FROM Potion__c WHERE Name='TestPot' LIMIT 1].Id;
        System.assertEquals(1, DisplayReviewsController.filterByPotion(testPot).size());
        Test.stopTest();
    }
    
    @isTest static void testFilterByReviewer() {
        Test.startTest();
         
        Test.stopTest();
    }
        
    @isTest static void testFilterByRating() {
        Test.startTest();
        System.assertEquals(16, DisplayReviewsController.filterByRating(0).size());
        System.assertEquals(17, DisplayReviewsController.filterByRating(1).size());
        System.assertEquals(17, DisplayReviewsController.filterByRating(2).size());
        System.assertEquals(17, DisplayReviewsController.filterByRating(3).size());
        System.assertEquals(17, DisplayReviewsController.filterByRating(4).size());
        System.assertEquals(16, DisplayReviewsController.filterByRating(5).size());
        Test.stopTest();
    }
    
    @isTest static void testGetPotionName() {
        Test.startTest();
        Id testPotionId = [SELECT Id FROM Potion__c WHERE Name='TestPot' LIMIT 1].Id;
        System.debug(testPotionId);
        System.assertEquals('TestPot', DisplayReviewsController.getPotionName(testPotionId));
        Test.stopTest();
    }
    
    @isTest static void testGetPotions() {
        Test.startTest();
        System.assertEquals(101, DisplayReviewsController.getPotions().size());
        Test.stopTest();
    }
        
    @isTest static void testGetPotion() {
        Test.startTest();
        Id testPotionId = [SELECT Id FROM Potion__c WHERE Name='TestPot' LIMIT 1].Id;
        Potion__c testVal = DisplayReviewsController.getPotion(testPotionId);
        System.assertEquals('TestPot', testVal.Name);
        System.assertEquals(testPotionId, testVal.Id);
        Test.stopTest();
    }
}