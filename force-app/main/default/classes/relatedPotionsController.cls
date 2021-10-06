public with sharing class relatedPotionsController {
	@AuraEnabled
    public static List<Potion__c> getRelatedPotions(String inName){
        List<Potion__c> relatedPotions = [SELECT Id, Name, Base_Ingredient__c FROM Potion__c WHERE Base_Ingredient__c =: inName OR Secondary_Ingredient__c =: inName ];            
        return relatedPotions;           
    }  
}