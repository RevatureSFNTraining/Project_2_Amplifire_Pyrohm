public with sharing class PotionController {
    @AuraEnabled
    public static List<Potion__c> getPotion() {
        return [SELECT Id, Name, Type_of_Potion__c, Base_Ingredient__r.Name FROM Potion__c];
    }
    
    @AuraEnabled
    public static Potion__c getPotionInstance(String i) {
        system.debug(i);
        return [SELECT Id, Name, Type_of_Potion__c, Base_Ingredient__r.Name FROM Potion__c WHERE Id = :i];
    }
    
}