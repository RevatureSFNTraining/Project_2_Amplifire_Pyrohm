public class IngCont {
	    @AuraEnabled
    public static List <Ingredient__c> grabIng(String search, String filter) {
        
        List<Ingredient__c> ret;
        
        switch on filter {
            when 'T' {
                String searchKey = search + '%';
                ret = [SELECT id, Name, Ingredient_Price__c, Type_of_Ingredient__c, Available_Potion__c FROM Ingredient__c WHERE Type_of_Ingredient__c LIKE: searchKey];
            }when 'PU' {
                Decimal price = decimal.valueOf(search);
                ret = [SELECT id, Name, Ingredient_Price__c, Type_of_Ingredient__c, Available_Potion__c FROM Ingredient__c WHERE Ingredient_Price__c <: price];
            }when 'PO' {
                Decimal price = decimal.valueOf(search);
                ret = [SELECT id, Name, Ingredient_Price__c, Type_of_Ingredient__c, Available_Potion__c FROM Ingredient__c WHERE Ingredient_Price__c >: price];
            }when'N' {
                ret = [SELECT id, Name, Ingredient_Price__c, Type_of_Ingredient__c, Available_Potion__c FROM Ingredient__c];
            }when else {
                ret = [SELECT id, Name, Ingredient_Price__c, Type_of_Ingredient__c, Available_Potion__c FROM Ingredient__c];
            }
        }
        
        return ret;
    }
    
    @AuraEnabled 
    public static Potion__c savePotion (Id i1, Id i2, String potName, String potType) {
        System.debug(i1 + ' ' + i2 + ' ' + potName + ' ' + potType);
        Potion__c p = new Potion__c();
        p.Name= potName;
        p.Type_of_Potion__c = potType;
        p.Base_Ingredient__c = i1;
        //if(i2 != ''){
        p.Secondary_Ingredient__c = i2;
        //}
        upsert p; 
        return p; 
    }
}