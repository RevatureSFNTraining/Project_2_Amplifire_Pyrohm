public class getPotionController {
	@AuraEnabled
    public static Potion__c getPotion(Id potionId) {
        return [SELECT Id, Name From Potion__c WHERE Id =: potionId LIMIT 1];
    }
}