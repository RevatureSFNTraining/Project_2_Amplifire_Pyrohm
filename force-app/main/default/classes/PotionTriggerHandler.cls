public class PotionTriggerHandler {
    public static void checkDelete(List<Potion__c> potions)
    {
        for(Potion__c potion : potions)
        {
            //if(!potion.Allow_Deletion__c)
            //{
            //    potion.addError('This potion is not allowed to be deleted');
            //}
        }
    }
}