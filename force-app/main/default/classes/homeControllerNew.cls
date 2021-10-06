public with sharing class homeControllerNew {

    @AuraEnabled
    public static List<Potion_Review__c> getTopSeller() {
        return [SELECT Review_Rating__c, Reviewer_Name__c, Review_Message__c, Potion_Type__r.Name
        FROM Potion_Review__C 
        WHERE Review_Rating__c >= 4 ORDER BY CreatedDate LIMIT 3];
    }
    
}