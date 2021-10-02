/*** 
 * Tests for the DisplayReviewsController Class
 *  Code Coverage: 100%
 ***/
@isTest
public class DisplayReviewsControllerTest {
    // Setup the data for running the tests on
    @TestSetup
    static void makeData(){
        // create a test ingredient for making test potions, insert it, then grab it back to get the Id
        Ingredient__c testIngredient = new Ingredient__c(Name = 'Test Ingredient', Ingredient_Price__c = 5,Type_of_Ingredient__c = 'Base');
        insert testIngredient;
        testIngredient = [SELECT Id FROM Ingredient__c WHERE Name = 'Test Ingredient' LIMIT 1];

        // add various potions for testing into the testing 'Org'
        Potion__c testPotion = new Potion__c(Name = 'Test Pot', Base_Ingredient__c = testIngredient.Id, Type_of_Potion__c = 'Healing');
        insert testPotion;
        testPotion = [SELECT Id FROM Potion__c WHERE Name = 'Test Pot' LIMIT 1];

        List<Potion__c> testPotions = new List<Potion__c>();
        for(Integer i = 0; i < 100; i++) {
            testPotions.add(new Potion__c(Name = 'Test Pot' + Math.mod(i,6), Base_Ingredient__c = testIngredient.Id, Type_of_Potion__c = 'Healing'));
        }
        insert testPotions;

        testPotions.clear();
        for(Integer i = 0; i < 6; i++) {
            testPotions.add(new Potion__c(Name = 'TestPot'+i, Base_Ingredient__c = testIngredient.Id, Type_of_Potion__c = 'Healing'));
        }
        insert testPotions;

        // add various reviews for testing into the testing 'Org' 
        List<Potion_Review__c> testReviews = new List<Potion_Review__c>();
        for(Integer i = 0; i < 100; i++) {
            testReviews.add(new Potion_Review__c(Review_Message__c = 'This Is A Test Review',Reviewer_Name__c = 'Reviewer' + Math.mod(i,6),Review_Rating__c = Math.mod(i,6),Potion_Type__c = testPotion.Id));
        }
        insert testReviews;

        testReviews.clear();

        Potion__c testPot0 = [SELECT Id FROM Potion__c WHERE Name = 'TestPot0' LIMIT 1];
        Potion__c testPot1 = [SELECT Id FROM Potion__c WHERE Name = 'TestPot1' LIMIT 1];
        Potion__c testPot2 = [SELECT Id FROM Potion__c WHERE Name = 'TestPot2' LIMIT 1];
        Potion__c testPot3 = [SELECT Id FROM Potion__c WHERE Name = 'TestPot3' LIMIT 1];
        Potion__c testPot4 = [SELECT Id FROM Potion__c WHERE Name = 'TestPot4' LIMIT 1];
        Potion__c testPot5 = [SELECT Id FROM Potion__c WHERE Name = 'TestPot5' LIMIT 1];


        for(Integer i = 0; i < 100; i++) {
            switch on Math.mod(i,6) {
                when 0{
                    testReviews.add(new Potion_Review__c(Review_Message__c = 'This Is A Test Review', Reviewer_Name__c = 'Reviewer', Review_Rating__c = 5, Potion_Type__c = testPot0.Id));
                } when 1 {
                    testReviews.add(new Potion_Review__c(Review_Message__c = 'This Is A Test Review', Reviewer_Name__c = 'Reviewer', Review_Rating__c = 5, Potion_Type__c = testPot1.Id));
                } when 2 {
                    testReviews.add(new Potion_Review__c(Review_Message__c = 'This Is A Test Review', Reviewer_Name__c = 'Reviewer', Review_Rating__c = 5, Potion_Type__c = testPot2.Id));
                } when 3 {
                    testReviews.add(new Potion_Review__c(Review_Message__c = 'This Is A Test Review', Reviewer_Name__c = 'Reviewer', Review_Rating__c = 5, Potion_Type__c = testPot3.Id));
                } when 4 {
                    testReviews.add(new Potion_Review__c(Review_Message__c = 'This Is A Test Review', Reviewer_Name__c = 'Reviewer', Review_Rating__c = 5, Potion_Type__c = testPot4.Id));
                } when else {
                    testReviews.add(new Potion_Review__c(Review_Message__c = 'This Is A Test Review', Reviewer_Name__c = 'Reviewer', Review_Rating__c = 5, Potion_Type__c = testPot5.Id));
                }
            }
        }
        insert testReviews;
    }

    // The function this is testing just grabs all potions in the org, since we added 107 potions into the org in setup, the size of the returned List should be 107
    @isTest public static void testGetPotions() {
        Test.startTest();
        System.assertEquals(107, DisplayReviewsController.getPotions().size());
        Test.stopTest();
    }
    // The function this is testing just grabs all reviews in the org, since we added 200 reviews into the org in setup, the size of the returned List should be 200
    @isTest static void testGetReviews() {
        Test.startTest();
        System.assertEquals(200, DisplayReviewsController.getReviews().size());
        Test.stopTest();
    }
    // The function this is testing takes in a potion's Id and returns the potion object, querying for the name and the Id of the given potion
    @isTest static void testGetPotion() {
        Test.startTest();
        Id potionId = [SELECT Id FROM Potion__c WHERE Name = 'Test Pot' LIMIT 1].Id;
        Potion__c testPot = DisplayReviewsController.getPotion(potionId);
        System.assertEquals('Test Pot', testPot.Name);
        System.assertEquals(potionId, testPot.Id);
        Test.stopTest();
    }
    // The function this is testing takes in a potion's Id and returns the name of that potion as a string
    @isTest static void testGetPotionName() {
        Test.startTest();
        Id potionId = [SELECT Id FROM Potion__c WHERE Name = 'Test Pot' LIMIT 1].Id;
        System.assertEquals('Test Pot', DisplayReviewsController.getPotionName(potionId));
        System.assertNotEquals('expected', DisplayReviewsController.getPotionName(potionId));
        Test.stopTest();
    }
    // The function this is testing takes in a potion's Id and returns a list of reviews that have that potion Id as their 'Potion_Type__c' Field
    @isTest static void testFilterByPotion() {
        Test.startTest();
        // We inserted 100 reviews using the potion with the name 'Test Pot', so the size of the returned list should be 100
        Id potionId = [SELECT Id FROM Potion__c WHERE Name = 'Test Pot' LIMIT 1].Id;
        System.assertEquals(100, DisplayReviewsController.filterByPotion(potionId).size());
        // Here, we made 6 different potions with the names 'TestPot'+n where n is 0-5, so we iterate from 0-5 being assigned to i and test how many of each of these were retrieved
        for(Integer i = 0; i < 6; i++) {
            potionId = [SELECT Id FROM Potion__c WHERE Name =: 'TestPot'+i LIMIT 1].Id;
            // we inserted 17 reviews with the potion named 'TestPot0', 'TestPot1', 'TestPot2', and 'TestPot3' and we inserted 16 reviews with the potion name 'TestPot4' and 'TestPot5'
            // So these are the numbers we should see for the size of the correlated return values
            switch on i {
                when  0{
                    System.assertEquals(17, DisplayReviewsController.filterByPotion(potionId).size());
                } when 1{
                    System.assertEquals(17, DisplayReviewsController.filterByPotion(potionId).size());
                } when 2 {
                    System.assertEquals(17, DisplayReviewsController.filterByPotion(potionId).size());
                } when 3 {
                    System.assertEquals(17, DisplayReviewsController.filterByPotion(potionId).size());
                } when 4 {
                    System.assertEquals(16, DisplayReviewsController.filterByPotion(potionId).size());
                } when else {
                    System.assertEquals(16, DisplayReviewsController.filterByPotion(potionId).size());
                }
            }
        }
        Test.stopTest();
    }
    // The function this is testing takes in a number (0-5) and returns all reviews with that rating
    @isTest static void testFilterByRating() {
        Test.startTest();
        // we inserted 17 reviews with rating 0 so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByRating(0).size());
        // we inserted 17 reviews with rating 1 so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByRating(1).size());
        // we inserted 17 reviews with rating 2 so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByRating(2).size());
        // we inserted 17 reviews with rating 3 so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByRating(3).size());
        // we inserted 16 reviews with rating 4 so that is what the size of the returned list should be
        System.assertEquals(16, DisplayReviewsController.filterByRating(4).size());
        // we inserted 16 reviews with rating 5 so that is what the size of the returned list should be
        System.assertEquals(116, DisplayReviewsController.filterByRating(5).size());
        Test.stopTest();
    }
    // The function this is testing takes in a String (reviewer's name) and returns all reviews with that reviewer name
    @isTest static void testFilterByReviewer() {
        Test.startTest();
        // we inserted 17 reviews with the reviewer name 'Reviewer0' so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByReviewer('Reviewer0').size());
        // we inserted 17 reviews with the reviewer name 'Reviewer1' so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByReviewer('Reviewer1').size());
        // we inserted 17 reviews with the reviewer name 'Reviewer2' so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByReviewer('Reviewer2').size());
        // we inserted 17 reviews with the reviewer name 'Reviewer3' so that is what the size of the returned list should be
        System.assertEquals(17, DisplayReviewsController.filterByReviewer('Reviewer3').size());
        // we inserted 16 reviews with the reviewer name 'Reviewer4' so that is what the size of the returned list should be
        System.assertEquals(16, DisplayReviewsController.filterByReviewer('Reviewer4').size());
        // we inserted 16 reviews with the reviewer name 'Reviewer5' so that is what the size of the returned list should be
        System.assertEquals(16, DisplayReviewsController.filterByReviewer('Reviewer5').size());
        // we inserted no reviews with the reviewer name 'Dog' so that is what the size of the returned list should be
        System.assertEquals(0, DisplayReviewsController.filterByReviewer('Dog').size());
        Test.stopTest();
    }
}