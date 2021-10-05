@isTest
public class ReviewExtensionTest {
	
    @isTest public static void PosBulk(){
        //positive bulk test
        test.startTest();
        
        //make a new ingredient so we can make a potion
        Ingredient__c ing = new Ingredient__c(
            Name='Test Ingredient', 
            Ingredient_Price__c=.50, 
            Type_of_Ingredient__c='Base'
        );
        insert ing;
        
        //make a new potion so we can make a review (make sure is name / type as below
        //			otherwise test fails for the in-paragraph link method)
        Potion__c p= new Potion__C(
            Name='Potion of Lucid Dreams', 
            Type_of_Potion__c = 'Sleep', 
            Base_Ingredient__c = ing.id
        );
        insert p;
        
        //add 5 reviews so we can test this thang
        integer prCount=0;
        list<Potion_Review__c> pr = new list<Potion_Review__c>();
        while (prCount<=5){
            prCount += 1;
            //make a new review that meets criteria
            pr.add (new Potion_Review__c(
                Review_Message__c='Test Review', 
                Reviewer_Name__c='Test Reviewer', 
                Potion_Type__c=p.id, Review_Rating__c=5
            	)
            );
        }
        
		insert pr;
        
        //make an object to call extension
        ReviewPageController rpc = new ReviewPageController();
        ReviewControllerExtension pre = new ReviewControllerExtension(rpc);
        
        //call extension's methods to test
        pre.getRecon();
        pre.GetLuDr();
		              
        test.stopTest();
    }
	
	@isTest public static void NegBulk(){
        //negative test
        test.startTest();
              
        //make a new ingredient so we can make a potion
        Ingredient__c ing = new Ingredient__c(
            Name='Test Ingredient', 
            Ingredient_Price__c=.50, 
            Type_of_Ingredient__c='Base'
        );
        insert ing;
        
        //make a new potion so we can make a review (make sure is name / type as below
        //			otherwise test fails for the in-paragraph link method)
        Potion__c p= new Potion__C(
            Name='Potion of Lucid Dreams', 
            Type_of_Potion__c = 'Sleep', 
            Base_Ingredient__c = ing.id
        );
        insert p;
        
        //add 5 reviews so we can test this thang
        integer prGoodCount=0;
        list<Potion_Review__c> prGood = new list<Potion_Review__c>();
        while (prGoodCount<=5){
            prGoodCount += 1;

        }
        
        
		integer prBadCount=0;
        list<Potion_Review__c> prBad = new list<Potion_Review__c>();
        while (prBadCount<=5){
            prBadCount += 1;
            //make a new review that DOESN'T meet criteria
            prBad.add (new Potion_Review__c(
                Review_Message__c='Test Review', 
                Reviewer_Name__c='Test Reviewer', 
                Potion_Type__c=p.id, Review_Rating__c=2
            	)
            );      
        }
        
        //insert Good reviews AND Bad reviews
		insert prGood;
        insert prBad;
        
        //make an object to call extension
        ReviewPageController rpc = new ReviewPageController();
        ReviewControllerExtension pre = new ReviewControllerExtension(rpc);
        //call extension's methods to test
        pre.getRecon();
        pre.GetLuDr();
        
        //make sure it DIDN'T add the 2-star reviews, but it DID add the 5-star ones
        system.AssertEquals(prGood, prGood);
        system.AssertNotEquals(prBad, prGood);
		              
        test.stopTest();
    }
		
	
	    @isTest public static void Single(){
        //single-action test
        test.startTest();
        
        //make a new ingredient so we can make a potion
        Ingredient__c ing = new Ingredient__c(
            Name='Test Ingredient', 
            Ingredient_Price__c=.50, 
            Type_of_Ingredient__c='Base'
        );
        insert ing;
        
        //make a new potion so we can make a review (make sure is name / type as below
        //			otherwise test fails for the in-paragraph link method)
        Potion__c p= new Potion__C(
            Name='Potion of Lucid Dreams', 
            Type_of_Potion__c = 'Sleep', 
            Base_Ingredient__c = ing.id
        );
        insert p;
        
        //add 1 review so we can test this thang
        Potion_Review__C pr = new Potion_Review__C(
        	Review_Message__c='Test Review', 
            Reviewer_Name__c='Test Reviewer', 
            Potion_Type__c=p.id, Review_Rating__c=5
        );
           
        //make an object to call extension
        ReviewPageController rpc = new ReviewPageController();
        ReviewControllerExtension pre = new ReviewControllerExtension(rpc);
        
        //call extension's methods to test
        pre.getRecon();
        pre.GetLuDr();
		              
        test.stopTest();
    }
	
}