public class FAQTriggerHandler {
    public static List<FAQ__c> checkExistingFAQs(List<FAQ__c> newFAQs) {
        Set<String> newFAQSet = new Set<String>();
        for(FAQ__c newFAQ : newFAQs) {
            if(newFAQ.Question__c != null && newFAQ.Answer__c != null ) {
                newFAQSet.add(newFAQ.Question__c);
            }
        }
        List<FAQ__c> existingFAQList = new List<FAQ__c>();
        for(FAQ__c existingFAQ: [SELECT Question__c, Answer__c FROM FAQ__c]) {
            existingFAQList.add(existingFAQ);
        }
        Integer i = 0;
        for(FAQ__c newFAQ: newFAQs) {
            if(newFAQ.Question__c == existingFAQList[i].Question__c) {
                newFAQ.addError('ERROR: This question already exists as an FAQ.');
            }
            i++;
        }
        return newFAQs;
    }
}