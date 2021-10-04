@isTest public class PotionOrderTriggerTests 
{
    @testSetup static void PotionOrderTriggerTestSetup()
    {
        //setup neccesary objects for relationships
        Account account = new Account(Name = 'TestAccount');
        Ingredient__c ingredient = new Ingredient__c(Name = 'TestIngredient', Ingredient_Price__c = 1.00, Type_of_Ingredient__c = 'Base');
        insert(account);
        insert(ingredient);
        
        Potion__c potion =  new Potion__c(Type_of_Potion__c = 'Potion of Healing', Base_Ingredient__c = ingredient.Id);
        Delivery_Truck__c truck1 = new Delivery_Truck__c(Truck_Name__c = 'Test Truck 1');
        Delivery_Truck__c truck2 = new Delivery_Truck__c(Truck_Name__c = 'Test Truck 2');
        insert(potion);
        insert(truck1);
        insert(truck2);
    }
    
    @isTest static void positiveTest_Insert_and_Update()
    {
        //Process for Insert Trigger Check
        //get neccesary objects from queries
        Account account = [SELECT Id FROM Account WHERE Name = 'TestAccount'];
        Ingredient__c ingredient = [SELECT Id FROM Ingredient__c WHERE Name = 'TestIngredient'];
        Potion__c potion =  [SELECT Id FROM Potion__c WHERE Type_of_Potion__c = 'Potion of Healing'];
        Delivery_Truck__c truck = [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck 1'];
        
        //insert to activate trigger
        Potion_Order__c potionOrder = new Potion_Order__c(Potion_Order_Name__c = 'Test Order',
                                                          Number_of_Potions__c = 1,
                                                          Potion_Type__c = potion.Id,
                                                          Account_Purchasing__c = account.Id,
                                                          Delivery_Truck_ID__c = truck.Id);
        
        //check to ensure that the order was inserted properly
        system.assert(Database.insert(potionOrder).isSuccess());

        //Process for Update Trigger Check
        //get neccesary objects from queries
        Delivery_Truck__c truck2 = [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck 2'];
        potionOrder.Delivery_Truck_ID__c = truck2.Id;
        
        //check to ensure that the order was updated properly
        system.assert(Database.update(potionOrder).isSuccess());
	}
    
	@isTest static void negativeTest_Insert_and_Update()
    {
        //setup neccesary objects for relationships
        Account account = [SELECT Id FROM Account WHERE Name = 'TestAccount'];
        Ingredient__c ingredient = [SELECT Id FROM Ingredient__c WHERE Name = 'TestIngredient'];
        Potion__c potion =  [SELECT Id FROM Potion__c WHERE Type_of_Potion__c = 'Potion of Healing'];
        Delivery_Truck__c truck1 = [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck 1'];

        
        //setup list to be inserted into database
        List<Potion_Order__c> orders = new List<Potion_Order__c>();
        
        //fill up the list with records to be added
        for(Integer i = 0; i < 5; i++)
        {
            orders.add(new Potion_Order__c(Potion_Order_Name__c = 'Test Order ' + i,
                						   Number_of_Potions__c = i,
                                           Potion_Type__c = potion.Id,
                                           Account_Purchasing__c = account.Id,
                                           Delivery_Truck_ID__c = truck1.Id));
        }
        
        //Trigger doesn't catch the over truck order limit if all the orders are together in a list regardless of size.
        //However, if another order is added alone after the list and hits the limit, the trigger will activate completely
        insert(orders);
        Potion_Order__c orderToAdd = new Potion_Order__c(Potion_Order_Name__c = 'Test Order',
                                                         Number_of_Potions__c = 11,
                                                         Potion_Type__c = potion.Id,
                                                         Account_Purchasing__c = account.Id,
                                                         Delivery_Truck_ID__c = truck1.Id);
         
        try
        {
           	//Attempt an insert for the negative case of the insert trigger
           	insert(orderToAdd);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
        
        Delivery_Truck__c truck2 = [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck 2'];
        Potion_Order__c orderToUpdate = new Potion_Order__c(Potion_Order_Name__c = 'Test Order',
                                                         Number_of_Potions__c = 11,
                                                         Potion_Type__c = potion.Id,
                                                         Account_Purchasing__c = account.Id,
                                                         Delivery_Truck_ID__c = truck2.Id);
        insert(orderToUpdate);
        try
        {
           	//Attempt an update for the negative case of the update trigger
           	orderToUpdate.Delivery_Truck_ID__c = truck1.Id;
            update(orderToUpdate);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
    }
    
    @isTest static void singleActionTest()
    {
        //Process for Insert Trigger Check
        //get neccesary objects from queries
        Account account = [SELECT Id FROM Account WHERE Name = 'TestAccount'];
        Ingredient__c ingredient = [SELECT Id FROM Ingredient__c WHERE Name = 'TestIngredient'];
        Potion__c potion =  [SELECT Id FROM Potion__c WHERE Type_of_Potion__c = 'Potion of Healing'];
        Delivery_Truck__c truck = [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck 1'];
        
        //insert to activate trigger
        Potion_Order__c potionOrder = new Potion_Order__c(Potion_Order_Name__c = 'Test Order',
                                                          Number_of_Potions__c = 1,
                                                          Potion_Type__c = potion.Id,
                                                          Account_Purchasing__c = account.Id,
                                                          Delivery_Truck_ID__c = truck.Id);
        
        //check to ensure that the order was inserted properly
        system.assert(Database.insert(potionOrder).isSuccess());

        //Process for Update Trigger Check
        //get neccesary objects from queries
        Delivery_Truck__c truck2 = [SELECT Id FROM Delivery_Truck__c WHERE Truck_Name__c = 'Test Truck 2'];
        potionOrder.Delivery_Truck_ID__c = truck2.Id;
        
        //check to ensure that the order was updated properly
        system.assert(Database.update(potionOrder).isSuccess());
    }
    
    @isTest static void bulkTest()
    {
        Account account = [SELECT Id FROM Account WHERE Name = 'TestAccount'];
        Ingredient__c ingredient = [SELECT Id FROM Ingredient__c WHERE Name = 'TestIngredient'];
        Potion__c potion =  [SELECT Id FROM Potion__c WHERE Type_of_Potion__c = 'Potion of Healing'];
        
        List<Delivery_Truck__c> trucks1 = new List<Delivery_Truck__c>();
        List<Delivery_Truck__c> trucks2 = new List<Delivery_Truck__c>();
        List<Potion_Order__c> orders = new List<Potion_Order__c>();
        
        for(Integer i = 0; i < 777; i++)
        {
            trucks1.add(new Delivery_Truck__c(Truck_Name__c = 'Test Truck1' + i));
            trucks2.add(new Delivery_Truck__c(Truck_Name__c = 'Test Truck2' + i));
            orders.add(new Potion_Order__c(Potion_Order_Name__c = 'Test Order' + i,
                                                          Number_of_Potions__c = 1,
                                                          Potion_Type__c = potion.Id,
                                                          Account_Purchasing__c = account.Id,
                                                          Delivery_Truck_ID__c = trucks1[i].Id));
        }
        
        try
        {
           	//Attempt an insert for the bulk case of the insert trigger
           	insert(trucks1);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }

        for(Integer i = 0; i < 777; i++)
        {
            orders[i].Delivery_Truck_Id__c = trucks2[i].Id;
        }
        
        try
        {
           	//Attempt an update for the bulk case of the update trigger
           	update(orders);
        } 
        catch(System.DmlException e)
        {
            System.debug('The following exception has occured: ' + e.getMessage());
        }
        
    }
}