// Controller for Reviews Components
public without sharing class DisplayReviewsController {
    // Grabs all of the reviews from the org
	@AuraEnabled
    public static List<Potion_Review__c> getReviews() {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c FROM Potion_Review__c];
    }
    
    // filters by the given potion Id and grabs only reviews with that potion Id as its Potion Type
    @AuraEnabled
    public static List<Potion_Review__c> filterByPotion(Id filter) {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c 
                FROM Potion_Review__c WHERE Potion_Type__c =: filter];
    }
    
    // filters by the given string reviewer name and grabs only reveiws with that as its reviewer name
    @AuraEnabled
    public static List<Potion_Review__c> filterByReviewer(String filter) {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c 
                FROM Potion_Review__c WHERE Reviewer_Name__c =: filter];
    }
    
    // filters by the given rating integer and grabs only reviews with that rating 
    @AuraEnabled
    public static List<Potion_Review__c> filterByRating(Integer filter) {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c 
                FROM Potion_Review__c WHERE Review_Rating__c =: filter];
    }
    
    // for displaying the name of a reviews potion type, takes in the id and returns the potions name as a string
    @AuraEnabled
    public static String getPotionName(Id potionId) {
        return [SELECT Id, Name FROM Potion__c WHERE Id=: potionId LIMIT 1].Name;
    }
    
    // gets a list of all the potions in the org
    @AuraEnabled
    public static List<Potion__c> getPotions() {
        return [SELECT Name, Id FROM Potion__c];
    }
    
    // gets a single potion record with the given Id
    @AuraEnabled
    public static Potion__c getPotion(Id potionId) {
        return [SELECT Id, Name From Potion__c WHERE Id =: potionId LIMIT 1];
    }
}