public class FAQTriggerHandler {
    public static List<FAQ__c> checkExistingFAQs(List<FAQ__c> newFAQs) {
        Map<String, String> newFAQMap = new Map<String, String>();

        //Adds new FAQ record to a new map of FAQ record
        for(FAQ__c newFAQ : newFAQs) {
            if(newFAQ.Question__c != null && newFAQ.Answer__c != null ) {
                newFAQMap.put(newFAQ.Question__c,newFAQ.Answer__c);
            }
        }
        //Creates list of already existing FAQ records
        List<FAQ__c> existingFAQList = new List<FAQ__c>();
        for(FAQ__c existingFAQ: [SELECT Question__c, Answer__c FROM FAQ__c]) {
            existingFAQList.add(existingFAQ);
        }
        //Checks each index in the list of existing FAQs to see if they have matching questions.
        for(FAQ__c newFAQ: newFAQs) {
            FAQ__c duplicateFAQ = new FAQ__c(Question__c=newFAQMap.get(newFAQ.Question__c));
            if(newFAQ.Question__c == duplicateFAQ.Question__c) {
                newFAQ.addError('ERROR: This question already exists as an FAQ.');
            }
        }
        return newFAQs;
    }
}