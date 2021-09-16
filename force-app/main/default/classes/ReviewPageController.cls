public class ReviewPageController {
    
    // create a new review object to store new details to submit a new review from the page
    public Potion_Review__c newReview
    {
        get
        {
            if(newReview == null)
            {
                newReview = new Potion_Review__c();
            }
            return newReview;
        }
        set;
    }
    
    
    // instantiation of a set controller for standard list controller
    public ApexPages.StandardSetController setController
    {
        get
        {
            if(setController == null)
            {
                setController = new ApexPages.StandardSetController(Database.getQueryLocator(
                		[SELECT Name, Potion_Type__c, Potion_Type__r.Name, Review_Message__c, Review_Rating__c, Reviewer_Name__c FROM Potion_Review__c]
                		));
            }
            return setController;
        }
        set;
    }

    // custom constructor for the controller to retrieve list of all Potion Review records
    // and setup the newReview object
    public ReviewPageController()
    {
        setController = new ApexPages.StandardSetController(Database.getQueryLocator(
                [SELECT Name, Potion_Type__c, Potion_Type__r.Name, Review_Message__c, Review_Rating__c, Reviewer_Name__c FROM Potion_Review__c]
                ));
        newReview = new Potion_Review__c();
    }
    
    
    // initialize setController and return a list of all potion review records
    public List<Potion_Review__c> getPotionReviews()
    {
        return(List<Potion_Review__c>) setController.getRecords();
    }
    
    // method to save a new record and is called from a button press on page
    // input fields on page provide details
    public PageReference saveReview()
    {
        insert newReview;
        PageReference pref = new ApexPages.StandardController(newReview).view();
		return pref;
    }
}