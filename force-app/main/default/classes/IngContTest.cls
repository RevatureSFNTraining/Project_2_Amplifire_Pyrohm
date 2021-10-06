@isTest
public with sharing class IngContTest {
    
    
    @isTest
    public static void ingBulkTests(){
        Test.startTest();
            
        Ingredient__c i1 = new Ingredient__c(Name = 'i1', Ingredient_Price__c = 1, Type_of_Ingredient__c = 'base');
        Ingredient__c i2 = new Ingredient__c(Name = 'i2', Ingredient_Price__c = 3, Type_of_Ingredient__c = 'base');
        Ingredient__c i3 = new Ingredient__c(Name = 'i3', Ingredient_Price__c = 4, Type_of_Ingredient__c = 'base');
        Ingredient__c i4 = new Ingredient__c(Name = 'i4', Ingredient_Price__c = 5, Type_of_Ingredient__c = 'base');
        Ingredient__c i5 = new Ingredient__c(Name = 'i5', Ingredient_Price__c = 6, Type_of_Ingredient__c = 'secondary');
        Ingredient__c i6 = new Ingredient__c(Name = 'i6', Ingredient_Price__c = 7, Type_of_Ingredient__c = 'base');
        Ingredient__c i7 = new Ingredient__c(Name = 'i7', Ingredient_Price__c = 8, Type_of_Ingredient__c = 'base');
        Ingredient__c i8 = new Ingredient__c(Name = 'i8', Ingredient_Price__c = 9, Type_of_Ingredient__c = 'secondary');
        
        insert i1;
        insert i2;
        insert i3;
        insert i4;
        insert i5;
        insert i6;
        insert i7;
        insert i8;
        
        List<Ingredient__c> l1 = IngCont.grabIng('sec', 'T');
        List<Ingredient__c> l2 = IngCont.grabIng('2', 'PO');
        List<Ingredient__c> l3 = IngCont.grabIng('2', 'PU');
        List<Ingredient__c> l4 = IngCont.grabIng('', 'N');
        List<Ingredient__c> l5 = IngCont.grabIng('sjghkjshg', '');
        List<Ingredient__c> l6 = IngCont.grabIng('10', 'PO');

        Boolean t1 = false;
        Boolean t2 = false;
        Boolean t3 = false;
        Boolean t4 = false;
        Boolean t5 = false;
        Boolean t6 = false;
        

        if(l1.size() == 2){
            t1 = true;
        }
		System.debug(l2.size());
        if(l2.size() == 7){
            t2 = true;
        }

        if(l3.size() == 1){
            t3 = true;
        }

        if(l4.size() == 8){
            t4 = true;
        }

        if(l5.size() == 8){
            t5 = true;
        }

        if(l6.size() > 0){
            t6 = true;
        }

        System.assert(t1);
        System.assert(t2);
        System.assert(t3);
        System.assert(t4);
        System.assert(t5);

        System.assertNotEquals(t6, true);

        Test.stopTest();
    }
    
    @isTest
    public static void potTest(){
            Ingredient__c i1 = new Ingredient__c(Name = 'i1', Ingredient_Price__c = 1, Type_of_Ingredient__c = 'base');
            Ingredient__c i2 = new Ingredient__c(Name = 'i1', Ingredient_Price__c = 1, Type_of_Ingredient__c = 'secondary', Available_Potion__c = 'healing');
            
            insert i1;
            insert i2;
            
            Potion__c p = IngCont.savePotion(i1.Id, i2.Id, 'test', 'healing');
        	//Potion__c p2 = IngCont.savePotion(i1.Id, i2.Id, 'test2', 'heal');
            
            
            
            p = [SELECT id, Name FROM Potion__c WHERE Name = 'test'];
        	//p2 = [SELECT id, Name FROM Potion__c WHERE Name = 'test2'];
            
            Boolean b = false;
            if(p.Name == 'test'){
                b = true;
            }
        
        	//Boolean b2 = false;
            //if(p2.Name == 'test2'){
            //    b = true;
            //}
            
            System.Assert(b);
        	//System.assertNotEquals(b2, true);
            
            }
}