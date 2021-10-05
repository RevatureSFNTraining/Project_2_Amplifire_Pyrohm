// Test class for the testknowledgecontroller apex class
@isTest
public class testknowledgecontrollertest {
    // setup the data for the tests to work with
	@TestSetup
    static void makeData() {
        // insert knowledge records that are validated
        List<Knowledge__kav> testKnowledge = new List<Knowledge__kav>();
        for(Integer i = 0; i < 50; i++) {
            testKnowledge.add(new Knowledge__kav(Title='title'+i, URLName='title'+i, Question__c='A question'+i, ValidationStatus = 'Validated'));
        }
        insert testKnowledge;
        
        // publishes the knowledge articles
        testKnowledge = [SELECT KnowledgeArticleId FROM Knowledge__kav];
        for(Knowledge__kav k: testKnowledge) {
            KbManagement.PublishingService.publishArticle(k.KnowledgeArticleId, true);
        }
    }
    // tests the getPublishedKnowledge method
    @isTest static void testGetPublishedKnowledge() {
        Test.startTest();
        // we inserted 50 validated, published articles so it should be 50
        System.assertEquals(50, testknowledgecontroller.getPublishedKnowledge().size());
        // adds in 10 more knowledge articles, but they aren't published or validated
        List<Knowledge__kav> testKnowledge = new List<Knowledge__kav>();
        for(Integer i = 0; i < 10; i++) {
            testKnowledge.add(new Knowledge__kav(Title='t'+i, URLName='t'+i, Question__c='A question'+i));
        }
        insert testKnowledge;
        // makes sure that it isn't now 60
        System.assertNotEquals(60, testknowledgecontroller.getPublishedKnowledge().size());
        Test.stopTest();
    }
    
    // tests the searchButton method from the apex controller
    @isTest static void testSearchButton() {
        Test.startTest();
        // all of the records we inserted contained 'A question' in their name, so it should return all 50 records
        List<Knowledge__kav> testKnowledge = testknowledgecontroller.searchButton('A question');
        System.assertEquals(50, testKnowledge.size());
        // none of the records contain 'dog', so it should only be 1 record and that record should have the question = 'dog'
        // and the answer = 'We do not have an answer for this question yet.'
        testKnowledge = testknowledgecontroller.searchButton('dog');
        System.assertEquals(1, testKnowledge.size());
        System.assertEquals('dog', testKnowledge[0].Question__c);
        System.assertEquals('We do not have an answer for this question yet.', testKnowledge[0].Answer__c);
        Test.stopTest();
    }
}