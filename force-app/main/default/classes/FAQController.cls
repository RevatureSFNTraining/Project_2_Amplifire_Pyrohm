public class FAQController {
    public List<FAQ__c> getQandA() {
        List<FAQ__c> FAQList = [SELECT Question__c, Answer__c FROM FAQ__c];
        return FAQList;
    }

    public static List<FAQ__c> executeSearch() {
        List<FAQ__c> FAQList = [SELECT Question__c, Answer__c FROM FAQ__c]; //WHERE Question__c LIKE searchText];
        return FAQList;
    } 
}