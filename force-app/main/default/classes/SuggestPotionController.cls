public class SuggestPotionController {
	@AuraEnabled
    public static Potion__c addPotion(Potion__c newPotion) {
        insert newPotion;
        return newPotion;
    }
}