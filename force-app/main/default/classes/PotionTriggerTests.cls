@isTest public class PotionTriggerTests {
/*
    @testSetup static void DeliveryTruckTriggerTestSetup()
    {
        //setup neccesary objects for relationships
        Ingredient__c ingredient = new Ingredient__c(Name = 'TestIngredient', Ingredient_Price__c = 1.00, Type_of_Ingredient__c = 'Base');
        insert(ingredient);
        
        Potion__c potionCanDelete =  new Potion__c(Potion_Name__c = 'TestCanDelete',
                                                   Type_of_Potion__c = 'Potion of Healing',
                                                   Base_Ingredient__c = ingredient.Id,
                                                   Allow_Deletion__c = True);
        
        Potion__c potionCannotDelete =  new Potion__c(Potion_Name__c = 'TestCannotDelete',
                                                      Type_of_Potion__c = 'Potion of Healing',
                                                      Base_Ingredient__c = ingredient.Id,
                                                      Allow_Deletion__c = False);
        insert(potionCanDelete);
        insert(potionCannotDelete);
    }
    
    @isTest static void positiveTest()
    {
        Potion__c potionCanDelete = [SELECT Id FROM Potion__c WHERE Potion_Name__c = 'TestCanDelete'];
        System.assert(database.delete(potionCanDelete).isSuccess());
    }
    
    @isTest static void negativeTest()
    {
        Potion__c potionCannotDelete = [SELECT Id FROM Potion__c WHERE Potion_Name__c = 'TestCannotDelete'];

        try
        {
            //Attempt an delete for the negative case of the delete trigger
            delete(potionCannotDelete);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
    }
    
    @isTest static void singleActionTest()
    {
        Potion__c potionCanDelete = [SELECT Id FROM Potion__c WHERE Potion_Name__c = 'TestCanDelete'];
        System.assert(database.delete(potionCanDelete).isSuccess());
    }
    
    @isTest static void bulkTest()
    {
        Ingredient__c ingredient = [SELECT Id FROM Ingredient__c WHERE Name = 'TestIngredient'];
        List<Potion__c> potions = new List<Potion__c>();
        for(Integer i = 0; i < 777; i++)
        {
            potions.add(new Potion__c(Potion_Name__c = 'Test' + 1, Type_of_Potion__c = 'Potion of Healing', Base_Ingredient__c = ingredient.Id, Allow_Deletion__c = True));
        }
        
        insert(potions);
        
        try
        {
            //Attempt an delete for the bulk case of the delete trigger
            delete(potions);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
    }
  */  
}