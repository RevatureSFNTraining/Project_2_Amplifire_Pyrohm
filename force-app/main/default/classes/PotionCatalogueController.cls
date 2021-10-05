public class PotionCatalogueController {
    @AuraEnabled
    //Getting all the Potions and returning a List of them
    public static List<Potion__c> fetchPotionList(){
        return  [SELECT Id, Name, Total_Price__c, Type_of_Potion__c, Potion_URL__c, Base_Ingredient__r.Ingredient_Price__c, Base_Ingredient__r.Name,CreatedDate, Secondary_Ingredient__r.Name, Secondary_Ingredient__r.Ingredient_Price__c FROM Potion__c];        
    }
    
    
    @AuraEnabled
    // passing an order as parameter -> insert and update, then return this record
    public static Potion_Order__c saveOrder(Potion_Order__c order) {
        upsert order;
        return order;
    }
    
    @AuraEnabled
    //Getting all of the Picklist values of Potion
    public static List<String> getOptions(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Potion__c.Type_of_Potion__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
}