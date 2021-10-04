trigger DeliveryTruckTrigger on Delivery_Truck__c (before insert, before update, before delete, after delete, after undelete, after update, after insert) 
{
    switch on trigger.OperationType
    {
        when BEFORE_INSERT
        {
            
        }
        when BEFORE_UPDATE
        {
            
        }
        when BEFORE_DELETE
        {
           DeliveryTruckTriggerHandler.checkForOrders(trigger.old);
        }
        when AFTER_DELETE
        {
           
        }
        when AFTER_UNDELETE
        {
            
        }
        when AFTER_UPDATE
        {
            
        }
        when AFTER_INSERT
        {
            
        }
    }
}