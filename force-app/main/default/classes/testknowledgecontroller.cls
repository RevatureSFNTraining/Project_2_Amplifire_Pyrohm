public class testknowledgecontroller {
    // grabs all of the knowledge records in the database that are validated and published
	@AuraEnabled
    public static List<Knowledge__kav> getPublishedKnowledge() {
        return [SELECT Title, Question__c, Answer__c, ValidationStatus,PublishStatus FROM Knowledge__kav WHERE ValidationStatus = 'Validated' AND PublishStatus = 'Online'];
    }
    
    // checks to see if the question search terms exist in validated and published records, if not, creates a new knowledge record draft for it
    @AuraEnabled
    public static List<Knowledge__kav> searchButton(String Question) {
        List<Knowledge__kav> results = [SELECT Title, Question__c, Answer__c, ValidationStatus, PublishStatus FROM Knowledge__kav WHERE ValidationStatus = 'Validated' AND PublishStatus = 'Online'];
        List<Knowledge__kav> filteredResults = new List<Knowledge__kav>();
        for(Knowledge__kav aQuestion: results) {
            if(aQuestion.Question__c.contains(Question)) {
                filteredResults.add(aQuestion);
            }
        }
        
        if(filteredResults.size() != 0) {
            return filteredResults;
        } else {
            Integer randId = Integer.valueof((Math.random() * 1000000));
            Knowledge__kav newQ = new Knowledge__kav(Title='NewQuestion'+randId, URLName='NewQuestion'+randId, Question__c=Question, Answer__c='We do not have an answer for this question yet.');
            insert newQ;
            filteredResults.add(newQ);
            return filteredResults;
        }
    }
}