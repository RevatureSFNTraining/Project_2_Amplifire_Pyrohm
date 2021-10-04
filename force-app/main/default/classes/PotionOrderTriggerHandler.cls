public class PotionOrderTriggerHandler 
{

	public static void checkCapacity(List<Potion_Order__c> potionOrders)
    {
        for(Potion_Order__c po : potionOrders)
        {			
            //Use this if you can get it to work
            Integer num = Integer.valueOf([SELECT COUNT(Id) cnt FROM Potion_Order__c WHERE Delivery_Truck_ID__c = :po.Delivery_Truck_ID__c][0].get('cnt'));
            
			if(num > 4)
            {
                po.addError('ERROR: This truck is full. Please choose another.');
            }      
        }
    }
}