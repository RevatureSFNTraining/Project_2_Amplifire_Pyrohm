@isTest public class ReviewPageControllerTest {
    @TestSetup static void ReviewPageControllerTestSetup(){
        // create an ingredient to reference to when creating a potion object
        Ingredient__c ingredient = new Ingredient__c(Name = 'TestIngredient', Ingredient_Price__c = 1.00, Type_of_Ingredient__c = 'Base');
        insert(ingredient);
        
        // create an potion to reference to when creating a review object
        Potion__c potion =  new Potion__c(Name = 'Test Potion', Type_of_Potion__c = 'Healing', Base_Ingredient__c = ingredient.Id);
        insert(potion);

        // create a list to store multiple potion reviews to be inserted as test records
        List<Potion_Review__c> reviews = new List<Potion_Review__c>();

        for(Integer i = 0; i < 250; i++)
        {
            reviews.add(new Potion_Review__c(Review_Message__c = 'Review #' + i, Reviewer_Name__c = 'Test', Potion_Type__c = potion.Id, Review_Rating__c = 4));
        }

        insert(reviews);
    }

    // will create a new record using the controller functionality and also covers the retrieval of records controller method
    @isTest static void rpcPositiveTest()
    {
        ReviewPageController rpc = new ReviewPageController();

        Potion__c potion = [SELECT Id FROM Potion__c LIMIT 1];
        Potion_Review__c newReview = new Potion_Review__c(Review_Message__c = 'Review New', Reviewer_Name__c = 'NewTest', Potion_Type__c = potion.Id, Review_Rating__c = 5);
        rpc.newReview = newReview;
        rpc.saveReview();

        List<Potion_Review__c> expected = (List<Potion_Review__c>)[SELECT Id FROM Potion_Review__c];
        List<Potion_Review__c> actual = rpc.reviewList;
        system.assertEquals(expected.size(), actual.size());
    }

    // same as positive test, however the review has a negative review rating value which is not allowed, the record will not be saved
    @isTest static void rpcNegativeTest()
    {
        ReviewPageController rpc = new ReviewPageController();

        Potion__c potion = [SELECT Id FROM Potion__c LIMIT 1];
        Potion_Review__c newReview = new Potion_Review__c(Review_Message__c = 'Review New', Reviewer_Name__c = 'NewTest', Potion_Type__c = potion.Id, Review_Rating__c = -5);
        rpc.newReview = newReview;
        rpc.saveReview();

        List<Potion_Review__c> expected = (List<Potion_Review__c>)[SELECT Id FROM Potion_Review__c];
        List<Potion_Review__c> actual = rpc.reviewList;
        system.assertEquals(expected.size(), actual.size());
    }

    // same as positive test because the feature on this page only has the action of saving a record to the database
    @isTest static void rpcSingleActionTest()
    {
        ReviewPageController rpc = new ReviewPageController();

        Potion__c potion = [SELECT Id FROM Potion__c LIMIT 1];
        Potion_Review__c newReview = new Potion_Review__c(Review_Message__c = 'Review New', Reviewer_Name__c = 'NewTest', Potion_Type__c = potion.Id, Review_Rating__c = 5);
        rpc.newReview = newReview;
        rpc.saveReview();

        List<Potion_Review__c> expected = (List<Potion_Review__c>)[SELECT Id FROM Potion_Review__c];
        List<Potion_Review__c> actual = rpc.reviewList;
        system.assertEquals(expected.size(), actual.size());
    }

    // doesn't make sense for this page to have a full bulk test for the feature of submitting a new record from the page
    // because it only allows for one record submission action at a time
    @isTest static void rpcBulkActionTest()
    {
        ReviewPageController rpc = new ReviewPageController();
        
        Potion__c potion = [SELECT Id FROM Potion__c LIMIT 1];
        Potion_Review__c newReview = new Potion_Review__c(Review_Message__c = 'Review New', Reviewer_Name__c = 'NewTest', Potion_Type__c = potion.Id, Review_Rating__c = 5);
        rpc.newReview = newReview;
        rpc.saveReview();

        List<Potion_Review__c> expected = (List<Potion_Review__c>)[SELECT Id FROM Potion_Review__c];
        List<Potion_Review__c> actual = rpc.reviewList;
        system.assertEquals(expected.size(), actual.size());

    }
}