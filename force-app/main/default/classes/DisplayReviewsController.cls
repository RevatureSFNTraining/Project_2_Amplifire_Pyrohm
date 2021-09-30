public class DisplayReviewsController {
	@AuraEnabled
    public static List<Potion_Review__c> getReviews() {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c FROM Potion_Review__c];
    }
    
    @AuraEnabled
    public static List<Potion_Review__c> filterByPotion(Id filter) {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c 
                FROM Potion_Review__c WHERE Potion_Type__c =: filter];
    }
    
    @AuraEnabled
    public static List<Potion_Review__c> filterByReviewer(String filter) {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c 
                FROM Potion_Review__c WHERE Reviewer_Name__c =: filter];
    }
    
    @AuraEnabled
    public static List<Potion_Review__c> filterByRating(Integer filter) {
        return [SELECT Id, Review_Message__c, Reviewer_Name__c, Review_Rating__c, Potion_Type__c 
                FROM Potion_Review__c WHERE Review_Rating__c =: filter];
    }
}