public class FAQController {    
    public String searchInput {get;set;}
    public List<FAQ__c> matchingQuestion{get;set;}
    public String errorMessage {get;set;}
    public List<FAQ__c> FAQList = new List<FAQ__c>();

    public void getQandA() {
        try {
            if (String.isEmpty(this.searchInput)) {
                FAQList = [SELECT Question__c, Answer__c FROM FAQ__c];
            }
            else {
                FAQList = [SELECT Question__c, Answer__c FROM FAQ__c WHERE Question__c LIKE :searchInput];
            }
        }
        catch (Exception e){
            this.errorMessage = 'Please enter a question in the text box before clicking the serach button.';
            this.matchingQuestion = new List<FAQ__c>();
        }        
    }
 
}