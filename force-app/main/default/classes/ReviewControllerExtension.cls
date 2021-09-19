public class ReviewControllerExtension {
    
    public ReviewControllerExtension(ReviewPageController reCon){
         prList= new list<Potion_Review__C>
             ([SELECT Review_Message__c 
               FROM Potion_Review__C 
               WHERE Review_Rating__c>=4 
               ORDER BY CreatedDate LIMIT 5]);  
    }
    
    public List<Potion_Review__c> prList=
        new list<Potion_Review__c>();
    
    public list<Potion_Review__c> getReCon(){
        prList= new list<Potion_Review__C>
            ([SELECT Review_Rating__c, 
              Review_Message__c, 
              Potion_Type__r.Name 
              FROM Potion_Review__C WHERE 
              Review_Rating__c>=4 
              ORDER BY CreatedDate LIMIT 5]);      
    	return prList;
    }
    
    public Potion__C getLuDr(){
        List<Potion__C> lucid = new list<Potion__C>
            ([SELECT name 
              FROM Potion__c 
              WHERE Name='Potion of Lucid Dreams']);
      	return lucid[0];
        
    }
    
}