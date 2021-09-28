public with sharing class PotionController {
    @AuraEnabled
    public static List<Potion__c> getPotion() {
        return [SELECT Id, Name, Type_of_Potion__c, Base_Ingredient__c FROM Potion__c];
    }
}