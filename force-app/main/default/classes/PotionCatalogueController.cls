public class PotionCatalogueController {
    @AuraEnabled
    public static List<Potion__c> fetchPotionList(String filter){
        
        if (filter != null) {
            if (filter == 'See All') {
                return [SELECT Id, Name, Total_Price__c, Type_of_Potion__c, Base_Ingredient__r.Name,CreatedDate, Secondary_Ingredient__r.Name FROM Potion__c];
            }    
            return [SELECT Id, Name, Total_Price__c, Type_of_Potion__c, Base_Ingredient__r.Name, CreatedDate, Secondary_Ingredient__r.Name FROM Potion__c WHERE Type_of_Potion__c = : filter ];
        } 
        
     return  [SELECT Id, Name, Total_Price__c, Type_of_Potion__c, Base_Ingredient__r.Name,CreatedDate, Secondary_Ingredient__r.Name FROM Potion__c]; 
        
    }
    
    @AuraEnabled
    public static Potion_Order__c saveOrder(Potion_Order__c order) {
        upsert order;
        return order;
    }
    
    @AuraEnabled
    
    public static List<String> getOptions(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Potion__c.Type_of_Potion__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
   
    /*
    // Grabbing potion instance
    @AuraEnabled
    public static Potion__c getPotionInstance(String i) {
        // returing object
        return [SELECT Id, Name, Type_of_Potion__c, Base_Ingredient__r.Name, Secondary_Ingredient__r.Name FROM Potion__c WHERE Id = :i];
    }

*/
}