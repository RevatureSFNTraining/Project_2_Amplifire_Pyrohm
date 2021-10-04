@isTest
public with sharing class CartPageExtensionTest {
    
    @isTest
    public static void testInsertPositive(){
        // Call testInsert for positive
        testInsert(true);
    }

    @isTest
    public static void testInsertNegative(){
        // Call testInsert for negative
        testInsert(false);
    }

    private static void testInsert(boolean isPositive){
        // Create potion and insert
        // The ingredient ids are from database but
        // the test doesn't care that it can't see them
        Potion__c pot = new Potion__c(
            Name = 'Potion of Healing',
            Type_of_Potion__c = 'Healing',
            Base_Ingredient__c = 'a005f000000wr0ZAAQ',
            Secondary_Ingredient__c = 'a005f000000wr0eAAA'
        );
        insert pot;

        // Assign url parameters to cartpage and navigate
        PageReference pageRef = Page.CartPage;
        if(isPositive){
            // only doing this for 100% coverage
            pageRef.getParameters().put('potId', pot.Id);
        }
        Test.setCurrentPage(pageRef);

        // Create required object for cartpage
        Potion_Order__c potOrder = new Potion_Order__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(potOrder);
        CartPageExtension cpe = new CartPageExtension(sc);

        if(isPositive){
            // only add required field if positive test
            potOrder.Number_of_Potions__c = 1;
        }

        // call method that inserts to db
        cpe.showPopup();

        List<Potion_Order__c> potOrders = [SELECT id from Potion_Order__c];

        if(isPositive) {
            // expect to find 1 order
            System.assertEquals(1, potOrders.size());

            // continue with ui experience and close popup
            // which should navigate to potionspage
            PageReference nePage = cpe.closePopup();
            Test.setCurrentPage(nePage);

            System.assertEquals(Page.PotionsPage.getUrl(), ApexPages.currentPage().getUrl());
        } else {
            // expect the insert failed
            System.assertEquals(0, potOrders.size());
        }
    }
}