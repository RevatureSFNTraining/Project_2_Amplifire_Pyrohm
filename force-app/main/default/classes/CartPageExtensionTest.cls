@isTest
public with sharing class CartPageExtensionTest {
    
    @isTest
    public static void testInsert(){
        Potion__c pot = new Potion__c(
            Name = 'Potion of Healing',
            Type_of_Potion__c = 'Healing',
            Base_Ingredient__c = 'a005f000000wr0ZAAQ',
            Secondary_Ingredient__c = 'a005f000000wr0eAAA'
        );
        insert pot;

        Pagereference pageRef = Page.CartPage;
        pageRef.getParameters().put('potId', pot.Id);
        Test.setCurrentPage(pageRef);

        Potion_Order__c potOrder = new Potion_Order__c();
        ApexPages.StandardController ssc = new ApexPages.StandardController(potOrder);

        CartPageExtension cpe = new CartPageExtension(ssc);
        potOrder.Number_of_Potions__c = 1;

        cpe.showPopup();

        List<Potion_Order__c> potOrders = [SELECT id from Potion_Order__c];
        System.assertEquals(1, potOrders.size());

        // cpe.closePopup();


        // System.assertEquals(Page.PotionsPage, ApexPages.currentPage());
    }
}