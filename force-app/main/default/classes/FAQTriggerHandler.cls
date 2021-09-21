public class FAQTriggerHandler {
    public static List<FAQ__c> checkExistingFAQs(List<FAQ__c> newFAQs) {
        Set<String> newFAQSet = new Set<String>();

        //Adds new FAQ record to a new set of FAQ record
        for(FAQ__c newFAQ : newFAQs) {
            if(newFAQ.Question__c != null && newFAQ.Answer__c != null ) {
                newFAQSet.add(newFAQ.Question__c);
            }
        }
        //Creates list of already existing FAQ records
        List<FAQ__c> existingFAQList = new List<FAQ__c>();
        for(FAQ__c existingFAQ: [SELECT Question__c, Answer__c FROM FAQ__c]) {
            existingFAQList.add(existingFAQ);
        }
        //Checks each index in the list of existing FAQs to see if they 
        for(FAQ__c newFAQ: newFAQs) {
            for(Integer i = 0;i < newFAQs.size();i++) {
                if(newFAQ.Question__c == existingFAQList[i].Question__c) {
                newFAQ.addError('ERROR: This question already exists as an FAQ.');
                }
            }
        }
        return newFAQs;
    }
}