public class RevCon {
    @AuraEnabled
    public static list<Potion_Review__c> fetchReviews(){
        
        List<Potion_Review__c> ret = ([SELECT Review_Rating__c, Reviewer_Name__c, Review_Message__c, Potion_Type__r.Name 
                                                FROM Potion_Review__C 
                                                WHERE Review_Rating__c>=4 ORDER BY CreatedDate LIMIT 6]);
        
        
        return ret;
    }
}