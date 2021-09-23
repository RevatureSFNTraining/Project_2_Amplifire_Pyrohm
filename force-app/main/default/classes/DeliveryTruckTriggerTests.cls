@isTest public class DeliveryTruckTriggerTests {
	@testSetup static void DeliveryTruckTriggerTestSetup()
    {
        //setup neccesary objects for relationships
        Account account = new Account(Name = 'TestAccount');
        Ingredient__c ingredient = new Ingredient__c(Name = 'TestIngredient', Ingredient_Price__c = 1.00, Type_of_Ingredient__c = 'Base');
        insert(account);
        insert(ingredient);
        
        Potion__c potion =  new Potion__c(Type_of_Potion__c = 'Potion of Healing', Base_Ingredient__c = ingredient.Id);
        Delivery_Truck__c truckWithOrders = new Delivery_Truck__c(Truck_Name__c = 'Test Truck with Orders');
        Delivery_Truck__c truckWithoutOrders = new Delivery_Truck__c(Truck_Name__c = 'Test Truck without Orders');
        insert(potion);
        insert(truckWithOrders);
        insert(truckWithoutOrders);
        
        Potion_Order__c potionOrder = new Potion_Order__c(Potion_Order_Name__c = 'Test Order',
                                                          Number_of_Potions__c = 1,
                                                          Potion_Type__c = potion.Id,
                                                          Account_Purchasing__c = account.Id,
                                                          Delivery_Truck_ID__c = truckWithOrders.Id);
        insert(potionOrder);
    }
    
    @isTest static void positiveTest()
    {
        Delivery_Truck__c truckWithoutOrders =  [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck without Orders'];
        
        system.assert(database.delete(truckWithoutOrders).isSuccess());
    }    
    
    @isTest static void negativeTest()
    {
        Delivery_Truck__c truckWithOrders =  [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck with Orders'];

        try
        {
           	//Attempt an delete for the negative case of the delete trigger
           	delete(truckWithOrders);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
    }
    
    @isTest static void singleActionTest()
    {
        Delivery_Truck__c truckWithoutOrders = [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck without Orders'];
        System.assert(Database.delete(truckWithoutOrders).isSuccess());   
    }
    
    @isTest static void bulkTest()
    {
        List<Delivery_Truck__c> trucks = new List<Delivery_Truck__c>();
        for(Integer i = 0; i < 200; i++)
        {
         	trucks.add(new Delivery_Truck__c(Truck_Name__c = 'Test Truck' + i));   
        }
        insert(trucks);
        
        try
        {
           	//Attempt an delete for the bulk case of the delete trigger
           	delete(trucks);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
    }
}