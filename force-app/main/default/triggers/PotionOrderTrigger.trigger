trigger PotionOrderTrigger on Potion_Order__c (before insert, before update, before delete, after delete, after undelete, after update, after insert) 
{
    switch on trigger.OperationType
    {
        when BEFORE_INSERT
        {
            PotionOrderTriggerHandler.checkCapacity(trigger.new);
        }
        when BEFORE_UPDATE
        {
            PotionOrderTriggerHandler.checkCapacity(trigger.new);
        }
        when BEFORE_DELETE
        {
            
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