@isTest 
public class FAQTriggerHandlerTest {
    @isTest
    public static void testNegativeFAQadd() {
        List<FAQ__c> FAQList = new List<FAQ__c>();
        FAQ__c testFAQ = new FAQ__c(Question__c = 'What is a potion?', Answer__c = 'Yes.');
        FAQList.add(testFAQ);
        insert FAQList;

        PageReference pageRef = new PageReference('https://krakenpotions-developer-edition.na163.force.com/FAQPage');
        Test.setCurrentPage(pageRef);
    }
}