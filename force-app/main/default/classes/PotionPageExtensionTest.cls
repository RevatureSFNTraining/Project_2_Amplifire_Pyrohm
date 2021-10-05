@isTest
public with sharing class PotionPageExtensionTest {

    @isTest
    public static void linkNavigationTest(){
        navTest(true);
    }

    @isTest
    public static void onlyForFullCoverage(){
        navTest(false);
    }

    private static void navTest(boolean isAssigned){
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
        PageReference pageRef = Page.PotionsPage;
        Test.setCurrentPage(pageRef);

        // Set up potions page
        List<Potion__c> potList = new List<Potion__c>();
        potList.add(pot);
        ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(potList);
        PotionExtension ppe = new PotionExtension(ssc);

        
        if (isAssigned) {
            ppe.potId = pot.Id;
        }

        // Call logic that navigates to cart page
        PageReference newPage = ppe.setId();

        if (isAssigned) {
            // Assert url parameter equals the assigned potion id
            System.assertEquals(pot.Id, newPage.getParameters().get('potId'));
        } else {
            // Assert url parameter equals default potion id
            System.assertEquals('a015f000003jCdX', newPage.getParameters().get('potId'));
        }
    }
}