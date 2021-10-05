public class testknowledgecontroller {
	@AuraEnabled
    public static List<Knowledge__kav> getPublishedKnowledge() {
        return [SELECT Title, Question__c, Answer__c, ValidationStatus,PublishStatus FROM Knowledge__kav WHERE ValidationStatus = 'Validated' AND PublishStatus = 'Online'];
    }
    
    @AuraEnabled
    public static void insertNewQuestion(String newTitle, String Question) {
        Knowledge__kav Q = new Knowledge__kav(Title=newTitle,URLName=newTitle, Question__c=Question);
        insert Q;
    }
}