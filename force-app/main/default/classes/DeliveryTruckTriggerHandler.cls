public class DeliveryTruckTriggerHandler {
    
    
    public static void checkForOrders(List<Delivery_Truck__c> deliveryTrucks)
    {
        for(List<AggregateResult> count : [SELECT Delivery_Truck_ID__c, COUNT(Name) cnt FROM Potion_Order__c GROUP BY Delivery_Truck_ID__c HAVING COUNT(Name) > 0])
        {
            for(Delivery_Truck__c dt : deliveryTrucks)
            {
                System.debug(count[0].get('Delivery_Truck_ID__c'));
                System.debug(dt.Id);
                if(count[0].get('Delivery_Truck_ID__c') == dt.Id)
                {
                   dt.addError('Cannot delete this truck because orders are assigned to this truck.');
                }
            }   
        }  
    }
    
    
    
    
    /*
	public static void moveOrders(List<Delivery_Truck__c> deliveryTrucks)
    {
        List<Potion_Order__c> potionOrders;
        List<Delivery_Truck__c> newTrucks;
        List<Delivery_Truck__c> deleteTheseTrucks;
        
        for(Delivery_Truck__c dt : deliveryTrucks)
        {
            potionOrders.add([SELECT Name FROM Potion_Order__c WHERE Delivery_Truck_ID__r.Name = :dt.Name]);
            
            Delivery_Truck__c tempTruck = new Delivery_Truck__c();
            newTrucks.add(tempTruck);
            
            // from here would take all the potion orders, assign the Delivery_Truck_ID__r.Name to tempTruck, then delete dt
            for(Potion_Order__c po : potionOrders)
            {
                po.Delivery_Truck_ID__r = tempTruck;
            }
      
            //dt.addError(String.valueOf(potionOrders));
        }
        
        insert newTrucks;
        delete deleteTheseTrucks;
    }
	*/    
}