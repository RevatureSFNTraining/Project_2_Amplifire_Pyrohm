public class ReviewControllerExtension {
    public List<Potion_Review__c> prList=new list<Potion_Review__c>();
    
    
    //constructor:
    public ReviewControllerExtension(ReviewPageController recon){
        prList= new list<Potion_Review__C>([SELECT Review_Message__c FROM Potion_Review__C WHERE Review_Rating__c>=4 ORDER BY CreatedDate LIMIT 5]);      
    }
    
}

//[SELECT Review_Message__c FROM Potion_Review__C WHERE Review_Rating__c>=4 LIMIT 5];