trigger FAQTrigger on FAQ__c (before insert, before update, before delete, after delete, after undelete, after update, after insert) 
{
    switch on trigger.OperationType
    {
        when BEFORE_INSERT
        {
            FAQTriggerHandler.checkExistingFAQs(trigger.new);
        }
        when BEFORE_UPDATE
        {
            FAQTriggerHandler.checkExistingFAQs(trigger.new);
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