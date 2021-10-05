@isTest 
public class FAQPageTest {
    @isTest
    public static void testNegativeFAQadd() {
        List<FAQ__c> FAQList = new List<FAQ__c>();
        FAQ__c testFAQ = new FAQ__c(Question__c = 'Are your potions poisonous?', Answer__c = 'Only the Potion of Poison is poisonous.');
        FAQList.add(testFAQ);
        insert FAQList;
        FAQ__c testFAQ2 = new FAQ__c(Question__c = 'Are your potions poisonous?');
        test.startTest();
        try {
            database.insert(testFAQ2);
        }
        catch(DmlException e) {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
        test.stopTest();        
    }
}