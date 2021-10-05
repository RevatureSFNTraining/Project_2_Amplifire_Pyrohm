public class GetPotionIdsController {
	@AuraEnabled
    public static List<Potion__c> getPotions() {
        return [SELECT Name, Id FROM Potion__c];
    }
}